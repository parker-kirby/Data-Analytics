# Data Science Project Template

Template adapted from [Cookiecutter Data Science](https://drivendata.github.io/cookiecutter-data-science/)



## Convention

Following this directory structure
```
|--project_name                           <- Project root level that is checked into github
  |--project                              <- Project folder
    |--README.md                          <- Top-level README for developers
    |--volume
    |   |--data
    |   |   |--external                   <- Data from third party sources
    |   |   |--interim                    <- Intermediate data that has been transformed
    |   |   |--processed                  <- The final model-ready data
    |   |   |--raw                        <- The original data dump
    |   |
    |   |--models                         <- Trained model files that can be read into R or Python
    |
    |--required
    |   |--requirements.txt               <- The required libraries for reproducing the Python environment
    |   |--requirements.r                 <- The required libraries for reproducing the R environment
    |
    |
    |--src
    |   |
    |   |--main                      <- Scripts for main data analysis
    |   |   |--build_main.r
    |   |
    |   |--graphs                        <- Scripts for graphs and visualizations (if any)
    |   |   |--graph_model.r
    |   |
    |
    |
    |
    |--.getignore                         <- List of files not to sync with github
```
