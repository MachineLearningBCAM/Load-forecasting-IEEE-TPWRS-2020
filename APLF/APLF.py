# -*- coding: utf-8 -*-
"""
Code for the paper Probabilistic Load Forecasting based on Adaptive Online Learning
@author: Verónica Álvarez
"""
import numpy as np
from scipy.io import loadmat  # this is the SciPy module that loads mat-files
import matplotlib.pyplot as plt
from datetime import datetime, date, time
import csv
#import pandas as pd
# data in .mat file
path = '../Example/'
# os.chdir(path)
filename = '400buildings.mat'
mat = loadmat(path + filename)  # load mat-file
mdata = mat['data']  # variable in mat file
mdtype = mdata.dtype 
data = {n: mdata[n][0, 0] for n in mdtype.names}

# [MAPE, RMSE, predictions, load_demand, estimated_errors] = APLF(data, 300, 0.2, 0.7, 24, 48, 3)

def initialize(C, R):
  # initialize parameters
  import numpy as np
  class Theta:
    pass
  class Gamma:
    pass
  a = Theta()
  a.etad = np.zeros((2, C))
  a.sigmad = np.zeros((1, C))
  a.etar = np.zeros((R, C))
  a.sigmar = np.zeros((1, C))
  a.wt = np.zeros((1, C))
  a.sigmat = np.zeros((1, C))
  b = Gamma()
  b.gammat = np.zeros((1, C))
  b.Pt = np.zeros((1, C))
  b.gammad = np.zeros((1, C))
  b.gammar = np.zeros((1, C))
  b.Pd = np.zeros((C, 2, 2))
  b.Pr = np.zeros((C, R, R))
  for i in range(C):
    b.Pd[i] = np.eye(2)
    b.Pr[i] = np.eye(R)
  return a, b

def update_parameters(eta, sigma, P, gamma, l, s, u):
  import numpy
  if np.size(P) > 1:
    if P.trace() > 10:
      P = np.eye(len(P))
    P = (1/l)*(P - (np.dot(np.dot(np.dot(P, u), u.T), P)/(l + np.dot(np.dot(u.T, P),u))))
    gamma = 1 + l*gamma
    sigma = np.sqrt(sigma**2 - (1/gamma)*(sigma**2 - l*(s - np.dot(eta,u))**2)/(l + np.dot(np.dot(u.T, P),u)))
    eta = eta + (s - np.dot(u.T, eta))*np.dot(P, u).T[0]/(l + np.dot(np.dot(u.T, P),u))
  else:
    if P > 10:
      P = 1
    P = (1/l)*(P - (P*u*np.transpose(u)*P)/(l + np.transpose(u)*P*u))
    gamma = 1 + l*gamma
    sigma = np.sqrt(sigma**2 - (1/gamma)*(sigma**2 - l*(s - u*eta)**2)/(l + u*P*u))
    eta = eta + (P*u/(l + u*P*u))*(s - u*eta)
  return eta.T, sigma, P, gamma

def test(predictions, load_demand):
  n = len(predictions)
  m = np.zeros(n)
  r = np.zeros(n)
  for i in range(n):
    m[i] = np.abs(predictions[i] - load_demand[i])/load_demand[i]
    r[i] = (predictions[i] - load_demand[i])**2
  MAPE = 100*np.nanmean(m)
  RMSE = np.sqrt(np.nanmean(r))
  return MAPE, RMSE

def update_model(Theta, Gamma, y, x, c, lambdad, lambdar):
  s0 = x[0]
  w = x[1:]
  L = len(y)
  y = [s0, y[0:]]
  for i in range(L):
    [Theta.wt[0][c[i]], Theta.sigmat[0,c[i]], Gamma.Pt[0,c[i]], Gamma.gammat[0,c[i]]] = update_parameters(Theta.wt[0,c[i][0]], Theta.sigmat[0,c[i][0]], Gamma.Pt[0,c[i][0]], Gamma.gammat[0, c[i][0]], 1, w[0][i][0], 1)
    if Theta.wt[0][c[i]] - w[0][i][0] > 20 and (w[0][i][0] > 80 or w[0][i][0] < 20):
      alpha1 = 1
      alpha2 = 0
    elif Theta.wt[0][c[i]] - w[0][i][0] < -20 and (w[0][i][0] > 80 or w[0][i][0] < 20):
      alpha1 = 0
      alpha2 = 1
    else:
      alpha1 = 0
      alpha2 = 0
    ud = np.ones((2, 1))
    ud[1, 0] = y[1][i][0]
    [Theta.etad[0:, c[i]], Theta.sigmad[0, c[i][0]], Gamma.Pd[c[i][0]], Gamma.gammad[0, c[i][0]]] = update_parameters(Theta.etad[0:, c[i][0]], Theta.sigmad[0, c[i][0]], Gamma.Pd[c[i][0]], Gamma.gammad[0, c[i][0]], lambdad, y[1][i], ud)
    ur = np.ones((3, 1))
    ur[1, 0] = alpha1
    ur[2, 0] = alpha2
    [Theta.etar[0:, c[i]], Theta.sigmar[0][c[i]], Gamma.Pr[c[i][0]], Gamma.gammar[0][c[i]]] = update_parameters(Theta.etar[0:, c[i][0]], Theta.sigmar[0][c[i][0]], Gamma.Pr[c[i][0]], Gamma.gammar[0][c[i][0]], lambdar, y[1][i], ur)
  return Theta, Gamma

