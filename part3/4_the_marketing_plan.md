## Is there a relationship between advertising sales and budget?

This question can be answered by fitting a multiple regression model of sales on tv, radio, and newspaper, and testing the hypothesis $$H_0: \beta_{tv}=\beta_{radio}=\beta_{newspaper}=0$$, and **F-statistic** can be used to determine whether or not we should reject this null hypothesis.
In this case, the p-value corresponding to the F-statistic is very low, indicating clear evidence of a relationship between advertising and sales.

## How strong is the relationship?

We discussed two measures of model accuracy:
First, the RSE estimates the standard deviation of the response from the population regression line.
Second, the $$R^2$$ statistic records the percentage of variability in the response that is explained by the predictors.

## Which media contribute to sales?

We can examine the p-values associated with each predictor's t-statistic.
In the multiple linear regression, the p-values for tv and radio are low, but the p-value for newspaper is not, this suggest that only tv and radio are related to sales.

## How large is the effect of each media on sales?

standard error of $$\hat \beta_j$$can be used to construct confidence intervals for $$\beta_j$$.
For the advertising data, the 95% confidence intervals are as follows:(0.043, 0.049) for tv, (0.172, 0.206) for radio, and(-0.013, 0.011) for newspaper. The confidence intervals for tv and radio are **narrow and far from zero**, providing evidence that these media are related to sales.But the interval for newspaper includes zero, indicating that the variable is not statistically significant given the values of tv and radio.
In order to assess the association of each medium individually on sales, we can perform three separate simple linear regression.

## How accurately can we predict future sales?

The response can be predicted using the following formula:
$$
\hat{y} = \hat{\beta_0} + \hat{\beta_1}x_1 + ... + \hat{\beta_p}x_p
$$
The accuracy associated with this estimate depends on whether we wish to predict an individual response or the average response.If the former, we use a prediction interval, and if the latter, we use a confidence interval. Prediction intervals will always be wider than confidence intervals.

## Is the relationship linear?

Residual plots can be used in order to identify non-linearity.If the relationships are linear, then the residual plots should display no pattern.
We discussed the inclusion of transformations of the predictors in the linear regression model in order to accommodate non-linear relationships.

## Is there synergy among the advertising media?

The standard linear regression model assumes an additive relationship between the predictors and the response. However, the additive assumption may be unrealistic for certain data sets.
