## Q5
In Chapter 4, we used logistic regression to predict the probability of **default** using **income** and **balance** on the **Default** data set. We will now estimate the test error of this logistic regression model using the validation set approach. Do not forget to set a random seed before beginning your analysis.

### 5.a
Fit a logistic regression model that uses *income* and *balance* to predict *default*.
~~~
library(ISLR)
attach(Default)
set.seed(1)
fit.glm <- glm(default ~ income+balance, data=Default, family="binomial")
summary(fit.glm)
~~~
### 5.b
Using the validation set approach, estimate the test error of this model. In order to do this, you must perform the following steps:
5.b.1 Split the sample set into a training set and a validation set.
~~~
train <- sample(dim(Default)[1], dim(Default)[1]/2)
~~~
5.b.2 Fit a multiple logistic regression model using only the training observations.
~~~
fit.glm <- glm(default ~ income+balance, data=Default, family="binomial")
summary(fit.glm)
~~~
5.b.3 Obtain a prediction of default status for each individual in the validation set by computing the posterior probability of default for that individual, and classifying the individual to the **default** category if the posterior probability is greater than 0.5.
~~~
probs <- predict(fit.glm, newdata = Default[-train, ], type = "response")
pred.glm <- rep("No", length(probs))
pred.glm[probs > 0.5] <- "Yes"
~~~
5.b.4 Compute the validation set error, which is the fraction of the observations in the validation set that are misclassified.
~~~
mean(pred.glm != Default[-train,]$default)
~~~
We have a $$4.72\%$$ test error rate with the validation set approach.

### 5.c
Repeat the process in (b) three times, using three different splits of the observations into a training set and a validation set. Comment on the results obtained.
~~~
train <- sample(dim(Default)[1], dim(Default)[1] / 2)
fit.glm <- glm(default ~ income + balance, data = Default, family = "binomial", subset = train)
probs <- predict(fit.glm, newdata = Default[-train, ], type = "response")
pred.glm <- rep("No", length(probs))
pred.glm[probs > 0.5] <- "Yes"
mean(pred.glm != Default[-train, ]$default)

0.0236
0.028
0.0268
~~~
We see that the validation estimate of the test error rate can be variable, depending on the precisely which observations are included in the training set and which observations are included in the validation set.

### 5.d
Now consider a logistic regression model that predicts the probability of **default** using **income**, **balance**, and a dummy variable for **student**. Estimate the test error for this model using the validation set approach. Comment on whether or not including a dummy variable for student leads to a reduction in the test error rate.
~~~
train <- sample(dim(Default)[1], dim(Default)[1] / 2)
fit.glm <- glm(default ~ income + balance + student, data = Default, family = "binomial", subset = train)
probs <- predict(fit.glm, newdata = Default[-train, ], type = "response")
pred.glm <- rep("No", length(probs))
pred.glm[probs > 0.5] <- "Yes"
mean(pred.glm != Default[-train, ]$default)

0.0264
~~~
It doesn't seem that adding the "student" dummy variable leads to a reduction in the validation set estimate of the test error rate.

## Q6
We continue to consider the use of a logistic regression model to predict the probability of default using income and balance on the Default data set. In particular, we will now compute estimates for the standard errors of the income and balance logistic regression coefficients in two different ways: $$(1)$$ using the bootstrap, and $$(2)$$ using the standard formula for computing the standard errors in the **glm()** function. Do not forget to set a random seed before beginning your analysis.

### 6.a
Using the summary() and glm() functions, determine the estimated standard errors for the coefficients associated with **income** and **balance** in a multiple logistic regression model that uses both predictors.
~~~
set.seed(1)
fit.glm <- glm(default ~ income+balance, data=Default, family="binomial")
summary(fit.glm)

Coefficients:
              Estimate Std. Error z value Pr(>|z|)    
(Intercept) -1.154e+01  4.348e-01 -26.545  < 2e-16 ***
income       2.081e-05  4.985e-06   4.174 2.99e-05 ***
balance      5.647e-03  2.274e-04  24.836  < 2e-16 ***
~~~
The **glm()** estimates of the standard errors for the coefficients $$\beta_0, \beta_1, \beta_2$$ are respectively 4.348e-01, 4.985e-06, 2.274e-04

### 6.b
Write a function, **boot.fn()**, that takes as input the Default data set as well as an index of the observations, and that outputs the coefficient estimates for **income** and **balance** in the multiple logistic regression model.
~~~
boot.fn=function(data, index){
  fit <- glm(default ~ income+balance, data=data, family="binomial", subset=index)
  return (coef(fit))
}
~~~

### 6.c
Use the **boot()** function together with your **boot.fn()** function to estimate the standard errors of the logistic regression coefficients for **income** and **balance**.
~~~
library(boot)
boot(Default, boot.fn, 1000)

