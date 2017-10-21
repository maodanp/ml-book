## Q1
We perform best subset, forward stepwise, and backward stepwise selection on a single data set. For each approach, we obtain $$p + 1$$ models, containing $$0, 1, 2, \ldots, p$$ predictors. Explain your answers:

### 1.a

Which of the three models with kk predictors has the smallest training RSS ?

* When performing best subset selection, the model with k predictors is the model with the smallest RSS among all the $$\binom{ p }{ k }$$ models with $$k$$ predictors.
* When performing forward stepwise selection, the model with k predictors is the model with smallest RSS among the $$p-k$$ models which augment the predictors in $$M_{k-1}$$ with one additional predictors(其在$$M_{k-1}$$基础上增加了一个额外预测因子).
* When performing backward stepwise selection, the model with k predictors is the model with smallest RSS among the k models which contains all but one of the predictors in $$M_{k=1}$$.
* So, the model with k predictors which has the smallest training RSS is the one obtained from best subset selectino as it it the one selected among all k perdictors models.

### 1.b

Which of the three models with kk predictors has the smallest test RSS ?

Difficult to answer: best subset selection may have the smallest test RSS because it takes into account more models than the other method.

However, the other methods might also pick a model with smaller test RSS by sheer luck.

### 1.c

True or False:

i: The predictors in the k-variable model identified by forward stepwise are a subset of the predictors in the (k+1)-variable model identified by forward stepwise selection.

True. The model with (k+1) predictors is obtained by augmenting the predictors in the models with k predictors with one additional predictor.

ii: The predictors in the k-variable model identified by backward stepwise are a subset of the predictors in the (k+1)-variable model identified by backward stepwise selection.

True. The model with k predictors is obtained by removing one predictor from the model with $$(k+1)$$ predictors.

iii: The predictors in the kk-variable model identified by backward stepwise are a subset of the predictors in the (k+1)-variable model identified by forward stepwise selection.

False.There is no direct link between the models obtained from forward and backward selection.

iv: The predictors in the kk-variable model identified by best subset are a subset of the predictors in the (k+1)-variable model identified by best subset selection.

False. The model with (k+1) predictors is obtained by selecting among all possible models with (k+1) predictors, and so does not necessarily contain all the predictors selected for the k-variable model.

## Q2

For parts (a) through (c), indicate which of i. through iv. is correct.Justify your answer.

### 2.a

The lasso, releative to least squares, is:

i: More flexible and hence will give improved prediction accruacy when its increase in bias is less than its decrease in variance.

ii: More flexible and hence will give improved prediction accuracy when its increase in variance is less than its decrease than in bias.

iii: Less flexible and hence will give improved prediction accruacy when its increase in bias is less than its decrease in variance. (TRUE)

iv: Less flexible and hence will give improved prediction accruacy when its increase invariance is less than its decrease in variance.

### 2.b

Repeat (a) for ridge regression relative to least squares.

Same as lasso.

### 2.c

Repeat (a) for non-linear methods relative to least squares.

Non-linear methods are more flexible and will give improved prediction accuracy when their increase in variance are less than their decrease in bias.

## Q3

Suppose we estimate the regression coefficients in a linear regression model by minimizing.
$$
minimize_{\beta}\sum_{i=1}^n(y_i - \beta_0 - \sum_{j=1}^p\beta_jx_{ij})^2 \qquad \text{subject to} \qquad \sum_{j=1}^p|\beta_j|\le s
$$
for a particular value of $$s$$, For pars (a) through (e), indicate which of i. through v. is correct. Justify your answer.

### 3.a

As we increase s from 0, the training RSS will:

Steadily decrease. As we increase s from 0, we are restricting the $$\beta_j$$ coefficients less and less (the coefficients will increase to their least squares estimates), and so the model is becoming more and more flexible which provokes a steady decrease in the training RSS.

### 3.b

Repeat (a) for test RSS.

Decrease initially, and then eventually start increasing in a U shape. As we increase ss from 0, the model is becoming more and more flexible which provokes at first a decrease in the test RSS before increasing again after that in a typical U shape.

## 3.c

Repeat (a) for test variance.

Steadily increase. the model is becoming more and more flexible which provokes a steady increase in variance.

## 3.d

Repeat (a) for (squared) bias.

Steadily decrease. the model is becoming more and more flexible which provokes a steady decrease in bias.

## 3.e

Repeat (a) for irreducible error.

Reamin constant. By definition, the irreducible error is independant of the model, and consequently independant of the value of $$s$$.

## Q4

Suppose we estimate the regression coefficients in a linear regression model by minimizing
$$
minimize_{\beta}\sum_{i=1}^n(y_i - \beta_0 - \sum_{j=1}^p\beta_jx_{ij})^2 \qquad \text{subject to} \qquad \sum_{j=1}^p\beta_j^2\le s
$$
Same as Q3

## Q5

It is well-known that ridge regression tends to give similar coefficient values to correlated variables, whereas the lasso may give quite different coefficient values to correlated variables. We will now explore this property in a very simple setting.

Suppose that $$n = 2, p = 2, x_{11} = x_{12}, x_{21} = x_{22}$$. Furthermore,supposethat $$y_1+y_2 =0$$and$$x_{11}+x_{21} =0$$and$$x_{12}+x_{22} =0$$,so that the estimate for the intercept in a least squares, ridge regression, or lasso model is zero: $$\hat \beta_0=0$$.

## Q6

We will now explore (6.12) and (6.13) further.

### 6.a

Consider (6.12) with $$p=1$$. For some choice of $$y_1$$ and $$\lambda \gt 0$$, plot (6.12) as a function of $$\beta_1$$. Your plot should confirm that (6.12) is solved by (6.14)

~~~R
y <- 3
lambda <- 2
beta <-seq(-10, 10, 0.1)
plot(beta, (y - beta)^2 + lambda * beta^2, pch = 20, xlab = "beta", ylab = "Ridge optimization")
beta.est <- y/(1+lambda)
points(beta.est, (y - beta.est)^2 + lambda * beta.est^2, col = "red", pch = 4, lwd = 5)
~~~

We may see that the function is minimized at $$\beta=y/(1+\lambda)$$

### 6.b

Consider (6.13) with $$p=1$$. For some choice of $$y_1$$ and $$\lambda \gt 0$$, plot (6.13) as a function of $$\beta_1$$. Your plot should confirm that (6.13) is solved by (6.15)

~~~R
y <- 3
lambda <- 2
beta <- seq(-10, 10, 0.1)
plot(beta, (y - beta)^2 + lambda * abs(beta), pch = 20, xlab = "beta", ylab = "Lasso optimization")
beta.est <- y - lambda / 2
points(beta.est, (y - beta.est)^2 + lambda * abs(beta.est), col = "red", pch = 4, lwd = 5)
~~~

We may see that the function is minimized at $$\beta=y-\lambda/2$$ as $$y \gt \lambda/2$$.














​			
​		
​			
​	

​				
​			
​		
​	