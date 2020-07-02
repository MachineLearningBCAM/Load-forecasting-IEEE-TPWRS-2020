function [Theta, Gamma] = initialize(C, R)
% C length of calendar information
% Length of feature vector representation of observations
% Initialize the parameters
Theta.etad = zeros(2, C);
Theta.sigmad = zeros(C);
Gamma.gammad = ones(C);
Theta.etar = zeros(R, C);
Theta.sigmar = zeros(C);
Gamma.gammar = ones(C);
for i = 1:C
    Gamma.Pd(:, :, C) = eye(2);
    Gamma.Pr(:, :, C) = eye(R);
end
% Mean of the temperature
Theta.wt = zeros(C);
Theta.sigmat = zeros(C);
Gamma.gammat = ones(C);
Gamma.Pt = ones(C);
end
