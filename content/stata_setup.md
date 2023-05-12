# STATA BASICS
As much as we all complain about Stata, it does make coding pretty simple for most things you need in econ. 

First, the following [template](../code/stata_setup.do) shows the basic set up I like to use for code. Some comments:
- For collaborations: write your name/abbrev when you do a modification so we can know who to ask.

## Miscellaneous tips 
- Dropping variables in a loop: many times a loop will create variables, that need to be deleted at the second run. To do this, use `capture drop varname`. However, note that if ANY of the variable names is not found, none of the variables will be dropped (if this is a potential issue, use `cap drop` inside a loop)