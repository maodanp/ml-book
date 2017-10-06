## Cross-Validation

training error v.s. test error
* The *test error* is the average error that results from using a statistical learning method to predict the response on a new observation, one that was not used in training the method.
* The *training error* can be easily calculated by applying the statistical learning method to the observations used in its training.
* But the *training error* rate is quite different from the test error rate, and in particular the former can *dramatically underestimate* the latter.

more on prediction-error estimates
* Best solution: a large designated test set. Often not available.
* Some methods make a *mathematical adjustment* to the training error rate in order to estimate the test error rate. These include the *Cp statistic, AIC and BIC*.
* We instead consider a class of methods that estimate the test error by *holding out* a subset of the training observations from the fitting process, and then applying the statistical learning method to those held out observations.

### The Validation Set Approach

* Here, we randomly divide the available set of samples into two parts: a *training set* and a *validation* or *hold-out set*.
* The model is fit on the training set, and the fitted model is used to predict the responses for the observations in the validation set.
* The resulting validation-set error provides an estimate of the test error. This is typically assessed using MSE in the case of a quantitative response and misclassification rate in the case of a qualitative (discrete) response.

Drawbacks of validation set approach
* the validation estimate of the test error can be highly variable, depentding on precisely which observations are included in the training set and which observations are included in the validation set.
* In the validation approach, only a subset of the observations (those that are included in the training set rather than in the validation set) are used to fit the model.
* This suggests that the validation set error may tend to overestimate the test error for the model fit on the entire data set.

### Leave-One-Out Cross-Validation
Leave-One-Out Cross-Validation(LOOCV) is closely related to the validation set approach, but it attempts to address that method's drawbacks.

LOOCV involves splitting the set of observations in two parts. However, instead of creating two subsets of comparable size, a single observation $$(x_1, y_1)$$ is used for the validation set, and the remaining observations $${(x_2, y_2), ..., (x_n, y_n)}$$ make up the training set.

$$MSE_1=(y_1-\hat y_1)^2$$ provides an approximately unbiased estimate for the test error. Repeating this approach $$n$$ times produces n squared errors $$MSE_1,...MSE_n$$, the LOOCV estimate for the test MSE is the average of these n test error estimates:
$$
CV_{(n)} = \frac{1}{n}\sum_{i=1}^nMSE_i
$$

LOOCV is a very general method, and can be used with any kind of predictive modeling, but typically doesn't **shake up** the data enough. The estimates from each fold are highly correlated and hence their average can have high variance.

### k-Fold Cross-Validaion

* Let the K parts be $$C_1, C_2,...C_k$$, where $$C_k$$ denotes the indices of the observations in part k. There are $$n_k$$ observations in part $$k$$.
* Compute
$$
CV_{k} = \frac{1}{k}\sum_{i=1}^kMSE_i
$$
where
$$
MSE_k = \sum_{i \in C_k}(y_i - \hat y_i)^2/n_k
$$
* Setting $$K=n$$ yields n-fold or leave-one out cross-validation(LOOCV)

We might be performing cross-validation on *a number of statistical learning methods*, or on *a single method using different levels of flexibility*, in order to identify the method that results in the lowest test error. For this purpose, the location of the minimum point in the estimated test MSE curve is important, but the actual value of estimated test MSE is not.

### Bias-Variance Trade-Off for k-Fold Cross-Validation
*LOOCV* will give approximately unbiased estimates of the test error, since each training set contains $$n-1$$ observations, which is almost as many as the number of observations in the full data set. And performing *k-fold CV* will lead to an intermediate level of bias, since each training set contains $$(k-1)n/k$$ observations, fewer than in the LOOCV approach, but substantially more than in the validation set approach.

*LOOCV* has higher variance than does *k-fold CV* with $$k<n$$. Since the mean of many highly correlated quantities has highly variance than does the mean of many quantities that are not as highly correlated.

As these values have been shown empirically to yield test error rate estimates that suffer neither from excessively high bias nor from very high variance.

### Cross-Validation on Classification Problems
* We divide the data into $$K$$ roughly equal-sized parts $$C_1, C_2, ..., C_K$$. $$C_K$$ denotes the indices of the observations in part k, there are $$n_k$$ observations in part k: if n is a multiple of K.
* Compute
$$
CV_{n} = \frac{1}{n}\sum_{i=1}^nErr_i
$$
where $$Err_i=I(y_i \neq \hat y_i)$$

## Bootstrap
* The bootstrap is a flexible and powerful statistical tool that can be used to quantify the uncertainty associated with a given estimator or statistical learning method.
* For example, it can provide an estimate of the standard error of a coefficient, or a confidence interval for that coefficient.

### Real data
* The procedure outlined above cannot be applied, because for real data we cannot generate new samples from the original population.
* However, the bootstrap approach allows us to use a computer to mimic the process of obtaining new data sets, so that we can estimate the variability of our estimate without generating additional samples.
* Rather than repeatedly obtaining independent data sets from the population, we instead obtain distinct data sets by repeatedly sampling observations from the original data set with **replacement**.
* Each of "bootstrap data sets" is created by sampling **with replacement**, and is the **same size** as our original dataset.



## References
[bootstrap method为什么效果好](https://www.zhihu.com/question/38429969)
