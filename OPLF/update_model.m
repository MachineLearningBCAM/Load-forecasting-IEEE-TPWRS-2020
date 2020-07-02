function [Theta, Gamma] = update_model(Theta, Gamma, y, s0, c, lambdad, lambdar, w)
% y vector of new loads
% x = [s0, w, wt]; (wt is included in Theta is updated in this step)
L = length(y);
y = [s0, y];
for i = 1:L
    % Mean of temperatures
    [Theta.wt(c(i)), Theta.sigmat(c(i)), Gamma.Pt(c(i)), Gamma.gammat(c(i))] = update_parameters(Theta.wt(c(i)), Theta.sigmat(c(i)), Gamma.Pt(c(i)), 1, Gamma.gammat(c(i)), 1, w(i));
    if Gamma.wt(c(i)) - w(i) > 20 && (w(i) > 80 || w(i) < 20)
        alpha1 = 1;
        alpha2 = 0;
    elseif Theta.wt(c(i)) - w(i) < - 20 && (w(i) > 80 || w(i) < 20)
        alpha1 = 0;
        alpha2 = 1;
    else
        alpha1 = 0;
        alpha2 = 0;
    end
    ud = [1, y(i-1)]';
    [Theta.etad(:, c(i)), Theta.sigmad(c(i)), Gamma.Pd(:, :, c(i)), Gamma.gammad(c(i))] = update_parameters(Theta.etad(:, c(i)), Theta.sigmad(c(i)), Gamma.Pd(:, :, c(i)), ud, Gamma.gammad(c(i)), lambdad, y(i));
    ur = [1, alpha1, alpha2]';
    [Theta.etar(:, c(i)), Theta.sigmar(c(i)), Gamma.Pr(:, :, c(i)), Gamma.gammar(c(i))] = update_parameters(Theta.etar(:, c(i)), Theta.sigmar(c(i)), Gamma.Pr(:, :, c(i)), ur, Gamma.gammar(c(i)), lambdar, y(i));
end
end
