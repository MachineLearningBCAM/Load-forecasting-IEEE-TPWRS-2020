function [RMSE, MAPE, predictions, load_demand] = OPLF(data, days_train, lambdad, lambdar, L, C, R)
n = length(data.consumption);
% Initialize the model
n_train = 24*days_train;
[Theta, Gamma] = initialize(C, R);
predictions = [];
standard_deviation = [];
load_demand = [];
for i = 1:L:n_train-L
    [Theta, Gamma] = update_model(Theta, Gamma, data.consumption(i+1:i+L), data.consumption(i), data.c(i+1:i+L), lambdad, lambdar, data.temperature(i+1:i+L));
end
for j = i+L:L:n - L
    % Prediction
    s0 = data.consumption(j);
    w = data.temperature(j+1:j+L);
    x = [s0, w]; % wt is included in Theta
    [pred_s, e] = prediction(Theta, x, data.c(j+1:j+L));  % L Load forecasts and probabilistic load forecasts
    predictions = [predictions, pred_s'];
    standard_deviation = [standard_deviation, e'];
    load_demand = [load_demand, data.consumption(j+1:j+L)'];
    % Learning
    [Theta, Gamma] = update_model(Theta, Gamma, data.consumption(j+1:j+L), data.consumption(j), data.c(j+1:j+L), lambdad, lambdar, data.temperature(j+1:j+L));
end
% Test
[MAPE, RMSE] = test(predictions, load_demand);
end
