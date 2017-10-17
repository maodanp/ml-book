The method that we have discussed so far in this chapter have involved fitting linear regression models, via least squares or a shrunken approach, using the original predictors, $$X_1, X_2, \ldots, X_p$$.

We now explore a class of approaches that *transform* the predictors and then fit a least squares model using the transoformed variables. We will refer to these techniques as *dimension reduction* methods.

* Let $$Z_1, Z_2, \ldots, Z_M$$ represent $$M \gt p$$ linear combinations of our original $$p$$ predictors. That is, for some constants $$\phi_{m1}, \ldots, \phi_{mp}$$

$$
Z_m = \sum_{j=1}^p\phi_{mj}X_j \qquad(1)
$$

* We can then fit the linear regression model, using ordinary least squares,

$$
y_i=\theta_0+\sum_{m=1}^M\theta_mz_{im}+\epsilon_i, \qquad i=1,\ldots,n \qquad (2)
$$

* Note that in model $$(2)$$, the regression coefficient are given by $$\theta_0, \ldots, \theta_M$$. If the constants $$\phi_{m1}, \ldots, \phi_{mp}$$ are chosen wisely, then such dimension reduction approaches can often outperform origin linear square(OLS) regression.

* Notice that from definition $$(1)$$,
$$
\sum_{m=1}^M\theta_mz_{im}=\sum_{m=1}^M\theta_m\sum_{j=1}^p\phi_{mj}x_{ij}=\sum_{j=1}^p\sum_{m=1}^M\theta_m\phi_{mj}x_{ij}=\sum_{j=1}^p\beta_jx_{ij}
$$
where(Hence, model 2 can be thought of as a special case of the original linear regression model)
$$
\beta_j=\sum_{m=1}^M\theta_m\phi_{mj}
$$

* Dimension reduction serves to constrain the estimated $$\beta_j$$ coefficients, since now they must take the form $$(3)$$.

* Can win  in the bias-variance tradeoff.

  All dimension reduction methods work in two steps. First, the transformed predictors $$Z_1, Z_2,\ldots, Z_M$$ are obtained. Second, the model is fit using these $$M$$ predictors. However, the choice of $$Z_1, Z_2,\ldots, Z_M$$ or the selection of the $$\phi_{jm}$$'s can be achieved in different ways. We will consider two approaches for this task: **principal components** and **partial least squares**.

##  Principal Components Regression

* Here we apply principal components analysis (PCA) to define the linear combinations of the predictors, for use in our regression.
* The first principal component is that(normalized) linear combination of the variables with the largest variance.
* The second principal component has largest variance, subject to being uncorrelated with the first.
* And so on.
* Hence with many correlated original variables, we replace them with a small set of principal components that capture their joint variation.

With two-dimensional data, we can construct at most two principal components. However, if we have other predictors, then additional components could be constructed. The would successively maximize variance, subject to the constraint of being uncorrelated with the preceding components.

##  Partial Least Squares

PCR identifies linear combinations, or **directions**, that best represent the predictors $$X_1, \ldots, X_p$$.These directions are identified in an **unsupervised** way, since the response Y is not used to help determine the principal component directions.

Consequently, PCR suffers from a potentially serious drawback: there is no guarantee that the directions that best explain the predictors will also be the best directions to use for predicting the response.

* Like PCR, PLS is dimension reduction method, which first identifies a new set of features $$Z_1, \ldots, Z_M$$ that are linear combinations of the original features, and then fits a linear model via OLS using these M new features.
* But unlike PCR, PLS identifies these new features in a supervised way — that is, it makes use of the response Y in order to identify new features that not only approximate the old features well, but also that *are related to the response*.
* Roughly speaking, **the PLS approach attempts to find directions that help explain both the response and predictors**.
