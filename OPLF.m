function [RMSE, MAPE, predictions, load_demand] = OPLF(data, days_train, lambdad, lambdar, lambdat, L)
n = length(data.consumption);
% Initialize the model
n_train = 24*days_train;
parameters = initialize(24, 2);
predictions = [];
load_demand = [];
for i = 1:L:n_train-L
    parameters = update_model(parameters, data.consumption(i+1:i+L), data.consumption(i:i+L-1), data.DoW(i+1:i+L), data.HoD(i+1:i+L), lambdad, lambdar, lambdat, data.temperature(i+1:i+L));
end
for j = i+L:L:n - L
    % Prediction
    s0 = data.consumption(j);
    [pred_s, ~] = prediction(s0, parameters.etad(:, :, :), parameters.sigmad(:, :, :), parameters.etar(:, :, :), parameters.sigmar(:, :, :), data.DoW(j+1:j+L), data.HoD(j+1:j+L), parameters.wt(:, 1), data.temperature(j+1:j+L));
    predictions = [predictions, pred_s'];
    load_demand = [load_demand, data.consumption(j+1:j+L)'];
    % Learning
    parameters = update_model(parameters, data.consumption(j+1:j+L), data.consumption(j:j+L-1), data.DoW(j+1:j+L), data.HoD(j+1:j+L), lambdad, lambdar, lambdat, data.temperature(j+1:j+L));
end
% Test
[MAPE, RMSE] = test(predictions, load_demand);
end
