# Data Cleaning

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
## Labelling
- Label a variable: `label variable var "label"`
- Retrieve value of a label: `local lab: variable label var`
- Label values: 
    1. `label define var_values val1 "lab1" val2 "lab2"` where val_values is the placeholder representing the labels that you are gonna assign to the variable of interest.
    2. `label value var var_values`
