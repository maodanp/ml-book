## The logistic model
How should we model the relationship between $$p(X) = Pr(Y=1|X)$$ and $$X$$ ? In logistic regression, we use the logistic function:
$$
p(X) = \frac{e^{\beta_0 + \beta_1X}}{1 + e^{\beta_0 + \beta_1X}}
$$
* for low balances, we now predict the probability of default as close to, but never close to, zero.
* for high balances, we predict a default probability close to ,but never above, one.

$$
\frac{p(X)}{1-p(X)} = e^{\beta_0 + \beta_1X}
$$
The quantity $$p(X)/(1-p(X))$$ is called the *odds*, and can take on any value between 0 and $$\infty$$. Odds are traditionally used instead of probabilities in horse-racing, since they relate more naturally to the correct betting strategy.

$$
log(\frac{p(X)}{1-p(X)}) = \beta_0 + \beta_1X
$$


## estimating the regression coefficients
The coefficients $$\beta_0, \beta_1$$ are unknown, and must be estimated based on the available training data. In Chapter 3, we used the least squares approach to estimate the unknown linear regression coefficients. The more general method of **maximum likelihood** is preferred, since it has better statistical properties.

The basic intuition behind using maximum likelihood to fit a logistic regression model is as follows: **we seek estimates for $$\beta_0$$ and $$\beta_1$$ such that the predicted probability $$\hat p(x_i)$$ of default for each individual, using previous formula, corresponds as closely as possible to the individual's observed default status**.

This intuition can be formalized using a mathematical equation called a likelihood function:
$$
l(\beta_0, \beta_1) = \prod_{i:y_i=1} p(x_i) \times \prod_{i':y_{i'}=0} (1 - p(x_{i'}))
$$
The estimates $$\hat \beta_0$$ and $$\hat \beta_1$$ are chosen to *maximize* this likelihood function.

Maximum likelihood is a very general approach that is used to fit many of the non-linear models that we examine throughout this book. In the linear regression setting, the least squares approach is in fact a special case of maximum likelihood.

## Making predictions
Once the coefficients have been estimated, it is a simple matter to compute the probability of *default* for any given credit card *balance*.

One can use qualitative predictors with the logistic regression model using the dummy variable approach from Section 3.3.1.

## Multiple logistic regression
$$
log(\frac{p(X)}{1-p(X)}) = \beta_0 + \beta_1X + \beta_1X + ... +\beta_pX_p
$$
$$
p(X) = \frac{e^{\beta_0 + \beta_1X + ... + \beta_pX_p}}{1 + e^{\beta_0 + \beta_1X+...+\beta_pX_p}}
$$
We use the maximum likelihood method to estimate $$\beta_0, \beta_1, ..., \beta_p$$.

A student is riskier than a non-student if no information about the student's credit card balance is available. However, that student is less risky than a non-student with the same credit card balance!

This simple example illustrates the dangers and subtleties associated with performing regressions involving only a single predictor when other predictors may also be relevant.

## Logistic Regression for > 2 Response Classes
*Discriminant analysis*, is popular for multiple-class classification.

## References
[最大似然估计和最小二乘法](https://www.zhihu.com/question/20447622)

[从odds理解LR](http://vividfree.github.io/%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0/2015/12/13/understanding-logistic-regression-using-odds)
