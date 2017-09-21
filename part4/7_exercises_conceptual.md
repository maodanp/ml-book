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
$$
\int_0.05^0.95 10dx + \int_0^0.05 (100x+5)dx + \int_0.95^1(105-100x)dx=9.75
$$
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

## Q5
We now examine the differences between LDA and QDA.
### 5.a
If the Bayes decision boundary is linear, do we expect LDA or QDA to perform better on the training set? On the test set?

If the Bayes decision boundary is linear, we expect QDA to perform better on the training set because its higher flexibility may yield a closer fit. On the test set, we expect LDA to perform better than QDA, because QDA could overfit the linearity on the Bayes decision boundary.

### 5.b
If the Bayes decision boundary is non-linear, do we expect LDA or QDA to perform better on the training set? On the test set?

If the Bayes decision boundary is non-linear, we expect QDA to perform better both on the training and test sets.

### 5.c
In general, as the sample size n increases, do we expect the test prediction accuracy of QDA relative to LDA to improve, decline, or be unchanged? Why?

Roughly speaking, QDA(which is more flexible than LDA and so has higher variance) is recommended if the training set is very large, so that the variance of the classifier is not a major concern.

#### 5.d
True or False: Even if the Bayes decision boundary for a given problem is linear, we will probably achieve a superior test error rate using QDA rather than LDA because QDA is flexible enough to model a linear decision boundary. Justify your answer.

False, with fewer sample points, the variance from using a more flexible method such as QDA, may lead to overfit, which in turns may lead to an inferior test error rate.

## Q6
Suppose we collect data for a group of students in a statistics class with variables $$X_1$$ = hours studied, $$X_2$$ = undergrad GPA, and $$Y$$ = receive an A. We fit a logistic regression and produce estimated coefficient, $$\hat \beta_0=-6, \hat\beta_1=0.05, \hat\beta_2=1$$.

### 6.a
Estimate the probability that a student who studies for 40h and has an undergrad GPA of 3.5 gets an A in the class.


### 6.b
How many hours would the student in part (a) need to study to have a $$50 \%$$ chance of getting an A in the class?

## Q7
Suppose that we wish to predict whether a given stock will issue a dividend this year (“Yes” or “No”) based on X, last year’s percent profit. We examine a large number of companies and discover that the mean value of X for companies that issued a dividend was $$\hat X=10$$, while the mean for those that didn’t was $$\hat X=0$$. In addition, the variance of X for these two sets of companies was $$\delta^2=36$$. Finally, 80 % of companies issued dividends. Assuming that X follows a normal distribution, predict the probability that a company will issue a dividend this year given that its percentage profit was $$X=4$$ last year.

If suffices to plug in the parameters and $$X$$ values in the equation for $$p_k(x)$$, we getting
$$
p_1(4)=\frac{0.8e^{-(1/72)(4-10)^2}}{1+0.8e^{-(1/72)(4-10)^2}}=0.752
$$
so the probability that a company will issue a dividend this year given that its percentage return was $$X=4$$ last year is 0.752

## Q8
Suppose that we take a data set, divide it into equally-sized training and test sets, and then try out two different classification procedures. First we use logistic regression and get an error rate of $$20\%$$ on the training data and $$30\%$$ on the test data. Next we use 1-nearest neighbors and get an average error rate (averaged over both test and training data sets) of $$18\%$$. Based on these results, which method should we prefer to use for classification of new observations? Why?

 We have an average error rate of $$18\%$$ wich implies a test error rate of $$36\%$$ for KNN which is greater than the test error rate for logistic regression of $$30\%$$. So, it is better to choose logistic regression because of its lower test error rate.
