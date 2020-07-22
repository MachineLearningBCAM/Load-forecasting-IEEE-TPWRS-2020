# Online Probabilistic Load Forecasting (OPLF)

This repository contains code for the paper Online Probabilistic Load Forecasting. We use the implementation details described in the paper.

## Implementation of the method

OPLF folder contains all the files with Matlab scripts required to execute the method:

* OPLF.m is the main file. We input the data and the prediction horizon and it returns the predictions, the RMSE and the MAPE.
* initialize.m is the function that inizialize the model parameters.
* prediction.m returns at load forecasts and probabilistic load forecasts in form of mean and standard deviation of a Gaussian distribution for the given instance vector.
* test.m quantifies the prediction errors RMSE and MAPE.
* update_model.m updates the model for each new training sample.
* update_parameters.m updates each parameter of the model.

This repository also contains the Python code and a Jupyter notebook.

## Data

We use publicly available data and we save it in a .mat file that contains:

* Hourly load time series
* Temperature time series
* Date and hour or timestamp when the load is measure

## Test case

We display in this reposity an example for a dataset that contains load data of 400 buildings. We describe this dataset in the paper. The implementation details are the same for every dataset.
