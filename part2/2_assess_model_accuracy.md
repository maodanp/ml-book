No one method dominates all others over all possible data sets. On a particular data set, one specific method may work best, but some other method may work better on a similar but different data set.

Selecting the best approach can be one of the most challenging parts of performing statistical learning in practice.
> There is no free lunch in statistics.

## Measuring the Quality of Fit
We need to qualify the extent to which the predicted response value for a given observation is close to the true response value for the observation. In the regression setting, the most commonly-used measure is the mean squared error(MSE), given by:
$$
MSE=\frac{1}{n}\sum_{i=1}^n(y_i-\hat f(x_i))^2
$$
The MSE will be small if the predicted responses are very close to the true responses, and will be large if for some of the observations, the predicted and true responses differ substantially.

*We are interested in the accuracy of the predictions that we obtain when we apply our method in the accuracy of the predictions that we obtain when we apply our method to previously unseen test data*.

In practice, one can usually compute the training MSE with relative ease, but estimating test MSE is considerably more difficult because usually no test data are available. The flexibility level corresponding to the model with the minimal test MSE can vary considerably among data sets(数据集中的灵活性level可能会有很大差异).

## The Bias-Variance Trade-Off
The expected test MSE, for a given value $$x_0$$ can be decomposed into the sum of three fundamental quantities: the variance of $$\hat f(x_0)$$, the squared bias of $$\hat f(x_0)$$ and the variance of the error terms $$\epsilon$$, that is:
$$
E(y_0 - \hat f(x_0))=Var(\hat f(x_0))+[Bias(\hat f(x_0))]^2 + Var(\epsilon)
$$
It tells us that in order to minimize the expected test error, we need to select a statistical learning method that simultaneously achieves **low variance** and **low bias**.

### What do we mean by the variance and bias?
*Variance* refers to the amount by which $$\hat f$$ would change if we estimated it using a different training data set.

Since the training data are used to fit the statistical learning method, different training data sets will result in a different $$\hat f$$. Ideally the estimate for $$f$$ should not vary too much between training sets. However, if a method has high variance, then small changes in the training data can result in large changes in $$\hat f$$, **more flexible statistical method have higher variance**.

*Bias* refers to the error that is introduced by approximating a real-life problem, which may be extremely complicated, by a much simpler model. Generally, more flexible methods result in less bias.

As a general rule, as we use more flexible methods, the variance will increase and the bias will decrease. The relative rate of change of these two quantities determines whether the test MSE increases or decreases.

### Relationship between Variance, Bias
Good test set performance of a statistical learning method requires low variance as well as low squared bias. The challenge lies in finding a method for which both the variance and the squared bias are low. This trade-off is one of the most important recurring themes in this book.
