We model the distribution of the predictors $$X$$ separately in each of the response classes(在每个相应类别中分别对预测变量X的分布进行建模)， and then use Bayes' theorem to flip these around into estimates  for $$P(Y=k|X=x)$$. When these distribution are assumed to be normal, it turns out that the model is very similar in form to logistic regression.

Why do we need another method, when we have logistic regression? There are several reasons:
* When the classes are well-separated, the parameter estimates for the logistic regression model are surprisingly unstable. Linear discriminant analysis does not suffer from this problem.
* If n is small and the distribution of the predictor $$X$$ is approximately normal in each of the classes, the linear discriminant model is again more stable than the logistic model.
* Linear discriminant model is popular when we have more than two response classes.

## Using Bayes' Theorem for Classification
Suppose that we wish to classify an observation into one of $$K$$ classes.
* Let $$\pi_x$$ represent the overall or prior probability that a randomly chosen observation comes from the $$k$$th class
* Let $$f_k(X) \equiv Pr(X=x|Y=k)$$ denote the density function of $$X$$ for an observation that comes from the $$k$$th class. In other words, $$f_k(X)$$ is relatively large if there is a high probability that an observation i the $$k$$th class has $$X \approx x$$, and $$f_k(X)$$ is small if it is very unlikely that an observation in the $$k$$th class that has $$X \approx x$$
* We refer to $$p_k(x)$$ as the posterior probability that an observation $$X=x$$ belongs to the $$k$$th class. That is, it is the probability that the observation to the $$k$$th class, given the predictor value for that observation(给出观测值的预测，属于第$$k$$类的概率).

We will use the abbreviation $$p_k(X)=Pr(Y=k|X)$$. Then Bayes' theorem states that
$$
P_r(Y=k|X=x) = \frac{\pi_k f_k(X)}{\sum_{l=1}^K\pi_l f_l(x)}
$$

In general, estimating $$\pi_k$$ is easy if we have a random sample of $$Y$$s from the population. However, estimating $$f_k(X)$$ tends to be more challenging, unless we assume some simple forms for these densities.We need to develop a classifier that approximates the Bayes classifier.

## Linear discriminant analysis for $$p = 1$$
Assume that $$p=1$$ that is, we have only one predictor. Suppose we assume that $$f_k(x)$$ is normal or Gaussian. In the one-dimensional setting, the normal density takes the formula
$$
f_k(x) = \frac{1}{\sqrt{2 \pi}\sigma_k}exp(-\frac{1}{2\sigma_k^2}(x-u_k)^2)
$$
where $$u_k$$ and $$\sigma_k^2$$ are the mean and variance parameters for the $$k$$th class. Let us further assume that $$\sigma_1^2 = \sigma_K^2$$.
$$
p_k(x) = \frac{\pi_k\frac{1}{\sqrt{2 \pi}\sigma}e^{(-1/2\sigma^2)(x-u_k)^2}}{\sum_{l=1}^K\pi_l\frac{1}{\sqrt{2 \pi}\sigma}e^{(-1/2\sigma^2)(x-u_l)^2}}..............\text{4.12}
$$

Taking the log of $$(4.12)$$ and rerranging the terms, it is not hard to show that this is equivalent to assigning the observation to the class for which
$$
\delta_k(x) = x \cdot \frac{u_k}{\sigma^2} - \frac{u_k^2}{2\sigma^2} + log(\pi_k).............\text{4.13}
$$
is largest.

In practice, even if we are quite certain of our assumption that $$X$$ is drawn from a Gaussian distribution within each class, we still have to estimate the parameters $$u_1, ..., u_K, \pi_1,...,\pi_K, \sigma^2$$. The linear discriminant analysis method approximates the Bayes classifier by plugging estimates for $$\pi_k, u_k, \sigma^2$$ into $$(4.13)$$.

In particular, the following estimates are used:
$$
\hat u_k = \frac{1}{n_k}\sum_{i:y_i=k}x_i
$$

$$
\hat \sigma^2 = \frac{1}{n-K}\sum_{k=1}^K\sum_{i:y_i=k}(x_i - \hat u_k)^2
$$

Sometimes, we have konwledge of the class membership probability $$\pi_1,...,\pi_k$$, which can be used directly, in the absence of any additional information, LDA estimates $$\pi_k$$ using the proportion of the training observations that belong to the $$k$$th class.

$$
\hat \pi_k = \frac{n_k}{n}
$$

The LDS classifier plugs the estimates, and assigns an observation $$X=x$$ to the class for which is largest.
$$
\hat \delta_k(x) = x \cdot \frac{\hat u_k}{\sigma^2} - \frac{\hat u_k^2}{2\sigma^2} + log(\hat \pi_k)
$$
The word linear in the classifier's name stems from the fact that the discriminant functions $$\hat \sigma_k(x)$$ are linear functions of x.

To reiterate, the LDA classifier results from assuming that the observations within each class come from a normal distribution with a class-specific mean vector and a common variance $$\sigma^2$$, and plugging estimates for these parameters into the Bayes classifier.

