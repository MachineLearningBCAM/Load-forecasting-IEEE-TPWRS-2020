% 
% This file includes code for the paper Online Probabilistic Load Forecasting. 
% @author: Verónica Álvarez
% 
function [RMSE, MAPE, predictions, load_demand, estimated_errors] = OPLF(data, days_train, lambdad, lambdar, L, C, R)
% [RMSE, MAPE, predictions, load_demand, estimated_errors] = OPLF(data, 1, 0.2, 0.7, 24, 48, 3);
%
% Inputs
    % data is a Matlab struct such that:
        % data.consumption is load demand
        % data.temperature is the temperature
        % data.c is the calendar information
    % days_train > 1 is the number of days that we will use for training
    % lambdad = 0.2 forgetting factor 
    % lambdar = 0.7 forgetting factor
    % L = 24 is the prediction horizon
    % C = 48 is the length of the calendar information
    % R = 3 is the length of the feature representation of observations
% 
% Outputs
    % RMSE is the root mean square error
    % MAPE is the mean average percentage error
    % predictions are load forecasts
    % load_demand are real loads corresponding with load forecasts
    % estimated_errors are the estimatation of the accuracy of load forecasts
%
% The mean of the temperatures that is included in the instance vector is
% updated together with model parameters
% Number of samples
n = length(data.consumption);
% Number of hours that we will use for training
n_train = 24*days_train;
% Initialize the model (model parameters and state variables)
[Theta, Gamma] = initialize(C, R);
predictions = [];
estimated_errors = [];
load_demand = [];
n0 = 12;
for i = 1:L:n_train-L
    s0 = data.consumption(i);
    w = data.temperature(i+1:i+L);
    x = [s0, w']; % instance vector, wt is included in Theta
    y = data.consumption(i+1:i+L);
    [Theta, Gamma] = update_model(Theta, Gamma, y, x, data.c(i+1:i+L), lambdad, lambdar);
end
for j = i+L+1:L:n - L
    s0 = data.consumption(j);
    w = data.temperature(j+1:j+L);
    x = [s0, w']; % instance vector, wt is included in Theta
    % Prediction
    [pred_s, e] = prediction(Theta, x, data.c(j+1:j+L));  % L Load forecasts and probabilistic load forecasts
    predictions = [predictions, pred_s']; % List of load forecasts
    estimated_errors = [estimated_errors, e']; % List of estimated errors
    % Learning (update model parameters and state variables)
    y = data.consumption(j+1:j+L);
    load_demand = [load_demand, y']; % List of load demand 
    [Theta, Gamma] = update_model(Theta, Gamma, y, x, data.c(j+1:j+L), lambdad, lambdar);
end
% Prediction errors
[MAPE, RMSE] = test(predictions, load_demand);
end
