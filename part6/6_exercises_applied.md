## Q8
In this exercise, we will generate simulated data, and will then use this data to preform best subset selection.
### 8.a
Use the rnorm() function to generate a predictor $$X$$ of length $$n=100$$, as well as a noise vector $$\epsilon$$ of length $$n=100$$
~~~
set.seed(1)
x <- rnorm(100)
eps <- rnorm(100)
~~~

### 8.b
Generate a response vector Y of length $$n=100$$ according to the model:
$$
Y=\beta_0+\beta_1X+\beta_2X^2+\beta_3X^3+\epsilon
$$
where, $$\beta_0, \beta_1, \beta_2$$ are constants of your choice.
~~~

~~~
### 8.c
Use the `regsubsets()` function to perform best subset selection in order to choose the best model containing the predictors $$X, X^2, \ldots, X^{10}$$. What is the best model obtained according to Cp, BIC, and adjusted R2? Show some plots to provide evidence for your answer, and report the coefficients of the best model obtained. Note you will need to use the `data.frame()` function to create a single data set containing both X and Y .
~~~
library(leaps)
data.full <- data.frame(y = y, x = x)
regfit.full <- regsubsets(y ~ x + I(x^2) + I(x^3) + I(x^4) + I(x^5) + I(x^6) + I(x^7) + I(x^8) + I(x^9) + I(x^10), data = data.full, nvmax = 10)
reg.summary <- summary(regfit.full)
par(mfrow = c(2, 2))
plot(reg.summary$cp, xlab = "Number of variables", ylab = "C_p", type = "l")
points(which.min(reg.summary$cp), reg.summary$cp[which.min(reg.summary$cp)], col = "red", cex = 2, pch = 20)
plot(reg.summary$bic, xlab = "Number of variables", ylab = "BIC", type = "l")
points(which.min(reg.summary$bic), reg.summary$bic[which.min(reg.summary$bic)], col = "red", cex = 2, pch = 20)
plot(reg.summary$adjr2, xlab = "Number of variables", ylab = "Adjusted R^2", type = "l")
points(which.max(reg.summary$adjr2), reg.summary$adjr2[which.max(reg.summary$adjr2)], col = "red", cex = 2, pch = 20)

coef(regfit.full, which.max(reg.summary$adjr2))

(Intercept)           x      I(x^2)      I(x^3)      I(x^5)
 2.05976340  3.17278803 -1.00253435  0.37604671  0.01980385
~~~
We find, with $$C_p$$ we pick the 3-variables model, with BIC we pick the 3-variables model, and with adjusted $$R^2$$, we pick 3-variables model.

### 8.d
Repeat (c), using forward stepwise selection and also using back- wards stepwise selection. How does your answer compare to the results in (c)?
ignore code. Here, forward stepwise, backward stepwise and best subset all select the three variables model with $$X, X^2, X^5$$

### 8.e
Now fit a lasso model to the simulated data, again using $$X, X^2, \ldots, X^{10}$$. Create plots of the cross-validation error as a function of λ. Report the resulting coefficient estimates, and discuss the results obtained.
~~~
library(glmnet)
xmat <- model.matrix(y ~ x + I(x^2) + I(x^3) + I(x^4) + I(x^5) + I(x^6) + I(x^7) + I(x^8) + I(x^9) + I(x^10), data = data.full)[, -1]
cv.lasso <- cv.glmnet(xmat, y, alpha = 1)
plot(cv.lasso)
names(cv.lasso)
bestlam <- cv.lasso$lambda.min
#fit.lasso <- glmnet(xmat, y, alpha = 1)
predict(cv.lasso, s = bestlam, type = "coefficients")[1:11, ]

(Intercept)           x      I(x^2)      I(x^3)      I(x^4)      I(x^5)      I(x^6)      I(x^7)
 2.04091434  3.28373245 -1.10646862  0.14042235  0.00000000  0.06399454  0.00000000  0.00000000
     I(x^8)      I(x^9)     I(x^10)
 0.00000000  0.00000000  0.00000000
~~~

### 8.f
Now generate a response vector Y according to the model
$$
Y = \beta_0 + \beta_7X^7 + \epsilon,
$$
and perform best subset selection and the lasso. Discuss the results obtained.

We begin with best subset selection
~~~
b7 <- 7
y <- b0 + b7 * x^7 + eps
data.full <- data.frame(y = y, x = x)
regfit.full <- regsubsets(y ~ x + I(x^2) + I(x^3) + I(x^4) + I(x^5) + I(x^6) + I(x^7) + I(x^8) + I(x^9) + I(x^10), data = data.full, nvmax = 10)
reg.summary <- summary(regfit.full)
par(mfrow = c(2, 2))
plot(reg.summary$cp, xlab = "Number of variables", ylab = "C_p", type = "l")
points(which.min(reg.summary$cp), reg.summary$cp[which.min(reg.summary$cp)], col = "red", cex = 2, pch = 20)
plot(reg.summary$bic, xlab = "Number of variables", ylab = "BIC", type = "l")
points(which.min(reg.summary$bic), reg.summary$bic[which.min(reg.summary$bic)], col = "red", cex = 2, pch = 20)
plot(reg.summary$adjr2, xlab = "Number of variables", ylab = "Adjusted R^2", type = "l")
points(which.max(reg.summary$adjr2), reg.summary$adjr2[which.max(reg.summary$adjr2)], col = "red", cex = 2, pch = 20)
~~~

