# Probabilistic Load Forecasting based on Adaptive Online Learning (APLF)

[![GitHub license](https://img.shields.io/badge/License-MIT-blue)](https://github.com/VeronicaAlvarez/online-probabilistic-load-forecasting/blob/master/LICENSE) [![Made with!](https://img.shields.io/badge/Made%20with-MATLAB-red)](APLF/Matlab) [![made-with-python](https://img.shields.io/badge/Made%20with-Python-1f425f.svg)](APLF/APLF.py) [![Made with!](https://img.shields.io/badge/Made%20with-Jupyter%20Notebook-orange)](APLF/APLF.ipynb) [![Ask Me Anything !](https://img.shields.io/badge/Ask%20me-anything-1abc9c.svg)](#support-and-author)

This repository contains code for the paper Probabilistic Load Forecasting based on Adaptive Online Learning [[1]](#1). We use the implementation details described in the paper.

![grab-landing-page](docs/images/predictions.gif)

## Implementation of the method

APLF folder contains the [Python file](APLF/APLF.py), a [Jupyter notebook](APLF/APLF.ipynb) and a [Matlab folder](APLF/Matlab) that contains all the Matlab scripts required to execute the method:

* APLF.m is the main file.
* initialize.m function inizializes model parameters.
* prediction.m function obtain load forecasts and probabilistic load forecasts in form of mean and standard deviation of a Gaussian density function.
* test.m function quantifies the prediction errors RMSE and MAPE.
* update_model.m function updates the model for each new training sample.
* update_parameters.m function updates model parameters.

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

## Installation

```console
git clone https://github.com/VeronicaAlvarez/online-probabilistic-load-forecasting
```

Running python code:
```console
cd online-probabilistic-load-forecasting\APLF
python APLF.py
```


## Test case

We display in this reposity an example for a dataset that contains load data of [400 buildings](https://data.mendeley.com/datasets/zm4f727vvr/1#file-a01cdaa0-340d-4ebf-8fe5-c59a53d8f6b0). [Example folder](/Example) includes more details of the dataset, commands to execute the code, and results.

## Support and Author

Verónica Álvarez Castro

veronicaalvcas@gmail.com

[![ForTheBadge built-with-science](http://ForTheBadge.com/images/badges/built-with-science.svg)](https://github.com/VeronicaAlvarez)

## License 

online-probabilistic-load-forecasting carries a MIT license.

## Citation

If you find useful the code in your research, please include explicit mention of our work in your publication with the following corresponding entry in your bibliography:

<a id="1">[1]</a> 
V. Alvarez, S. Mazuelas, J.A. Lozano.
"Probabilistic Load Forecasting based on Adaptive Online Learning,"
*Submitted to IEEE-Transactions on Power Systems.* 2020.

The corresponding BiBTeX citation is given below:

```
@article{AlvMazLoz:21,
 title={Probabilistic Load Forecasting based on Adaptive Online Learning},
 author={Ver\'{o}nica Alvarez and Santiago Mazuelas and Jos\'{e} A. Lozano},
 journal={IEEE Transactions on Power Systems},
 year={2021},
 volume={36},
 number={4},
 month= {Jul.},
 pages={3668 -- 3680}
}
```
