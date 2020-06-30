function [eta, sigma, P, gamma] = update_parameters(eta, sigma, P, u, gamma, lambda, s)
P = (1/lambda)*(P - (P*u*u'*P)/(lambda + u'*P*u));
gamma = 1 + lambda*gamma;
sigma = sqrt(sigma^2 - (1/gamma)*(sigma^2 - lambda*(s - u'*eta)^2)/(lambda + u'*P*u));
eta = eta + (P*u/(lambda + u'*P*u))*(s - u'*eta);
end
