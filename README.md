# Welcome to my Stata Coding Library

This is my personal collection of explanations, code snippets and basic Stata templates (mainly focused on **tables** and **graphs** that can be automatically exported in *latex* format). I try to include different ways and quickly comment on why I prefer a certain way (usuallly it all boils down to code complexity vs customizability). 

The following table of contents shows the basic structure of the library. Since it is in its baby stage, it is likely to change as I understand how I want to search/find content better at a later date. For now, I am grouping things based on whether they deal with data preparation, descriptives, or main analysis (further divided by types of research design).

## STATA setup and data preparation

1. [Stata Basics](./content/stata_basics.ipynb) : ex. basic dofile template, schemes
2. [Basic Data Cleaning](./content/data_cleaning.ipynb): ex. missing data, labelling,
3. [Advanced: indices and multiple imputation]()

## Descriptives

1. [Distribution](./content/distribution.ipynb) : ex. histograms, k- densities
2. Correlation

## Main analysis

1. [General regression outputs](./content/regression.md) : ex. tables, coefficient plots.
2. [Working with RCTs](./content/rct.ipynb) : ex. dealing with attrition, balance tables.
3. [Event studies](./content/event_study.ipynb)
4. Weirder figures: ex. bubble scatter
