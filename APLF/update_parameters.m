function [eta, sigma, P, gamma] = update_parameters(eta, sigma, P, gamma, lambda, s, u)
% 
% This file includes code for the paper Probabilistic Load Forecasting based on Adaptive Online Learning. 
% @author: Verónica Álvarez
% 
% This function updates recursively each parameter and each state variable
%
% Inputs
    % eta
    % sigma
    % P
    % gamma
    % lambda is the forgetting factor
    % u is the feature vector
    % s is the load
% 
% Outputs
    % eta is the updated eta parameter
    % sigma is the updated sigma parameter
    % P is the updated state variable P
    % gamma is the updated state variable gamma
%
% Avoid possible inestabilities of matrix P
if trace(P) > 10
    P = eye(length(P));
end
% Update matrix P
P = (1/lambda)*(P - (P*u*u'*P)/(lambda + u'*P*u));
% Update gamma
gamma = 1 + lambda*gamma;
% Update sigma
sigma = sqrt(sigma^2 - (1/gamma)*(sigma^2 - lambda*(s - u'*eta)^2)/(lambda + u'*P*u));
% Update eta
eta = eta + (P*u/(lambda + u'*P*u))*(s - u'*eta);
end
