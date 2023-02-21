# Model Selection

## Classical techniques:
- T-tests
- F-tests


## High-dimensional data:

### Basic ML techniques:
- Lasso, Forest trees

### State-of-the-art (in econ):

Following Belloni et al. ([2014](https://www.aeaweb.org/articles?id=10.1257/jep.28.2.29), [2017](https://www.econometricsociety.org/publications/econometrica/2017/01/01/program-evaluation-and-causal-inference-high-dimensional-data)), many papers now include an specification with controls chosen by a **double-robust Lasso procedure** as part of their robustness checks. Double robust procedures are particularly useful for high-dimensional datasets where it is difficult to specify the correct model. The basic idea is that a control will be included in the final specification if it is either **a significant predictor of the outcome, or of the causal variable of interest**.
For the metrics of why a double robust procedure is better than the classical procedure, see the [Mostly Dangerous Economics Presentation](https://stuff.mit.edu/~vchern/papers/Chernozhukov-Saloniki.pdf).

The package [pdslasso](https://statalasso.github.io/docs/pdslasso), part of the family of Lasso packages `lassopack`, carries out the double procedure automatically. You only need to specify the outcome variable, the causal variable of interest, a list of all potential controls, and any other FE/type of SEs you want to use. While the default options of the package are good enough, it also lets you tune in the Lasso models a lot if you need to.

Syntax: `pdslasso outcome causal_var (all potential controls), other_opts`