## Linear discriminant Analysis for $$p>1$$

We assume that $$X=(X_1, X_2,...,X_p)$$ is drawn from a multivariate Gaussian(or multivariate normal) distribution, with a class-specific mean vector and a common covariance matrix.

To indicate that a p-dimensional radom variable $$X$$ has a multivariate Gaussian distribution, we write $$X \sim N(\mu, \Sigma)$$. Here $$E(X)=\mu $$ and $$Cov(X)=\Sigma$$.

Formally, the multivariate Gaussian density is defined as:
$$
f_k(x) = \frac{1}{(2 \pi)^{p/2}|\Sigma|^{1/2}}exp(-\frac{1}{2}(x-\mu)^T\Sigma^{-1}(x-\mu))
$$

The LDA classifier assumes that the observations in the $$k$$th class are drawn from a multivariate Gaussian distribution $$N(\mu, \Sigma)$$. where $$\mu_k$$ is a class-specific mean vector, and $$\Sigma$$ is a covariance matrix that is common to all $$K$$ classes.

The Bayes classifier assigns an observations $$X=x$$ to the class for which is largest.
$$
\delta_k(x) = x^T\Sigma^{-1}\mu_k - \frac{1}{2}\mu_k^T\Sigma^{-1}\mu_k + log\pi_k
$$

|  | Actual class 1 | Actual class 0 |
| ------| ------ | ------ |
| Predicted class 1 | TP | FP |
| Predicted class 0 | FN | TN |

* Sensitivity(覆盖率 True Positive Rate)/Recall(召回率): 正确被检索/应该被检索 $$TP/(TP+FN)$$
* Specificity(负例的覆盖率 True Negative Rate): $$TN/(FP+TN)$$
* Precison(精确率): 正确被检索/实际被检索 $$TP/(TP+FP)$$
* Accuracy(准确率): 正确分类的样本数/总样本数 $$TP/(TP+FP+FN+TN)$$

## Other forms of discriminant Analysis

$$
Pr(Y=k|X=x)=\frac{\pi_kf_k(x)}{\sum_{l=1}^K\pi_l f_l(x)}
$$

By altering the forms for $$f_k(x)$$, we get different classifier.
* When $$f_k(x)$$ are Gaussian densities, with the same covariance matrix $$\Sigma$$ in each class, we get *LDA*.
* With Gaussians but different $$\Sigma_k$$ in each class, we get *QDA*
* With $$f_k(x)=\prod_{j=1}^p f_{jk}(x_j)$$ (conditional independence model) in each class, we get *navie Bayes*. For Gaussian, this means the $$\Sigma_k$$ are diagonal

### Quadratic Discriment Analysis

LDA assumes that the observations within each class are drawn from a multivariate Gaussian distribution with a class-specific mean vector and a covariance matrix that is common to all $$K$$ classes.

Quadratic discriminant analysis provides an alternative approach.Like LDA, the QDA classifier results from assuming that the observations from each class are drawn from a Gaussian distribution, and plugging estimates for the parameters into Bayes' theorem in order to perform prediction.

However, unlike LDA, QDA assumes that each class has its own covariance matrix.That is, it assumes that an observation from the $$k$$th class is of the form $$X \sim N(\mu_k, \Sigma_k)$$.

The Bayes classifier assigns an observation $$X=x$$ to the class for which below formal is largest.
$$
\delta_k(x) = -frac{1}{2}(x-\mu_k)^T\Sigma_k^{-1}(x-\mu_k) + log\pi_k......(4.23)
$$

So the QDA classifier involves plugging estimates for $$\Sigma_k, \mu_k, \pi_k$$ into $$(4.23)$$, and then assigning an observation $$X=x$$ to the class for which the quantity is largest.

**LDA v.s. QDA**. Why would one prefer LDA to QDA, or vice-versa? The answer lies in the bias-variance trade-off. LDA is much less flexible classifier than QDA, and so has substantially lower variance.

> If LDA's assumption that the $$K$$ classes share a common covariance matrix is badly off, than LDA can suffer from high bias

* LDA tends to be a better bet than QDA if there are relatively few training observations and so reducing variance is crucial.
* In contrast, QDA is recommended if the training set is very large, so that the variance of the classifier is not a major concern, or if the assumption of a common covariance matrix for the K classes is clearly untenable.

### Naive Bayes
Assumes features are independent in each class.It's useful when p is large, and so multivariate methods like QDA and even LDA break down.
* Gaussian naive Bayes assumes each $$\Sigma_k$$ is diagonal
* can use for mixed feature veectors(qualitative and quantitative).If $$X_j$$ is qualitative, replace $$f_{kj}(x_j)$$ with probability mass function (histogram) over discrete categories.


## Reference
[Confusion Matrix(混淆矩阵)](http://blog.csdn.net/wowotuo/article/details/38262057)

[ROC曲线](https://zh.wikipedia.org/wiki/ROC%E6%9B%B2%E7%BA%BF)
