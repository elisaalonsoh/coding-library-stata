# WORKING WITH RCT DATA
- [WORKING WITH RCT DATA](#working-with-rct-data)
  - [Balance tables](#balance-tables)
  - [Dealing with attrition](#dealing-with-attrition)
    - [Detecting attrition ⚙️](#detecting-attrition-️)
    - [Adjusting for attrition ⚙️](#adjusting-for-attrition-️)

## Balance tables
A balance test checks whether there is a significant difference-in-means between two groups. In RCTs, balance tables are used to check whether randomization was successful (there should be no significant difference between both arms of treatment for a given set of covariates). The DIME group from the World Bank created the `iebaltab` command (part of their package `ietoolkit`) to quickly create publish-quality balance tables. It allows you to add covariates, fixed effects and use cluster-robust standard errors. If you need even more customization, see this [template](../dofiles/balance_table.do) (not done yet).

## Dealing with attrition

**Attrition** occurs in a longitudinal study when participants fail to respond one or more study follow-up waves. Problems:
1. If the characteristics of attritors are correlated with the treatment assignment or effect size (*non-random attrition*), it can result attrition bias (similar to *non-response bias*)
2. Even if attrition is random, it decreases *statistical power* as a result of the sample size decreasing.

IMP: template for [attrition analysis](../dofiles/attrition_analysis.do)

### Detecting attrition ⚙️
We can examine the **overall rate of attrition** using the command `xtdescribe`. It is also essential to check for **differential attrition**, i.e. systematic differences in attrition rates between treatment and control groups. Some checks:
1. Check for [balancedness](#balance-tables) for the participation in each wave
2. Regress **attrition** on treatment, using the SAME specification used in the main analysis, i.e. with the same set of controls.
3. Do the characteristcs of attrits vary by treatment assignment, by subgroup or by another observable characteristic?

It is also important to check for **selective attrition**, i.e. whether baseline characterisitcs differ between treatment and control groups conditional on attrit vs non-attrit status.

### Adjusting for attrition ⚙️