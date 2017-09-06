* Here out model is
$$
Y = \beta_0 + \beta_{x1} + \beta_{x2} + ... + \beta_{xp} + \epsilon
$$

* we interpret $$\beta_j$$ as the average effect on $$Y$$ of a one unit increase in $$X_j$$, holding all other predictors fixed.

* Given estimates $$\hat{\beta_0},\hat{\beta_1}...\hat{\beta_p}$$, we can make predictions using the formula:
$$
\hat{y} = \hat{\beta_0} + \hat{\beta_1}x_1 + ... + \hat{\beta_p}x_p
$$
* We estimate $$\beta_0, \beta_1,...\beta_p$$ as the values that minimize the sum of squared residuals,This is done using standard statistical software:
$$
RSS = \sum_{i=1}^n(y_i - \hat{y_i})^2
$$
## Some import questions
1. **Is at least one of the predictions $$X_1, X_2,... X_p$$ useful in predicting the response?**
2. **Do all the predictions help to explain $$Y$$, or is only a subset of the predictions useful?**
3. **How well does the model fit the data?**
4. **Given a set of predictor values, what response value should we predict, and how accurate is our predictions?**

### One: Is There a Relationship Between the Response and Predictors?

####  all the cofficients are zero

We test the null hypothesis:
$$
H_0: \beta_0 = \beta_1 = ... = \beta_p = 0
$$
versus the alternative:
$$
H_a: \text{at least one } \beta_j \text{ is non-zero}
$$
The hypothesis test is performed by computing the F-statistic
$$
F = \frac{(TSS-RSS)/p}{RSS/(n-p-1)}
$$
where, as with simple linear regression, $$TSS=\sum_{i=1}^2(y_i - \overline{y})^2$$ and $$RSS=\sum_{i=1}^2(y_i - \hat y_i)^2$$
If the linear model assumptions are correct, on can show that:
$$
E\{\frac{RSS}{(n-p-1)}\}={\sigma}^2
$$

$$
f(n) =  
\begin{cases}  
E\{(TSS-RSS)/p\} = {\sigma}^2, &\text{if H0 is true} \\[2ex]
E\{(TSS-RSS)/p\} > {\sigma}^2, &\text{if H1 is true}  
\end{cases}
$$
* F-statistic is far larger than 1, it provides compelling evidence against the null hypothesis(the large F-statistic suggests that at least one of the advertising media must be related to sales)
* F-statistic had been closer to 1, which depends on the values of n and p.When **n is large**, an F-statistic that is just a little larger than 1 might still provide evidence against $$H_0$$. In contrast, a larger F-statistic is needed to reject $$H_0$$ if **n is small**.

####  a particular subset of q of the cofficients are zero

We test the null hypothesis:
$$
H_0: \beta_{p-q+1} = \beta_{p-q+2} = \beta_p = 0
$$
Suppose that the residual sum of squares for that model is $$RSS_0$$, then the appropriate F-statistic is:
$$
F = \frac{(RSS_0-RSS)/p}{RSS/(n-p-1)}
$$
The approach of using an F-statistic to test for any association between the predictors and the response works when **p is relatively small, and certainly small compared to n**. But if $$p > n$$, in this case we cannot event fit the multiple linear regression model using least squares, so **the F-statistic cannot be used**.

### Two: Deciding on Important Variables
*The first step in a multiple regression analysis is to compute the F-statistic and to examine the associated p-value*. If we conclude on the basis of that p-value that at least one of the predictors is related to the response, then it's natural to wonder which are the guilty ones!
There are three classical approaches for this task:
* *forward selection*: begin with null model-a model that contains an intercept but no predictors.We then fit p simple liner regression and add to the null model that variable that results in the lowest RSS, then add to that model for the new two-variable mode. This approach is continued until some stopping rule is satisfied.
* *Backward selection*: Start with all variables in the model, and remove the variable with the largest p-value, that is, the variable that is the least statistically significant. The new (p-1)-variable model is fit, and the variable with the largest p-value is removed.This procedure continues until a stopping rule is reached.
*  *Mixed selection*: This is a combination of forward and backward selection. We start with on variables in the model, and as with forward selection, added the variable that provides the best fit, continued to add variables one-by-one.Hence, if at any point the p-value for one of the variables i the model rises above a certain threshold, then we remove that variable from the model.

> Backward selection can't be used if $$p > n$$, while forward selection can always be used. Forward selection is a greedy approach, and might include variables early that later become redundant. Mixed selection can remedy this.

### Three: Model Fit
Two of the most common numerical measures of model fit are the RSE and $$R^2$$.
$$R^2$$ is the square of the correlation of the response and the variable. In multiple linear regression, it turns out that it equals $$Cor(Y, \hat{Y})^2$$, **the square of the correlation between the response and the fitted linear model**.
An $$R^2$$ value close to 1 indicates that the model explains a large portion of the variance in the response variable.*It turns out that $$R^2$$ will always increase when more variables are added to the model, even if those variables are only weakly associated with the response*(adding another variable to the least squares equtions must allow us to fit the training data).

### Four: Predictions
Once we have fit the multiple regression model, it's straightforward to apply formula in order to predict the respnose Y on the basis of a set of values for the predictors $$X_1, X_2, ..., X_p$$. There are three sorts of uncertainty associated with this prediction:
1. The cofficient estimates $$\hat{\beta_0},\hat{\beta_1},...,\hat{\beta_p}$$ are estimates for $${\beta_0},{\beta_1},...,{\beta_p}$$, that is **the least squares plane $$\hat Y$$ is only an estimate for the true population regression plane $$f(x)$$**.
The inaccuracy in the coefficient estimates is related to the *reducible error* from Ch2, we can compute a confidence interval in order to determine how close $$\hat Y$$ will to be $$f(X)$$.
2. In practice assuming a linear model for $$f(X)$$ is almost always an approximation of reality, so there is an additional source of potentially reducible error which we call *model bias*.
3. Even if we knew $$f(X)$$--that is, even if we knew the true value for $${\beta_0},{\beta_1},...,{\beta_p}$$ -- the response value can't be predicted perfectly because of the random error $$\epsilon$$ in the model, we referred to this as the *irreducible error*. How much will Y vary from $$\hat Y$$?
> Prediction intervals are always wider than confidence intervals, because they incorporate both the error in the estimate for f(x)(the reducible error) and the uncertainty as to hot much an individual point will differ from the population regression plane(the irreducible error).
