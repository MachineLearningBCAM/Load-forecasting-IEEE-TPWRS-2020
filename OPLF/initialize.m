function [Theta, Gamma] = initialize(C, R)
% C length of calendar information
% R is the length of feature vector representation of observations
% Initialize model parameters and state variables for each calendar type c = 1, 2, ..., C
% For each c, etad is a vector with length 2
Theta.etad = zeros(2, C); 
Theta.sigmad = zeros(1, C);
Gamma.gammad = ones(1, C);
% For each c, etad is a vector with length R
Theta.etar = zeros(R, C);
Theta.sigmar = zeros(1, C);
Gamma.gammar = ones(1, C);
for i = 1:C
    Gamma.Pd(:, :, i) = eye(2);
    Gamma.Pr(:, :, i) = eye(R);
end
% Mean of the temperature
Theta.wt = zeros(1, C);
Theta.sigmat = zeros(1, C);
Gamma.gammat = ones(1, C);
Gamma.Pt = ones(1, C);
end
