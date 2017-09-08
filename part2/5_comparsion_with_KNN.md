**parametric methods**:
* Advantage: easy to fit, and tests of statistical significance can be easily performed.
* Disadvantage: by construction, they make strong assumptions about the form of f(X). If the specified functional form is far from the truth, then the parametric method will perform poorly.

**non parametric methods**:
* Advantage: do not explicitly assume a parametric form for $$f(X)$$, and thereby provide an alternative and more flexible approach for performing regression.


## K Nearest Neighbors
A small value for K provides the most flexible fit, which will have low bias but high variance.
In contrast, larger values of K provide a smoother and less variable fit. The prediction in a region is an average of several points, and so changing one observation has a smaller effect, however, the smoothing may cause bias by masking some of the structure in $$f(X)$$

## parametric method v.s. non-parametric method

If the relationship between $$X$$ and $$Y$$ is linear. Since the true relationship is linear, it is hard for a non-parametric approach to complete with linear regression.

**A non-parametric approach incurs a cost in variance that is not offset by a reduction in bias(非参数化方法产生的偏差成本不会被偏差的减少所抵消)**

when the value of K is large, then KNN performs only a little worse than least squares regression in terms of MSE. It performs far worse when K is small.

KNN should be favored over linear regression because it will at worst be slight inferior than linear regression if the true relationship is linear(KNN应该优于线性回归，因为如果真正的关系是线性的，那么它将在最坏的情况下比线性回归略低), and may give substantially better results if the true relationship is non-linear.
But in reality, even when the true relationship is highly non-linear, KNN may still provide inferior result to linear regression.In higher dimensions, KNN often performs worse than linear regression.

In fact, the increase in dimension has only caused a small deterioration in the linear regression test set MSE, but it has caused more than a ten-fold increase in the MSE for KNN, and results from the fact that in higher dimensions there is effectively a reduction in sample size(更高维度会使得样本量减少).

As a general rule, parametric methods will tend to outperform non-parametric approaches when there is a small number of observations per predictors.

If the test MSE of KNN is only slightly lower that that of linear regression, we might be willing to forego a little bit of prediction accuracy for the sake of a simple model that can be described in terms of just a few coefficients, and for which p-values are available.