Bootstrap Statistics :
         original        bias     std. error
t1* -1.154047e+01 -8.008379e-03 4.239273e-01
t2*  2.080898e-05  5.870933e-08 4.582525e-06
t3*  5.647103e-03  2.299970e-06 2.267955e-04
~~~
The bootstrap estimates of the standard errors for the coefficients $$\beta_0, \beta_1, \beta_2$$ are respectively 4.239273e-01, 4.985e-06, 2.267955e-04

### 6.d
Comment on the estimated standard errors obtained using the **glm()** function and using your bootstrap function.

The estimated standard errors obtained by the two methods are pretty close.

## Q7
In Sections 5.3.2 and 5.3.3, we saw that the cv.glm() function can be used in order to compute the LOOCV test error estimate. Alternatively, one could compute those quantities using just the glm() and 5.4 Exercises predict.glm() functions, and a for loop.

You will now take this approach in order to compute the LOOCV error for a simple logistic regression model on the Weekly data set. Recall that in the context of classification problems, the LOOCV error is given in (5.4).

### 7.a
Fit a logistic regression model that predicts **Direction** using **Lag1** and **Lag2**.
~~~
set.seed(1)
fit.glm <- glm(Direction ~ Lag1+Lag2, data=Weekly, family="binomial")
summary(fit.glm)
~~~

### 7.b
Fit a logistic regression model that predicts Direction using Lag1 and Lag2 using all but the first observation.
~~~
fit.glm1 <- glm(Direction ~ Lag1+Lag2, data=Weekly[-1,], family="binomial")
summary(fit.glm)
~~~

### 7.c
Use the model from (b) to predict the direction of the first observation. You can do this by predicting that the first observation will go up if
$$P(Direction="Up"|Lag1, Lag2) > 0.5$$. Was this observation correctly classified?
~~~
predict.glm(fit.glm1, Weekly[1,], type="response")>0.5
~~~

### 7.d
Write a for loop from $$i=1$$ to $$i=n$$,where n is the number of observations in the data set, that performs each of the following steps:

i. Fit a logistic regression model using all but the ith observation to predict Direction using Lag1 and Lag2.

ii. Compute the posterior probability of the market moving up for the ith observation.

iii. Use the posterior probability for the ith observation in order to predict whether or not the market moves up.

iv. Determine whether or not an error was made in predicting the direction for the ith observation. If an error was made, then indicate this as a 1, and otherwise indicate it as a 0.
~~~
error <- rep(0, dim(Weekly)[1])
for (i in 1:dim(Weekly)[1]) {
fit.glm <- glm(Direction ~ Lag1+Lag2, data=Weekly[-i,], family="binomial")
pred.up <- predict.glm(fit.glm, Weekly[i,], type="response")>0.5
true.up <- Weekly[i, ]$Direction == "Up"
if(pred.up != true.up)
  error[i] <- 1
}
~~~


### 7.e
Take the average of the n numbers obtained in (d)iv in order to obtain the LOOCV estimate for the test error. Comment on the results.
~~~
mean(error)
~~~
The LOOCV estimate for the test error rate is $$44.9954086\%$$

## Q8
We will now perform cross-validation on a simulated data set.
### 8.a
Generate a simulated data set as follows:
~~~
> set.seed(1)
> y=rnorm(100)
> x=rnorm(100)
> y=x-2*x^2+rnorm(100)
~~~
In this data set, what is n and what is p? Write out the model used to generate the data in equation form.

Here, we have that $$n=100, p=2$$, the module used is
$$
Y=X-2X^2+\epsilon
$$

### 8.b
Create a scatterplot of X against Y . Comment on what you find.
~~~
plot(x, y)
~~~
The data obviously suggests a curved relationship.

### 8.c
Set a random seed, and then compute the LOOCV errors that result from fitting the following four models using least squares:
$$
Y=\beta_0+\beta_1X+\epsilon
$$
~~~
library(boot)
set.seed(1)
Data <- data.frame(x, y)
fit.glm.1 <- glm(y ~ x)
cv.glm(Data, fit.glm.1)$delta[1]

5.890979
~~~
$$
Y=\beta_0+\beta_1X+\beta_2X^2+\epsilon
$$
~~~
fit.glm.2 <- glm(y ~ poly(x,2))
cv.glm(Data, fit.glm.2)$delta[1]

1.086596
~~~
$$
Y=\beta_0+\beta_1X+\beta_2X^2+\beta_3X^3+\epsilon
$$
~~~
fit.glm.3 <- glm(y ~ poly(x,3))
cv.glm(Data, fit.glm.3)$delta[1]

