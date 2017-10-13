## Best Subset Selection

1. Let $$M_0$$ denote the *null model*, which contains no predictors. This model simply predicts the sample mean for each observation.

2. For $$k=1,2,...,p$$:

   (a) Fit all $$\binom{ p }{ k }$$ models that contain exactly $$k$$ predictors.

   (b) Pick the best among these $$\binom{ p }{ k }$$ models, and call it $$M_k$$. Here **best** is defined as having the smallest RSS, or equivalently largest $$R^2$$.

3. Select a single best model from among $$M_0, M_1,...,M_p$$, using cross-validated prediction error, $$C_p$$(AIC), BIC, or adjusted  $$R^2$$.

Although we have presented best subset selection here for least squares regression,  the same ideas apply for other types of models, such as logistic regression. In the case of logistic regression, instead of ordering models by RSS in Step 2, we instead use the *deviance*, a measure that plays the role of RSS for a broader class of models. The smaller the deviance, the better the fit.

While best subset selection is a simple and conceptually appealing approach, it suffers from computationally limitations, there are $$2^p$$ models that involve subsets of $$p$$ predictors. They also only work for least square linear regression.

## Stepwise Selection

* For computational reasons, best subset selection cannot be applied with very large $$p$$.
* Best subset selection may also suffer from statistical problems when $$p$$ is large: **larger the search space, the higher the chance of finding models that look good on the training data**, even though they might not have any predictive power no the future data.
* Thus an enormous search space can lead to *overfitting* and high variance of teh coefficient estimates.
* For both of these reasons, *stepwise* methods, which explore a far more restricted set of models, are attractive alternatives to best subset selection.

### Forward Stepwise Selection

Forward stepwise selection begins with a model containing no predictors, and then adds predictors to the model,*one-at-a-time*, until all the predictors are in the model.  In particular, at each step the variable that gives the greatest **additional** improvement to the fit is added to the model.

1. Let $$M_0$$ denote the *null model*, which contains no predictors. This model simply predicts the sample mean for each observation.

2. For $$k=0,1,\ldots, p-1$$:

   (a) Consider all $$p-k$$ models that argument the predictors in $$M_k$$ with one additional predictor.

   (b) Choose the best among these $$p-k$$ models, and call it $$M_{k+1}$$. Here **best** is defined as having the smallest RSS, or equivalently largest $$R^2$$.

3. Select a single best model from among $$M_0, M_1,\ldots,M_p$$, using cross-validated prediction error, $$C_p$$(AIC), BIC, or adjusted  $$R^2$$.

   ​

* Computational advantage over best subset selection is clear
* It's not guaranteed to find the best possible model out of all $$2^p$$ models containing subsets of the $$p$$ predictors.
* Forward stepwise selection can be applied even in the high-dimensional setting where $$n \lt p$$, in this case, it is possible to construct submodels $$M_0,\ldots,M_{n-1}$$ only, since each submodel is fit using least squares, which will not yield a unique solution if $$p \gg n$$.

### Backward Stepwise Selection

Like forward stepwise selection, *backward stepwise selection* provides an efficient alternative to best subset selection. However, unlike forward stepwise selection, it begins with the full least squares model containing all $$p$$ predictors, and then iteratively removes the least useful predictor, one-at-a-time.

1. Let $$M_p$$ denote the *full model*, which contains all $$p$$ predictors.

2. For $$k=p,p-1,\ldots, 1$$:

   (a) Consider all $$k$$ models that contain all but one of the predictors in $$M_k$$, for a total of $$k-1$$ predictors.

   (b) Choose the best among these $$k$$ models, and clal it $$M_{k-1}$$. Here **best** is defined as having the smallest RSS, or equivalently largest $$R^2$$.

3. Select a single best model from among $$M_0, M_1,\ldots,M_p$$, using cross-validated prediction error, $$C_p$$(AIC), BIC, or adjusted  $$R^2$$.



* Like forward stepwise selection, the backward selection approach searches through only $$1+p(p+1)/2$$ models, and so can be applied in settings where $$p$$ is too large to apply best subset selection.
* Like forward stepwise selection, backward stepwise selection is not guaranteed to yield the *best* model containing a subset of the $$p$$ predictors.
* Backward selection requires that the *number of samples n is larger than the number of variables p*. In contrast, forward stepwise can be used even when $$n \lt p$$, and so is the only viable subset method when $$p$$ is very large.

## Choosing the Optimal Model

* **The model containing all of the predictors will always have the smallest RSS and the largest $$R^2$$**, since these quantities are related to the training error.
* We wish to choose a model with low test error, not a model with low training error.
* Therefore, RSS and $$R^2$$ are not suitable for selecting the best model among a collection of models with different numbers of predictors.

>  We can indirectly estimate test error by making an adjustment to the training error to account for the bias due to overfitting(通过调整training error从而间接估计test error，以解决过度拟合的偏差).



> We can directly estimate the test error, using either a validation set approach or a cross-validaion approach.

### C_p, AIC, BIC, and Adjusted R^2

* **C_p and AIC**

Mallow's $$C_p$$
$$
C_p = \frac{1}{n}(RSS + 2d\hat\sigma^2)
$$
where $$d$$ is the total number of parameters used and $$\hat \sigma^2$$ is an estimate of the variance of the error $$\epsilon$$ associated with each response measurement.

The **AIC** criterion is defined for a large class of models fit by maximum likehood:
$$
AIC = -2logL +2d
$$


where $$L$$ is the maximized value of the likehood function for the estimated model. In the case of the linear model with Gaussian errors, maximum likehood and least squares are the same thing, they are equivalent.

* **BIC**

$$
BIC = \frac{1}{n}(RSS + log(n)d\hat\sigma^2)
$$

Notice that BIC replaces the $$2d\hat\sigma^2$$ used by $$C_p$$ with a $$log(n)d\hat\sigma^2$$ term, where $$n$$ is the number of observations.

Since $$logn \gt 2$$ for any $$n \gt 7$$, the BIC statistic generally places a heavier penalty on models with many variables, and hence results in the selections of small models than $$C_p$$.

* **Adjust R^2**
  $$
  Adjusted R^2=1-\frac{RSS/(n-d-1)}{TSS/(n-1)}
  $$
  where TSS is the total sum of squares.

  1. Unlike $$C_p$$, AIC and BIC, for which a small values indicates a model with a low test error, a large value of adjusted $$R^2$$ indicates a model with a small test error.

  2. Maximizing the adjusted $$R^2$$ is equivalent to minimizing $$\frac{RSS}{n-d-1}$$, while the number of variables in the model increases.

  3. Unlike the $$R^2$$ statistic, the adjusted $$R^2$$ statistic pays a price for the inclusion of unnecessary variables in the model.

     ​

### Validation and Cross-Validation

* We compute the validation set error or the cross-validation error for each model $$M_k$$ under consideration, and then select the $$k$$ for which the resulting estimated test error is smallest.

* The procedure has an advantage relative to AIC, BIC, $$C_p$$, and adjusted $$R^2$$, in that it provides a direct estimate of the test error, and doesn't require an estimate of the error variance $$\sigma^2$$.

* It can also be used in a wider range of model selection tasks, even in cases where it is hard to pinpoint the model degrees of freedom(e.g. the number of predictors in the model) or hard to estimate the error variance $$\sigma^2$$.

  ​
