function parameters = update_model(parameters, s, s0, DoW, HoD, lambdad, lambdar, lambdat, w)
L = length(s);
for i = 1:L
    % Weekday -> j = 1
    % Weekend or holiday -> j = 2
    [parameters.wt(HoD(i), 1), parameters.sigmat(HoD(i), 1), parameters.Pt(HoD(i), 1), parameters.gammat(HoD(i), 1)] = update_parameters(parameters.wt(HoD(i), 1), parameters.sigmat(HoD(i), 1), parameters.Pt(HoD(i), 1), 1, parameters.gammat(HoD(i), 1), lambdat, w(i));
    if DoW(i) >=2 && DoW(i) <=6
        j = 1;
    else
        j = 2;
    end
    if parameters.wt(HoD(i), 1) - w(i) > 20 && (w(i) > 80 || w(i) < 20)
        alpha1 = 1;
        alpha2 = 0;
    elseif parameters.wt(HoD(i), 1) - w(i) < - 20 && (w(i) > 80 || w(i) < 20)
        alpha1 = 0;
        alpha2 = 1;
    else
        alpha1 = 0;
        alpha2 = 0;
    end
    ud = [1, s0(i)]';
    [parameters.etad(:, HoD(i), j), parameters.sigmad(HoD(i), j), parameters.Pd(:, :, HoD(i), j), parameters.gammad(HoD(i), j)] = update_parameters(parameters.etad(:, HoD(i), j), parameters.sigmad(HoD(i), j), parameters.Pd(:, :, HoD(i), j), ud, parameters.gammad(HoD(i), j), lambdad, s(i));
    ur = [1, alpha1, alpha2]';
    [parameters.etar(:, HoD(i), j), parameters.sigmar(HoD(i), j), parameters.Pr(:, :, HoD(i), j), parameters.gammar(HoD(i), j)] = update_parameters(parameters.etar(:, HoD(i), j), parameters.sigmar(HoD(i), j), parameters.Pr(:, :, HoD(i), j), ur, parameters.gammar(HoD(i), j), lambdar, s(i));
end
end
