function [eta, sigma, P, gamma] = update_parameters(eta, sigma, P, gamma, lambda, s, u)
% This function updates recursively parameters eta and sigma and the state
% variables P and gamma
% u is the feature vector
% lambda is the forgetting factor
% s is the load
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
