function parameters = initialize(cHoD, cDoW)
% Initialize the parameters
parameters.etad = zeros(2, cHoD, cDoW);
parameters.sigmad = zeros(cHoD, cDoW);
parameters.gammad = ones(cHoD, cDoW);
parameters.etar = zeros(3, cHoD, cDoW);
parameters.sigmar = zeros(cHoD, cDoW);
parameters.gammar = ones(cHoD, cDoW);
for i = 1:cHoD
    parameters.Pd(:, :, i, 1) = eye(2);
    parameters.Pd(:, :, i, 2) = eye(2);
    parameters.Pr(:, :, i, 1) = eye(3);
    parameters.Pr(:, :, i, 2) = eye(3);
end
% Mean of the temperature
parameters.wt = zeros(cHoD, 1);
parameters.sigmat = zeros(cHoD, 1);
parameters.gammat = ones(cHoD, 1);
parameters.Pt = ones(cHoD, 1);
end
