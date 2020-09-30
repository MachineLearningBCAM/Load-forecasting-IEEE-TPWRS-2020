# Example

We forecast load for [400 buildings](https://data.mendeley.com/datasets/zm4f727vvr/1#file-a01cdaa0-340d-4ebf-8fe5-c59a53d8f6b0). The dataset contains electricity load data for 6031 residential customers in NEW South Wales for the calendar year 2013. We forecast the mean of load for 400 buildings.

We execute the following code in Matlab language

```
# Input
load('400buildings.mat')
days_training = 300; 
lambdas = 0.2; # Forgetting factor
lambdar = 0.7; # Forgetting factor
L = 24; # Prediction horizon
C = 48; # Calendar types
R = 3; # Length of feature vector that represents observations
[RMSE, MAPE, load_forecasts, load_demand, estimated_errors] = APLF(data, days_training, lambdas, lambdar, L, C, R);
```

We obtain that 

```
RMSE = 0.03;
MAPE = 6.27;
```

We plot one week of load demand, load forecasts, and estimated errors

![alt text](../docs/images/predictions.png)

We show the CDF of error

![alt text](../docs/images/CDF.png)
