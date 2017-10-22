In the chapter that follow, we consider some approaches for extending the linear model framework. In Chapter 7 we generalize the following model in order to accommodate non-linear, but still additive, relationships, while in Chapter 8 we consider even more general non-linear models.
$$
Y = \beta_0 + \beta_1X_1 + ... + \beta_pX_p + \epsilon
$$
The Linear model has distinct advantages in terms of inference and is often surprisingly competitive in relation to non-linear methods.Hence, before moving to the non-linear world, **we discuss in this chapter some ways in which the simple linear model can be improved, by replacing plain least squares fitting with some alternative fitting procedures**.

Why might we want to use another fitting procedure instead of least squares? Alternative fitting procedures can yield better **prediction accuracy** and **model interpretability**.

* *Prediction Accuracy*: Provided that the true relationship between the response and the predictors is approximately linear, the least squares estimates will have low bias. If $$n \gg p$$, the least squares estimates tend to have low variance, and hence will perform well on test observations. However, if $$n$$ is not much larger than $$p$$, then there can be a lot of variability in the least squares fit, resulting in overfitting and consequently poor predictions on future observations. And if $$p \gt n$$, then there is no longer a unique least squares coefficient estimate: the variance is infinite so the method cannot be used at all.
* *Model Interpretability*: It is often the case that some or many of the variables used in a multiple regression model are in fact not associated with the response, By removing these variables —that is, by setting the corresponding coefficient estimates to zero—we can obtain a model that is more easily interpreted. But now least squares is extremely unlikely to yield any coefficient estimates that are exactly zero.

There are many alternatives, both classical and modern, to using least squares to fit the previous linear model. In this chapter, we discuss three important classes of methods.

* *Subset Selection*. This approach involves identifying a subset of the $$p$$ predictors that we believe to be related to the response. We then fit a model using least squares on the reduced set of variables.
* *Shrinkage*.This approach involves fitting a model involving all $$p$$ predictors. However, the estimated coefficients are shrunken towards zero relative to the least squares estimates. This shrinkage(also known as *regularization*) has the effect of reducing variance. Depending on what type of shrinkage is performed, some of the coefficients may be estimates to be exactly zero. **Hence, shrinkage methods can also perform variable selection**.
* *Dimension Reduction*.This approach involves projecting the $$p$$ predictors into a M-dimensional subspace, where $$M \lt p$$. This is achieved by computing $$M$$ different linear combinations, or projections, of the variables. Then these $$M$$ projections are used as predictors to fit a linear regression model by least squares.

In the following sections we describe each of these approaches in greater detail, along with their advantages and disadvantages.

BTW, we can improve upon least squares using ridge regression, the lasso, principal components regression, and other techniques. The improvement is obtained by reduce complexity of the linear model, and hence the variance of the estimates. But we are still using a linear model. In Chapter 7, we will relax the linearity assumption to move beyond linearity.
