## Q1
Using a little bit of algebra, prove that (4.2) is equivalent to (4.13). In other words, the logistic function representation and logit representation for the logit regression model are equivalent.

$$
p(x) = \frac{e^{\beta_0 + \beta_1x}}{ 1 + e^{\beta_0 + \beta_1x}}  \Rightarrow \frac{p(x)}{1-p(x)}=e^{\beta_0 + \beta_1x}
$$

## Q2
It was stated in the text that classifying an observation to the class for which (4.12) is largest is equivalent to classifying an observation to the class for which (4.13) is largest.Prove that this is the case.

In other words, under the assumption that the observations in the $$k$$th class are drawn from a $$N(\mu_k, \sigma^2)$$ distribution, the Bayes' classifier assigns an observation to the class for which the discriminant function is maximized(贝叶斯分类器将观察值分配给能使得判别函数最大化的类).
$$
p_k(x) = \frac{\pi_k\frac{1}{\sqrt{2 \pi}\sigma}e^{(-1/2\sigma^2)(x-u_k)^2}}{\sum_{l=1}^K\pi_l\frac{1}{\sqrt{2 \pi}\sigma}e^{(-1/2\sigma^2)(x-u_l)^2}}
$$

$$
p_k(x) = \frac{\pi_k e^{(-1/2\sigma^2)(x-u_k)^2}}{\sum_{l=1}^K\pi_l e^{(-1/2\sigma^2)(x-u_l)^2}}
$$

As the log function is monotonally increasing, it is equivalent to finding $$k$$ for which
$$
log(p_k(x))=log(\pi_k)-\frac{1}{2\sigma^2}(x-\mu_x)^2+log{\sum_{l=1}^K \pi_l e^{(-1/2\sigma^2)(x-u_l)^2}}
$$

As the last term is independant of $$k$$, we may restrict ourselves in finding $$k$$ for which
$$
log(\pi_k)-\frac{1}{2\sigma^2}(x-\mu_x)^2=log(\pi_k)-\frac{1}{2\sigma^2}x^2+\frac{\mu_k}{\sigma^2}x-\frac{\mu_k^2}{2\sigma^2}
$$
is largest. The term in $$x^2$$ is independant of $$k$$, so it remains to find $$k$$ for which
$$
\delta_k(x) = x \cdot \frac{u_k}{\sigma^2} - \frac{u_k^2}{2\sigma^2} + log(\pi_k)
$$
is largest

## Q3
Suppose that we have K classes, and that if an observation belongs to the $$k$$th class then X comes from a one-dimensional normal distribution, $$X \sim N(\mu_k, \sigma_k^2)$$. Recall that the density function for the one-dimensional normal distribution is given in (4.11). Prove that in this case, the Bayes' classifier is not linear. Argue that it is in fact quadratic.

Finding $$k$$ for which $$p_k(x)$$ is largest is equivalent to finding $$k$$ for which
$$
log(\pi_k)-\frac{1}{2\sigma_k^2}(x-\mu_x)^2=log(\pi_k)-\frac{1}{2\sigma_k^2}x^2+\frac{\mu_k}{\sigma_k^2}x-\frac{\mu_k^2}{2\sigma_k^2}
$$
is largest.This last expression is obviously not linear in $$x$$.

## Q4
When the number of features $$p$$ is large, there tends to be a deterioration in the performance of KNN.This phenomenon is known as the *curse of dimensionality*, and it ties into the fact that non-parametric approaches often perform poorly when $$p$$ is large.
### 4.a
Suppose that we have a set of observations, each with measurements on $$p=1$$ feature, $$X$$. On average, what fraction of the available observations will we use to make the prediction?

It is clear that if $$x \in [0.05,0.95] $$ then the observations we will use are in the interval $$[x-0.05,x+0.05]$$ and consequently represents a length of 0.10 which represents a fraction of $$10\%$$.

If $$x<0.05$$, then we will use observations in the interval $$[0,x+0.05]$$ which represents a fraction of $$(100x+5)\%$$

By a similar argument we conclude that if $$x>0.95$$, then the fraction of observations we will use is $$(105-100x)\%$$. To compute the average fraction we will use to make the prediction we have to evaluate the following expression:
~~~
\int_0.05^0.95 10dx + \int_0^0.05 (100x+5)dx + \int_0.95^1(105-100x)dx=9.75
~~~
the fraction of available observations we will use to make the prediction is
$$9.75\%$$.

### 4.b
Now suppose that we have a set of observations, each with measurements on $$p = 2$$ features, $$X_1$$ and $$X_2$$. We assume that $$(X_1,X_2)$$ are uniformly distributed on $$[0, 1]\times[0, 1]$$. We wish to predict a test observation’s response using only observations that are within $$10\%$$ of the range of $$X1$$ and within $$10\%$$ of the range of $$X2$$ closest to that test observation. On average, what fraction of the available observations will we use to make the prediction?

If we assume that $$X_1 X_2$$ to be independent, the fraction of available observations we will use to make the prediction is: $$ 9.75\% \times 9.75\%=0.950625\%$$

### 4.c
Now suppose that we have a set of observations on $$p = 100$$ features. Again the observations are uniformly distributed on each feature, and again each feature ranges in value from 0 to 1. We wish to predict a test observation’s response using observations within the $$10\%$$ of each feature’s range that is closest to that test observation. What fraction of the available observations will we use to make the prediction?

With the same argument than $$(a)$$ and $$(b)$$, we may conclude that the fraction of available observations we will use to make the prediction is $$9.75\%^{100} \simeq 0\%$$.

### 4.d
Using your answers to parts $$(a)$$ - $$(c)$$, argue that a drawback of KNN when p is large is that there are very few training observations “near” any given test observation.

As we saw in $$(a)-(c)$$, the fraction of available observations we will use to make the prediction is $$(9.75\%)^p$$ with pp the number of features. So when $$p \to \infty$$, we have
$$
\displaystyle \lim_{ p \to \infty }(9.75\%)^p = 0
$$

### 4.e
Now suppose that we wish to make a prediction for a test observation by creating a p-dimensional hypercube centered around the test observation that contains, on average, 10 % of the training observations. For $$p = 1,2$$, and 100, what is the length of each side of the hypercube? Comment on your answer.

For $$p=1$$, we have $$l=0.1$$, for $$p=2$$, we have $$l=0.1^{1/2}$$, and for $$p=100$$, we have $$l=0.1^{1/100}$$.
