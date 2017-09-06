## Extensions of the linear regression
The standard linear regression model provides interpretable results and works quite well on many real-world problems.
$$
Y = \beta_0 + \beta_1X_1 + \beta_2X_2 + ... + \beta_pX_p + \epsilon
$$
However, it makes several highly restrictive assumptions that are often violated in practice.Two of the most import assumptions state that the relationship between the predictors and response are *additive* and *linear*.
* additive assumption: the effect of changes in a predictor $$X_j$$ on the response $$Y$$ is independent of the values of the other predictors.
* linear assumption: the linear assumption states that the change in the response $$Y$$ due to a one-unit change in $$X_j$$ is constant, regardless of the value of $$X_j$$

### Removing the Additive Assumption
The linear models that formed the basis for this conclusion assumed that the effect on sales of increasing one advertising medium is independent of the amount spent on the other media.
However, this simple model may be incorrect.Suppose that spending money on radio advertising actually increases the effectiveness of TV advertising, **so that the slope term for TV should increase as radio increases**.
One way of extending this model to allow for interaction effects is to include a third predictor, called an interaction term, which is constructed by computing the product of $$X_1$$ and $$X_2$$. This results in the model:
$$
Y = \beta_0 + \beta_1X_1 + \beta_2X_2 + \beta_3X_1X_2 + \epsilon
  = \beta_0 + (\beta_1 + \beta_3X_2)X_1 + \beta_2X_2 + \epsilon
$$
It is sometimes the case that an interaction term has a very small p-values, but the associated main effects(like TV and radio) do not.

>The hierarchical principle states that if we include an interaction in a model, we should also include the main effects, even if the p-values associated with their coefficients are not significant.

In other words, if the interaction between $$X_1$$ and $$X_2$$ seems important, then we should include both $$X_1$$ and $$X_2$$ in the model even if their coefficient estimates have large p-values.

The concept of interactions applies to quantitative variables, as well to qualitative variables, or to a combination of quantitative and qualitative variables. In fact, an interaction between a qualitative variable and a quantitative variable has a particularly nice interpretation.

###Non-linear Relationship
The linear regression model assumes a linear Relationship between the response and predictors. But in some cases, the true Relationship between the response and predictors maybe non-linear.
We present a very simple way to directly extend the linear model to accommodate non-linear relationships, using **polynomial regression**.
The following formula is a model:
$$
mpg = \beta_0 + \beta_1 \times horsepower + \beta_2 \times horsepower^2 + \epsilon
$$
The formula is using a non-linear function of horsepower, but it's still a linear model! That is, it's simply a multiple linear regression with $$X_1=horsepower$$ and $$X_2=horsepower^2$$. So we can use standard linear regression software to estimate $$\beta_0, \beta_1, \beta_2$$ in order to produce a non-linear fit.

## Potential Problems
Some problems may occur. Most common among these are the following:
1. non-linearity of the response-predictor relationships
2. correlation of error terms
3. non-constant variance of error terms
4. outliers
5. high-leverage points
6. collinearity

### non-linearity of the Data
Residual plots are a useful graphical tool for identifying non-linearity.
If the residual plot indicates that there are non-linear associations in the data, then a simple approach is to use non-linear transformations of the predictors, such as $$logX, \sqrt X, X^2$$, in the regression model.

### correlation of error terms
Such correlations frequently occur in the context of time series data, which consists of observations for which measurements are obtained at discrete points in time.In many cases, observations that are obtained at adjacent time points will have positively correlated errors.
In general, the assumption of uncorrelated errors is extremely import for linear regression as well as for other statistical methods, and good experimental design is crucial in order to mitigate the risk of such correlations.

### non-constant variance of error terms
It is often the case that the variances of the error terms are non-constant.
When faced with this problems, one possible solution is to transform the response Y using a **concave function** such as $$logY, \sqrt Y$$. Such a transformation results in a greater amount of shrinkage of the larger response, leading to a reduction in heteroscedasticity.

### outliers
An outliers is a point for which $$y_i$$ is far from the value predicted by the model.
It's typical for an outliers that does not have an unusual predictor value to have little effect on the least squares fit.
However, maybe RSE will decrease, since the RSE is used to compute all confidence intervals and p-values, such a dramatic increase caused by a single data point can have implications for the interpretation of the fix, similarly, inclusion of the outlier causes the $$R^2$$ to decline.

How to identify outliers? To address this problem, insteam of plotting the residuals, we can plot the **studentized residuals**, computed by dividing each residual $$e_i$$ by its estimated standard error.*observations whos studentized residuals are greater than 3 in absolute value are possible outliners*.

> care should be taken to remove outliers, since an outlier may instead indicate a deficiency with the model, such as a missing predictor.

We just saw that outliers are observations for which the response $$y_i$$ is unusual give the predictor $$x_i$$, in contrast, observations with **high leverage** have an unusual value for $$x_i$$.
Removing the high leverage observation has a much more substantial impact on the least squares line than removing the outliner.
In order to quantify an observation's leverage, we compute the **leverage statistic**. A large value of this statistic indicates an observation with high leverage:
$$
h_i = \frac{1}{n} + \frac{(x_i-\overline{x})^2}{\sum_{i=1}{n}(x_{i'}-\overline{x})^2}
$$
The leverage statistic $$h_i$$ is always between 1/n and 1, and the average leverage for all the observations is always equal to $$(p+1)/n$$.So if a given observation has a leverage statistic that greatly exceeds $$(p+1)/n$$, then we may suspect that the corresponding point has high leverage.

A simple way to detect collinearity is to look at the correlation matrix of the predictors. An element of this matrix that is large in absolute value indicates a pair of highly correlated variables, and therefore a collinearity problem in the data.

But for multicollinearity(collinearity to exist between three or more variables even if no pair of the variables has a particularly high correlation), a better way to access multicollinearity is to compute the variance inflation factor(VIF).

When faced with the problem of collinearity, there are two simple solutions:
1. drop one of the problematic variables from the regression.
2. combine the collinear variables together into a single predictor.
