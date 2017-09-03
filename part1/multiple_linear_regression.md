# Multiple Linear regression

* Here out model is
$$
Y = \beta_0 + \beta_1X_1 + \beta_2X_2 + ... + \beta_pX_p + \epsilon
$$

* we interpret $$\beta_j$$ as the average effect on $$Y$$ of a one unit increase in $$X_j$$, holding all other predictors fixed.

* Given estimates $$\hat{\beta_0},\hat{\beta_1}...\hat{\beta_p}$$, we can make predictions using the formula:
$$
\hat{y} = \hat{\beta_0} + \hat{\beta_1} + ... + \hat{\beta_p}
$$
* We estimate $$\beta_0, \beta_1,...\beta_p as the values that minimize the sum of squared residuals$$
$$
RSS = \sum_{i=1}^n(y_i - y\hat{y_i})^2 = \sum_{i=1}^n(y_i - \hat{\beat_0} - \hat{\beat_1}x_i1 - ... - \hat{\beat_p}x_ip)
$$
This is done using standard statistical software.

## Some import questions
1. s at least one of the predictions $$X_1, X_2,... X_p$$ useful in predicting the response?
2. Do all the predictions help to explain $$Y$$, or is only a subset of the predictions useful?
3. How well does the model fit the data?
4. Given a set of predictor values, what response value should we predict, and how accurate is our predictions?

### One: Is There a Relationship Between the Response and Predictors?
We test the null hypothesis:
$$
H_0: \beta_0 = \beta_1 = ... = \beta_p = 0
$$
versus the alternative:
$$
H_a: at least one \beta_j is non-zero
$$
The hypothesis test is performed by computing the F-statistic
$$
F = \frac{\frac{TSS-RSS}{p}}{\frac{RSS}{n-p-1}}
$$
where, as with simple linear regression, $$TSS=\sum_{i=1}^2{y_i - \overline{y}}^2$$ and $$RSS=\sum_{i=1}^2(y_i - \hat y_i)^2$$
If the linear model assumptions are correct, on can show that:
$$
E{\frac{RSS}{n-p-1}}={\sigma}^2
$$
*
*
















































## Estimating the Regression coefficients
