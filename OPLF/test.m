function [MAPE, RMSE] = test(forecast, load_demand)
m = [];
r = [];
n = length(pred);
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
