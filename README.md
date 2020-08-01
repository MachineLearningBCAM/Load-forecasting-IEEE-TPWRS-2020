# Probabilistic Load Forecasting based on Adaptive Online Learning (APLF)
This repository contains code for the paper Probabilistic Load Forecasting based on Adaptive Online Learning [[1]](#1). We use the implementation details described in the paper.

![grab-landing-page](predictions.gif)

## Implementation of the method

APLF folder contains all the files with Matlab scripts required to execute the method:

* OPLF.m is the main file.
* initialize.m function inizializes model parameters.
* prediction.m function obtain load forecasts and probabilistic load forecasts in form of mean and standard deviation of a Gaussian density function.
* test.m function quantifies the prediction errors RMSE and MAPE.
* update_model.m function updates the model for each new training sample.
* update_parameters.m function updates model parameters.

This repository also contains the Python code and a Jupyter notebook.

## Data

We use 7 publicly available datasets corresponding with regions that have different sizes. The datasets are:

> [Load demand in Belgium from 2017-2019 made available by Elia group.](https://www.elia.be/en/grid-data/data-download-page)  
[Load demand in New England from 2003-2014 made available by ISO-NE organization.](https://www.iso-ne.com/isoexpress/web/reports/load-and-demand/-/tree/historical-hourly-flows-and-limits)  
[Global Energy forecasting Competition 2012 dataset from 2004-2007.](http://blog.drhongtao.com/2016/07/gefcom2012-load-forecasting-data.html)  
[Global Energy Forecasting Competition 2014 dataset from 2005-2011.](http://blog.drhongtao.com/2017/03/gefcom2014-load-forecasting-data.html)  
[Load demand in Dayton from 2004-2016 made available by PJM interconnection.](https://www.pjm.com/markets-and-operations/data-dictionary.aspx)  
[Load demand for 400 buildings in New South Wales from 2013 made available by the Australian Government.](http://dx.doi.org/10.17632/zm4f727vvr.1#file-a01cdaa0-340d-4ebf-8fe5-c59a53d8f6b0)  
[Load demand for 100 buildings in New South Wales from 2013 made available by the Australian Government.](http://dx.doi.org/10.17632/zm4f727vvr.1#file-a01cdaa0-340d-4ebf-8fe5-c59a53d8f6b0)

We save the data in .mat files that contain a struct with following fields:

* Hourly load time series
* Temperature time series
* Date and hour or timestamp when the load is measure

## Test case

We display in this reposity an example for a dataset that contains load data of [400 buildings](https://data.mendeley.com/datasets/zm4f727vvr/1#file-a01cdaa0-340d-4ebf-8fe5-c59a53d8f6b0). [Example folder](/Example) includes more details of the dataset, commands to execute the code, and results.

## Citation

If you find useful the code in your research, please include explicit mention of our work in your publication with the following corresponding entry in your bibliography:

<a id="1">[1]</a> 
V. Alvarez, S. Mazuelas, J.A. Lozano.
"Probabilistic Load Forecasting based on Adaptive Online Learning,"
*Submitted to IEEE-Transactions on Power Systems.* 2020.

The corresponding BiBTeX citation is given below:

```
@article{alvarez2020online,
  title={Probabilistic Load Forecasting based on Adaptive Online Learning},
  author={Alvarez, Verónica and Mazuelas, Santiago and Lozano, José Antonio},
  journal={Submitted to IEEE Transactions on Power Systems},
  year={2020},
  publisher={IEEE}
}
```
