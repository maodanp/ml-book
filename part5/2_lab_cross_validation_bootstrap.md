## The Validation Set Approach
It is generally a good idea to set a random seed when performing an analysis such as cross-validation that contains an element of randomness, so that the results obtained can be reproduced precisely at a later time.

* Using the **sample()** function to split the set of observations into two halves.
* Using **predict()** function to estimate the response for all 392 observations, **-train** index below selects only the observations that not in the training set.
* Using **mean()** function to calculate the MSE of the 196 observations in the validation set.
~~~
library(ISLR)
set.seed(1)
train = sample(392, 196)
lm.fit = lm(mpg ~ horsepower, data=Auto, subset=train)
attach(Auto)
mean((mpg-predict(lm.fit, Auto))[-train]^2)
~~~
* Using the **poly()** function to estimate the test error for the polynomial and cubic regreesions.
~~~
lm.fit2=lm(mpg ~ poly(horsepower, 2), data=Auto, subset=train)
mean((mpg-predict(lm.fit2, Auto))[-train]^2)
lm.fit3=lm(mpg ~ poly(horsepower, 3), data=Auto, subset=train)
mean((mpg-predict(lm.fit3, Auto))[-train]^2)
~~~

> A model that predicts mpg using a quadratic function of horsepower performs better than a model that involves only a liner function of horsepower.

### Leave-One-Out Cross-Validation
we will perform linear regression using **glm()** function rather than the **lm()** function because the latter can be used together with **cv.glm()**.
~~~
glm.fit=glm(mpg~horsepower ,data=Auto)

loocv=function(fit){
  h=lm.influence(fit)$h
  mean((residuals(fit)/(1-h))^2)
}
loocv(glm.fit)
~~~
### k-Folder Cross-Validation
The **cv.glm()** function can also be used to implement k-fold CV.
~~~
cv.error10=rep(0,5)
degree=1:5
for(d in degree){
  glm.fit=glm(mpg~poly(horsepower, d), data=Auto)
  cv.error10[d] = cv.glm(Auto, glm.fit, K=10)$delta[1]
}
lines(degree, cv.error10, type="b", col="red")
~~~
Using cubic or higher-order polynomial terms leads to lower test error than simply using a quadratic fit.

### The Bootstrap
#### Estimating the Accuracy of a Statistic of Interest

Performing a bootstrap analysis in R entails only two steps:
* Create a function that computes the statistic of interest
* Using the **boot()** function, which is part of the **boot** library, to perform the bootstrap by repeatedly sampling observations from the data set with replacement

~~~
alpha=function(x, y){
  vx=var(x)
  vy=var(y)
  cxy=cov(x,y)
  (vy-cxy)/(vx+vy-2*cxy)
}
alpha(Portfolio$X, Portfolio$Y)

What is the standard error of alpha?
alpha.fn=function(data, index){
  with(data[index,], alpha(X, Y))
}

The following command tells R to estimate alpha using all 100 observations
alpha.fn(Portfolio, 1:100)

Using sample() function to randomly select 100 observations from the range 1 to 100 with replacement
set.seed(1)
alpha.fn(Portfolio, sample(1:100, 100, replace=TRUE))
~~~
We can implement a bootstrap analysis by performing this command many times, recording all of the corresponding estimates for $$\alpha$$, and computeing the resulting standard deviation, Or using the **boot()** function automates this approach.
~~~
boot.out=boot(Portfolio, alpha.fn, R=1000)
~~~

### Estimating the Accuracy of a Linear Regression Model
The bootstrap approach can be used to access the variability of the coefficient estimate and predictions from a statistical learning method.(bootstrap方法可用于评估来自统计学习方法的系数估计和预测的变异性).

Create a simple function, takes in the data set as well as a set of indices for the observations, and returns the intercept and slope estimates for the linear regression model.
~~~
boot.fn=function(data, index){
  return (coef(lm(mpg~horsepower, data=data, subset=index)))
}
boot.fn(Auto ,1:392)
~~~
create bootstrap estimates for the intercept and slope terms by randomly samplying from among the observations with replacement
~~~
set.seed(1)
boot.fn(Auto, sample(1:392, 392, replace=TRUE))
~~~
Next, use the **boot()** function to compute the standard errors of 1000 bootstrap estimates for the intercept and slope terms.
~~~
set.seed(1)
boot.fn(Auto, sample(1:392, 392, replace=TRUE))
boot.out=boot(Auto, boot.fn, R=1000)
boot.out
~~~
