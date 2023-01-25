# Welcome to my Stata Coding Library

This is my personal collection of Stata templates (.do) and a mix of explanations and code snippets (in jupyter notebooks). I personally use VS code to edit my files because it has a great syntax completition features, and you can run Stata inside Jupyter Notebooks using [stata-kernel](https://kylebarron.dev/stata_kernel/).

The core part of the library focuses on **tables** and **graphs**, which aim to automatically create *latex* output from the dofile. There are many ways to do create tables in *Stata*, and I include several of them while providing a short summary of why I prefer a certain way (usuallly it all boils down to code complexity vs customizability). 

This table of contents shows the basic structure of the library. Since it is in its baby stage, it is likely to change as I understand how I want to search/find content better at a later date. For now, I am grouping things based on whether they deal with data preparation, descriptives, or main analysis (further divided by types of research design). 

## STATA setup and data preparation

1. [Stata Basics](./content/stata_basics.md) : ex. basic dofile template, schemes
2. [Basic Data Cleaning](./content/data_cleaning.md): ex. missing data, labelling,
3. [Advanced: indices and multiple imputation]()

## Descriptives

1. [Distribution](./content/distribution.ipynb) : ex. histograms, k- densities
2. Correlation

## Main analysis

1. [General regression outputs](./content/regression.md) : ex. tables, coefficient plots.
2. [Working with RCTs](./content/rct.md) : ex. dealing with attrition, balance tables.
3. [Event studies](./content/event_study.ipynb)
4. Weirder figures: ex. bubble scatter