We find that, with CpCp we pick the 2-variables model, with BIC we pick the 1-variables model, and with adjusted R2R2 we pick the 4-variables model.
~~~
coef(regfit.full, 1)
## (Intercept)      I(x^7)
##     1.95894     7.00077

coef(regfit.full, 2)
## (Intercept)      I(x^2)      I(x^7)
##   2.0704904  -0.1417084   7.0015552

coef(regfit.full, 4)
## (Intercept)           x      I(x^2)      I(x^3)      I(x^7)
##   2.0762524   0.2914016  -0.1617671  -0.2526527   7.0091338
~~~
Here best subset selection with BIC picks the most accurate 1-variable model with matching coefficients.

Now we processed with the lasso
~~~
xmat <- model.matrix(y ~ x + I(x^2) + I(x^3) + I(x^4) + I(x^5) + I(x^6) + I(x^7) + I(x^8) + I(x^9) + I(x^10), data = data.full)[, -1]
cv.lasso <- cv.glmnet(xmat, y, alpha = 1)
bestlam <- cv.lasso$lambda.min
bestlam

12.36884
~~~

~~~
fit.lasso <- glmnet(xmat, y, alpha = 1)
predict(fit.lasso, s = bestlam, type = "coefficients")[1:11, ]

## (Intercept)           x      I(x^2)      I(x^3)      I(x^4)      I(x^5)
##    2.820215    0.000000    0.000000    0.000000    0.000000    0.000000
##      I(x^6)      I(x^7)      I(x^8)      I(x^9)     I(x^10)
##    0.000000    6.796694    0.000000    0.000000    0.000000
~~~
Here the lasso also picks the most accurate 1-variable model, but the intercept is quite off.

## Q9
In this exercise, we will predict the number of applications received using the other variables in the `College` data set.

### 9.a
Split the data set into a training set and a test set.
~~~
library(ISLR)
data(College)
set.seed(11)
train = sample(1:dim(College)[1], dim(College)[1]/2)
test <- -train
College.train <- College[train,]
College.text <- College[test]
~~~

### 9.b
Fit a linear model using least squares on the training set, and report the test error obtained.
~~~
fit.lm <- lm(Apps ~., data=College.train)
pred.lm <- predict(fit.lm, College.test)
mean((pred.lm-College.test$Apps)^2)

1538442
~~~
The test MSE is $$1.538442^6$$

### 9.c
Fit a ridge regression model on the training set, with $$\lambda$$ chosen by cross-validation. Report test error obtained.
~~~
train.mat <- model.matrix(Apps~., data=College.train)
test.mat <- model.matrix(Apps~., data=College.test)
grid <- 10^seq(4, -2, length=100)
fit.ridge <- glmnet(train.mat, College.train$Apps, alpha=0, lambda=grid, thresh=1e-12)
cv.ridge <- cv.glmnet(train.mat, College.train$Apps, alpha=0, lambda=grid, thresh=1e-12)
bestlam.ridge <- cv.ridge$lambda.min
bestlam.ridge

18.73817
~~~
~~~
pred.ridge <- predict(fit.ridge, s=bestlam.ridge, newx=test.mat)
mean((pred.ridge-College.test$Apps)^2)

1608859
~~~
The test MSE is higher for ridge regression than for least squares.

### 9.d
Fit a lasso model on the training set, with $$\lambda$$ chosen by cross-validation. Report test error obtained.
~~~
fit.lasso <- glmnet(train.mat, College.train$Apps, alpha=1, lambda=grid, thresh=1e-12)
cv.lasso <- cv.glmnet(train.mat, College.train$Apps, alpha=1, lambda=grid, thresh=1e-12)
bestlam.ridge <- cv.lasso$lambda.min
bestlam.ridge

21.54435
~~~

~~~
pred.ridge <- predict(fit.lasso, s=bestlam.ridge, newx=test.mat)
mean((pred.ridge-College.test$Apps)^2)

1635280
~~~
The test MSE is also higher for lasso regression tan for least squares.

## Q10
We have seen that as the number of features used in a model increases, the training error will necessarily decrease, but the test error may not. We will now explore this in a simulated data set.
### 10.a
Generate a data set with $$p=20$$ features, $$n=1000$$ observations, and an associated quantitative response vector generated according to the model
$$
Y=X\beta + \epsilon
$$
where $$\beta$$ has some elements that are exactly equal to zero.
~~~
set.seet(11)
x <- matrix(rnorm(1000*20), 1000, 20)
b <- rnorm(20)
b[3] <- 0
b[4] <- 0
b[9] <- 0
b[19] <- 0
b[10] <- 0
eps <- rnorm(1000)
y <- x %*% b + eps
~~~

