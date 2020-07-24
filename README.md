# Online Probabilistic Load Forecasting (OPLF)

This repository contains code for the paper Online Probabilistic Load Forecasting [[1]](#1). We use the implementation details described in the paper.

![grab-landing-page](predictions.gif)

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

We display in this reposity an example for a dataset that contains load data of [400 buildings](https://data.mendeley.com/datasets/zm4f727vvr/1#file-a01cdaa0-340d-4ebf-8fe5-c59a53d8f6b0). More details of the dataset are given in the [Example folder](/Example).

## Citation

If you find useful the code in your research, please include explicit mention of our work in your publication with the following corresponding entries in your bibliography:

<a id="1">[1]</a> 
V. Alvarez, S. Mazuelas, J.A. Lozano.
"Online Probabilistic Load Forecasting,"
*Submitted to IEEE-Transactions on Power Systems.* 2020.

The corresponding BiBTeX citation is given below:

```
@article{alvarez2020online,
  title={Online Probabilistic Load Forecasting},
  author={Alvarez, Verónica and Mazuelas, Santiago and Lozano, José Antonio},
  journal={Submitted to IEEE Transactions on Power Systems},
  year={2020},
  publisher={IEEE}
}
```
