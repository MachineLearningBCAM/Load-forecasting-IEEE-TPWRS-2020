function [pred_s, e] = prediction(s0, etad, sigmad, etar, sigmar, DoW, HoD, wt, w)
L = length(DoW);
pred_s = zeros(L+1, 1); % Predictions
e = zeros(L+1, 1); % Estimated errors
pred_s(1, 1) = s0;
for i=2:L+1
    % Weekday -> j = 1
    % Weekend or holiday -> j = 2
    if DoW(i-1) >=2 && DoW(i-1) <=6
        j = 1;
    else
        j = 2;
    end
    h = HoD(i-1);
    ud = [1, pred_s(i-1)]';
if wt(HoD(i-1), 1) - w(i-1) > 20 && (w(i-1) > 80 || w(i-1) < 20)
    alpha1 = 1;
    alpha2 = 0;
elseif wt(HoD(i-1), 1) - w(i-1) < - 20 && (w(i-1) > 80 || w(i-1) < 20)
    alpha1 = 0;
    alpha2 = 1;
else
    alpha1 = 0;
    alpha2 = 0;
end
ur = [1, alpha1, alpha2]';
    pred_s(i, 1) = (ud'*etad(:, h, j)*sigmar(h, j)^2 + ur'*etar(:, h, j)*(sigmad(h, j)^2 + ([0, 1]*etad(:, h, j))^2*e(i-1, 1)))/(sigmar(h, j)^2 + sigmad(h, j)^2 + ([0, 1]*etad(:, h, j))^2*e(i-1, 1));
    e(i,1) = sqrt(((sigmad(h, j)^2 + ([0, 1]*etad(:, h, j))^2*e(i-1, 1))*sigmar(h, j)^2)/(sigmar(h, j)^2 + sigmad(h, j)^2 + ([0, 1]*etad(:, h, j))^2*e(i-1, 1)));
end
pred_s(1) = [];
e(1) = [];
end