1.102585
~~~
$$
Y=\beta_0+\beta_1X+\beta_2X^2+\beta_3X^3+\beta_4X^4+\epsilon
$$
~~~
fit.glm.4 <- glm(y ~ poly(x,4))
cv.glm(Data, fit.glm.4)$delta[1]

1.114772
~~~
### 8.d
Repeat (c) using another random seed, and report your results.
Are your results the same as what you got in (c)? Why?

The results above are identical to the results obtained in (c) since LOOCV evaluates nn folds of a single observation.

### 8.e
Which of the models in (c) had the smallest LOOCV error? Is this what you expected? Explain your answer.

We may see that the LOOCV estimate for the test MSE is minimum for “fit.glm.2”, this is not surprising since we saw clearly in (b) that the relation between “x” and “y” is quadratic.

### 8.f
Comment on the statistical significance of the coefficient estimates that results from fitting each of the models in (c) using least squares. Do these results agree with the conclusions drawn based on the cross-validation results?
~~~
summary(fit.glm.4)

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -1.8277     0.1041 -17.549   <2e-16 ***
poly(x, 4)1   2.3164     1.0415   2.224   0.0285 *  
poly(x, 4)2 -21.0586     1.0415 -20.220   <2e-16 ***
poly(x, 4)3  -0.3048     1.0415  -0.293   0.7704    
poly(x, 4)4  -0.4926     1.0415  -0.473   0.6373
~~~
The p-values show that the linear and quadratic terms are statistically significants and that the cubic and 4th degree terms are not statistically significants.

This agree strongly with our cross-validation results which were minimum for the quadratic model.

## Q9
We will now consider the **Boston** housing data set, from the **MASS** library.
### 9.a
Based on this data set, provide an estimate for the population mean of **medv**. Call this estimate $$\hat \mu$$.
~~~
library(MASS)
attach(Boston)
mu.hat <- mean(medv)
mu.hat

22.53281
~~~
### 9.b
Provide an estimate of the standard error of $$\hat \mu$$. Interpret this result.
~~~
se.hat <- sd(medv)/sqrt(dim(Boston)[1])
se.hat

 0.4088611
~~~

### 9.c
Now estimate the standard error of $$\hat \mu$$ using the bootstrap. How does this compare to your answer from (b)?
~~~
set.seed(1)
boot.fn <- function(data, index){
  mu <- mean(data[index])
  return (mu)
}
boot(medv, boot.fn, 1000)

Bootstrap Statistics :
    original      bias    std. error
t1* 22.53281 0.008517589   0.4119374
~~~
### 9.d
Based on your bootstrap estimate from (c), provide a 95% confidence interval for the mean of medv. Compare it to the results obtained using **t.test(Boston$medv)**.

Hint: You can approximate a 95 % confidence interval using the formula $$[\hat \mu-2SE(\hat \mu), \hat \mu + 2SE(\hat \mu)]$$.
~~~
t.test(medv)

## t = 55.1111, df = 505, p-value < 2.2e-16
## alternative hypothesis: true mean is not equal to 0
## 95 percent confidence interval:
##  21.72953 23.33608
## sample estimates:
## mean of x
##  22.53281
~~~
~~~
CI.mu.hat <- c(22.53 - 2 * 0.4119, 22.53 + 2 * 0.4119)
CI.mu.hat

21.7062 23.3538
~~~
The bootstrap confidence interval is very close to the one provided by the t.test() function.

### 9.e
Based on this data set, provide an estimate, $$\hat \mu_{med}$$, for the median value of medv in the population.
~~~
med.hat <- median(medv)
med.hat

21.2
~~~

### 9.f
~~~
boot.fn <- function(data, index) {
  mu <- median(data[index])
  return (mu)
}
boot(medv, boot.fn, 1000)

Bootstrap Statistics :
    original  bias    std. error
t1*     21.2 -0.0025    0.374358
~~~
We get an estimated median value of 21.2 which is equal to the value obtained in (e), with a standard error of 0.3874 which is relatively small compared to median value.

### 9.g
Based on this data set, provide an estimate for the tenth percentile of medv in Boston suburbs. Call this quantity $$\hat \mu_{0.1}$$. (You can use the quantile() function.)
~~~
percent.hat <- quantile(medv, c(0.1))
percent.hat

12.75
~~~

### 9.h
Use the bootstrap to estimate the standard error of μˆ0.1. Com- ment on your findings.
~~~
boot.fn <- function(data, index) {
  mu <- quantile(data[index], c(0.1))
  return (mu)
}
boot(medv, boot.fn, 1000)

Bootstrap Statistics :
    original  bias    std. error
t1*    12.75  0.0261   0.4912231
~~~
We get an estimated tenth percentile value of 12.75 which is again equal to the value obtained in (g), with a standard error of 0.5113 which is relatively small compared to percentile value.