def prediction(theta, x, C):
  # prediction function
  L = len(x[1])
  pred_s = np.zeros((L+1, 1))
  e = np.zeros((L+1, 1))
  pred_s[0, 0] = x[0]
  w = x[1:]
  for i in range(L):
    c = C[i]
    ud = [1, pred_s[i, 0]]
    ud = np.transpose(ud)
    if theta.wt[0][c] - w[0][i][0] > 20 and (w[0][i][0] > 80 or w[0][i][0] < 20):
      alpha1 = 1
      alpha2 = 0
    elif theta.wt[0][c] - w[0][i][0] < -20 and (w[0][i][0] > 80 or w[0][i][0] < 20):
      alpha1 = 0
      alpha2 = 1
    else:
      alpha1 = 0
      alpha2 = 0
    ur = np.transpose([1, alpha1, alpha2])
    pred_s[i+1, 0] = (np.dot(np.transpose(ud), theta.etad[0:, c])*theta.sigmar[0][c]**2 + np.dot(np.transpose(ur), theta.etar[0:, c])*(theta.sigmad[0][c]**2 + np.dot(np.dot([0, 1], theta.etad[0:, c])**2, e[i]**2)))/(theta.sigmar[0][c]*theta.sigmar[0][c] + theta.sigmad[0][c]**2 + np.dot((np.dot([0, 1], theta.etad[0:, c])**2),e[i]**2))
    e[i+1, 0] = np.sqrt((theta.sigmar[0][c]**2 * (theta.sigmad[0][c]**2 + np.dot(np.dot(np.dot([0, 1], theta.etad[0:, c])**2, e[i]**2)))/(theta.sigmar[0][c]**2 + theta.sigmad[0][c]**2 + np.dot(np.dot([0, 1], theta.etad[0:, c])**2, e[i]**2))
  return pred_s[1:], e[1:]

# def APLF(data, days_train, lambdad, lambdar, L, C, R):
  # [MAPE, RMSE, predictions, load_demand, estimated_errors] = APLF(data, 300, 0.2, 0.7, 24, 48, 3)
  # days_train > 1 number of training days
days_train = 300
lambdad = 0.2 # forgetting factor
lambdar = 0.7 # forgetting factor
L = 24 # prediction horizon (hours)
C = 48 # length of the calendar information
R = 3 # length of feature vector of observations
n = len(data.get('consumption'))
consumption = data.get('consumption')
ct = data.get('c')
ct = ct - 1
temperature = data.get('temperature')
n_train = 24*days_train
[Theta, Gamma] = initialize(C, R)
predictions = []
estimated_errors = []
load_demand = []
for i in range(n_train - L+1):
  s0 = consumption[i]
  w = temperature[i+1:i+L+1]
  x = [s0, w]
  y = consumption[i+1:i+L+1]
  cal = ct[i+1:i+L+1]
  [Theta, Gamma] = update_model(Theta, Gamma, y, x, cal, lambdad, lambdar)
for j in range(i+L+1, n-L, L):
  s0 = consumption[j]
  w = temperature[j+1:j+L+1]
  x = [s0, w]
  [pred_s, e] = prediction(Theta, x, ct[j+1:j+L+1])
  predictions = np.append(predictions, np.transpose(pred_s))
  estimated_errors = np.append(estimated_errors, np.transpose(e))
  y = consumption[j+1:j+L+1]
  load_demand = np.append(load_demand, np.transpose(y))
  [Theta, Gamma] = update_model(Theta, Gamma, y, x, ct[j+1:j+L+1], lambdad, lambdar)
[MAPE, RMSE] = test(predictions, load_demand)
print('MAPE = ', MAPE)
print('RMSE = ', RMSE)
with open('results.csv', 'w+') as file:
    writer = csv.writer(file)
    writer.writerow(("predictions", "load demand", "estimated errors"))
    rcount = 0
    for i in range(len(predictions)):
        writer.writerow((predictions[i], load_demand[i], estimated_errors[i]))
        rcount = rcount + 1
    file.close()

#  return MAPE, RMSE, predictions, load_demand, estimated_errors
