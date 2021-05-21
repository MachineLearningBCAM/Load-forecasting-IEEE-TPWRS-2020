function [MAPE, RMSE] = test(forecast, load_demand)
% 
% This file includes code for the paper Probabilistic Load Forecasting based on Adaptive Online Learning. 
% @author: Verónica Álvarez
% 
% This function quantifies the prediction errors root mean square error (RMSE) and mean average percentage error (MAPE)
% 
% Inputs 
    % Forecast is a vector of load forecasts
    % load_demand is a vector of load corresponding with load forecasts
%
% Outputs
    % MAPE
    % RMSE
%
m = [];
r = [];
n = length(forecast);
for i = 1:n
    if load_demand(i) > 0
        % MAPE
        m(i) = abs((load_demand(i) - forecast(i))/load_demand(i));
        % RMSE
        r(i) = (load_demand(i) - forecast(i))^2;
    end
end
MAPE = 100*nanmean(m);
RMSE = sqrt(nanmean(r));
end