### 10.b
Split your data set into a training set containing 100 observations and a test set containing 900 observations.
~~~
train <- sample(seq(1000), 100, replace = FALSE)
test <- -train
x.train <- x[train,]
x.test <- x[test,]
y.train <- y[train]
y.test <- y[test]
~~~

### 10.c
Perform best subset selection on the training set, and plot the training set MSE associated with the best model of each size.
~~~
data.train <- data.frame(y=y.train, x=x.train)
regfit.full <- regsubsets(y~., , data=data.train, nvmax=20)
train.mat <- model.matrix(y~., data=data.train,, nvman=20)
val.errors <- rep(NA, 20)
for (i in 1:20){
  coefi <- coef(regfit.full, id=i)
  pred <- train.mat[,names(coefi)]%*%coefi
  val.errors[i] = mean((pred-y.train)^2)
}
plot(val.errors, xlab="Number of predictors", ylab="Training MSE", pch=19, type="b")
~~~

### 10.d
Plot the test MSE associated with the best model of each size
~~~
data.test <- data.frame(y=y.test, x=x.test)
test.mat <- model.matrix(y~., data=data.test, nvmax=20)
for (i in 1:20){
  coefi <- coef(regfit.full, id=i)
  pred <- test.mat[,names(coefi)]%*%coefi
  val.errors[i] = mean((pred-y.test)^2)
}
plot(val.errors, xlab="Number of predictors", ylab="Test MSE", pch=19, type="b")
~~~

### 10.e
For which model size does the test set MSE take on its minimum value?
~~~
which.min(val.errors)
~~~

### 10.f
How does the model at which the test set MSE is minimized compare to the true model used to generate the data ? Comment on the coefficient values.
~~~
coef(regfit.full, which.min(val.errors))

-0.01926322  0.88374539  0.50963581  0.47039322 -0.73887264  0.57020444  0.47901609  0.54118473  0.96559331  1.56404010
       x.15        x.16        x.17        x.20
 1.66994947  0.42816210 -0.62526642  2.18793695
~~~
The best model caught all zeroed out coefficients.


## Q11
We will now try to predict per capita crime rate in the `Boston` data set.
### 11.a
Try out some of the regression methods explored in this chapter, such as best subset selection, the lasso, ridge regression, and PCR. Present and discuss results for the approaches that you consider.

We begin with best subset selection.
~~~
library(MASS)
data("Boston")
set.seed(1)
predict.regsubsets <- function(object, newdata, id, ...) {
  form <- as.formula(object$call[[2]])
  mat <- model.matrix(form, newdata)
  coefi <- coef(object, id = id)
  xvars <- names(coefi)
  mat[, xvars] %*% coefi
}

k=10
folds <- sample(1:k, nrow(Boston), replace=TRUE)
cv.errors <- matrix(NA, k, 13, dimnames = list(NULL, paste(1:13)))
for (j in 1:k) {
  best.fit <- regsubsets(crim ~ ., data = Boston[folds != j, ], nvmax = 13)
  for (i in 1:13) {
    pred <- predict(best.fit, Boston[folds == j, ], id = i)
    cv.errors[j, i] <- mean((Boston$crim[folds == j] - pred)^2)
  }
}
mean.cv.errors <- apply(cv.errors, 2, mean)
plot(mean.cv.errors, type = "b", xlab = "Number of variables", ylab = "CV error")
~~~
We may see that cross-validation selects an 12-variable model. We have a CV estimate for the test MSE equal to 41.0345657

Next we processed with the lasso.
~~~
x <- model.matrix(crim~., Boston)[, -1]
~~~

### 11.a
~~~
x <- model.matrix(crim~., Boston)[, -1]
y <- Boston$crim
cv.out <- cv.glmnet(x, y, alpha=1, type.measure = "mse")
plot(cv.out)
~~~
Here, cross-validation selects a $$\lambda$$ equal to 0.0467489, we have CV estimate for the test MSE equal to 42.134324
Next we processed with ridge regression.
~~~
cv.out <- cv.glmnet(x, y, alpha=0, type.measure = "mse")
plot(cv.out)
~~~
Here cross-validation selects a λλ equal to 0.5374992. We have a CV estimate for the test MSE equal to 42.9834518.

### 11.b
Propose a model (or set of models) that seem to perform well on this data set, and justify your answer. Make sure that you are evaluating model performance using validation set error, cross-validation, or some other reasonable alternative, as opposed to using training error.

As computed above the model with the lower cross-validation error is the one chosen by the best subset selection method.

### 11.c
Does your chosen model involve all of the features in the data set ? Why or why not ?

No, the model chosen by the best subset selection method has only 13 predictors.
