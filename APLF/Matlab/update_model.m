function [Theta, Gamma] = update_model(Theta, Gamma, y, x, c, lambdad, lambdar)
% 
% This file includes code for the paper Probabilistic Load Forecasting based on Adaptive Online Learning. 
% @author: Verónica Álvarez
% 
% This function updates model parameters and state variables
% 
% Inputs 
    % Theta is the list of model parameters
    % Gamma is the list of state variables
    % y is the vector of new loads
    % x = [s0, w] is the instance vector (wt is included in Theta is updated in this step)
    % c is the calendar information
    % lambdad, lambdar forgetting factors
%
% Outputs
    % Theta is the updated list of model parameters
    % Gamma is the updated list of state variables
%
% Prediction horizon
s0 = x(1);
w = x(2:end);
L = length(y);
y = [s0, y'];
for i = 1:L
    % Update the mean of temperatures with the forgetting factor lambda = 1 and the
    % feature vector u = 1
    [Theta.wt(c(i)), Theta.sigmat(c(i)), Gamma.Pt(c(i)), Gamma.gammat(c(i))] = update_parameters(Theta.wt(c(i)), Theta.sigmat(c(i)), Gamma.Pt(c(i)), Gamma.gammat(c(i)), 1, w(i), 1);
    % Dummy varibles
    if Theta.wt(c(i)) - w(i) > 20 && (w(i) > 80 || w(i) < 20)
        alpha1 = 1;
        alpha2 = 0;
    elseif Theta.wt(c(i)) - w(i) < - 20 && (w(i) > 80 || w(i) < 20)
        alpha1 = 0;
        alpha2 = 1;
    else
        alpha1 = 0;
        alpha2 = 0;
    end
    % Feature vector that represents load
    ud = [1, y(i)]';
    % Update parameters denoted by d
    [Theta.etad(:, c(i)), Theta.sigmad(c(i)), Gamma.Pd(:, :, c(i)), Gamma.gammad(c(i))] = update_parameters(Theta.etad(:, c(i)), Theta.sigmad(c(i)), Gamma.Pd(:, :, c(i)), Gamma.gammad(c(i)), lambdad, y(i+1), ud);
    % Feature vector that represents observations
    ur = [1, alpha1, alpha2]';
    % Update parameters denoted by r
    [Theta.etar(:, c(i)), Theta.sigmar(c(i)), Gamma.Pr(:, :, c(i)), Gamma.gammar(c(i))] = update_parameters(Theta.etar(:, c(i)), Theta.sigmar(c(i)), Gamma.Pr(:, :, c(i)), Gamma.gammar(c(i)), lambdar, y(i+1), ur);
end
end
