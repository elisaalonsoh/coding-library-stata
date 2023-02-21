# Data Cleaning

- [Data Cleaning](#data-cleaning)
  - [Dummy variables](#dummy-variables)
  - [Missing Data](#missing-data)
    - [How does Stata handle missing data?](#how-does-stata-handle-missing-data)
    - [Checking missing data patterns:](#checking-missing-data-patterns)
    - [Dropping missing data](#dropping-missing-data)
    - [Filling missing data:](#filling-missing-data)
      - [Filling missing periods in a panel data:](#filling-missing-periods-in-a-panel-data)
  - [Labeling](#labeling)

## Dummy variables

If we chave a variable with several categories that we want to code into individual dummies, and automatically create a label with their indiividual cateogry value we can use `tab var, gen(prefix_)`

## Missing Data
When working with missing data, first we need to consider whz the data is missing. If we assume data is missing at random, deleting the observations with missing values shouldnät bias our analysis, but this is an assumption that would rarely hold.

### How does Stata handle missing data?
Stata uses only non-missing values when providing summary statistics and tabulations. If an observation is missing data for a variable in the regression model, that observation is excluded from the regression (treated as missing at random!).

### Checking missing data patterns:
The command `sumarize` gives you the amount of missing data, but there are external packages that provide a more in depth analysis of missing data pattens.

### Dropping missing data
To drop observations with missing numeric data use `drop if var == .` and for string data us `drop if var == ""`. The comand `drop if missing(var)` can drop missing observations no matter the variable's type.

### Filling missing data:

#### Filling missing periods in a panel data:
Sometimes we want to have a balanced panel even if the variables of interest are missing (or later recoded as 0, or some value), but not all periods appear in our dataset. Once we have `xtset` our data, we can use the command `tsfill` to create the new missing time periods for each of our ids (it can also be used with only time data).

## Labeling

- Check existing labels in dataset: `codebook`, or `label list var`/ `labelbook var` for specific value labels
- Label a variable: `label variable var "label"`
    - Retrieve value of a label and store in local: `local lab: variable label var`
- Label values of a variable: 
    1. Define a value label: `label define var_values val1 "lab1" val2 "lab2"`. If it is already defined:
         - Add new value-label pairs by specifying them and adding the option `, add` at the end.
         - Modify existing value-label pairs by specifying them and adding the option `, modify` at the end.
    2. Assign that label value to variable: `label value var var_values`. *Note*: you can use the same value label for different variables, just specify a *varlist* instead (ex. for Likert scales)
---
**References**: 
- Labelling: [basic labeling](https://wlm.userweb.mwn.de/Stata/wstatlab.htm)
