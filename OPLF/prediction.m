function [pred_s, e] = prediction(Theta, x, C)
% Theta is the list of model parameters
% x = [s0, w]; instance vector (wt is included in Theta)
% C is the calendar information
L = length(x)-1; % Prediction horizon
pred_s = zeros(L+1, 1); % Predictions
e = zeros(L+1, 1); % Estimated errors
pred_s(1, 1) = x(1); 
w = x(2:end); % temperature
for i=2:L+1
    c = C(i-1);
    % Feature vector that represents load
    ud = [1, pred_s(i-1)]';
    % Feature vector that represents observations
if Theta.wt(c) - w(i-1) > 20 && (w(i-1) > 80 || w(i-1) < 20)
    alpha1 = 1;
    alpha2 = 0;
elseif Theta.wt(c) - w(i-1) < - 20 && (w(i-1) > 80 || w(i-1) < 20)
    alpha1 = 0;
    alpha2 = 1;
else
    alpha1 = 0;
    alpha2 = 0;
end
    ur = [1, alpha1, alpha2]';
    % Predictions
    pred_s(i, 1) = (ud'*Theta.etad(:, c)*Theta.sigmar(c)^2 + ur'*Theta.etar(:, c)*(Theta.sigmad(c)^2 + ([0, 1]*Theta.etad(:, c))^2*e(i-1, 1)))/(Theta.sigmar(c)^2 + Theta.sigmad(c)^2 + ([0, 1]*Theta.etad(:, c))^2*e(i-1, 1));
    e(i,1) = sqrt(((Theta.sigmad(c)^2 + ([0, 1]*Theta.etad(:, c))^2*e(i-1, 1))*Theta.sigmar(c)^2)/(Theta.sigmar(c)^2 + Theta.sigmad(c)^2 + ([0, 1]*Theta.etad(:, c))^2*e(i-1, 1)));
end
pred_s(1) = [];
e(1) = [];
end
