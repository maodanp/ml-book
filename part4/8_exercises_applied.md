## Q10
This question should be answered using the **Weekly** data set, which is part of the **ISLR** package. This data is similar in nature to the **Smarket** data from this chapter’s lab, except that it contains 1,089 weekly returns for 21 years, from the beginning of 1990 to the end of 2010.
### 10.a
Produce some numerical and graphical summaries of the **Weekly** data. Do there appear to be any patterns?
~~~
library(ISLR)
summary(Weekly)

cor(Weekly)

attach(Weekly)
plot(Volume)
~~~

The correlations between the "lag" variables and today's returns are close to zero.The only substantial correlation is between "Year" and "Volume", when we plot "Volume", we see that it is increasing over time.

### 10.b
Use the full data set to perform a logistic regression with **Direction** as the response and the five lag variables plus **Volume** as predictors. Use the summary function to print the results. Do any of the predictors appear to be statistically significant? If so, which ones?
~~~
fit.glm<-glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data=Weekly, family=binomial)
summary(fit.glm)

Coefficients:
            Estimate Std. Error z value Pr(>|z|)   
(Intercept)  0.26686    0.08593   3.106   0.0019 **
Lag1        -0.04127    0.02641  -1.563   0.1181   
Lag2         0.05844    0.02686   2.175   0.0296 *
Lag3        -0.01606    0.02666  -0.602   0.5469   
Lag4        -0.02779    0.02646  -1.050   0.2937   
Lag5        -0.01447    0.02638  -0.549   0.5833   
Volume      -0.02274    0.03690  -0.616   0.5377   
~~~
It would seem that "Lag2" is the only predictor statistically significant as its p-value is less than 0.05

### 10.c
Compute the confusion matrix and overall fraction of correct predictions. Explain what the confusion matrix is telling you about the types of mistakes made by logistic regression.
~~~
probs<-predict(fit.glm, type="response")
pred.glm<-rep("Down", length(prbos))
pred.glm[probs > 0.5] <- "Up"
table(pred.glm, Direction)

          Direction
pred.glm    Down     Up
    Down     54      48
    Up      430     557
~~~
We may conclude that the percentage of correct predictions on the training data is $$(54+557)/1089$$ which is equal to $$56.1065197\%$$. In other words, $$43.8934\%$$ is the training error rate, which is often overly optimistic.

* True positive rate: for weeks when the market goes up, the model is right $$92.0661157\%$$ of the time (557/(48+557))
* True Negative rate: for weeks when the market goes down, the model is right only $$11.1570248\%$$ of the time (54/(54+430))

### 10.d
Now fit the logistic regression model using a training data period from 1990 to 2008, with Lag2 as the only predictor. Compute the confusion matrix and the overall fraction of correct predictions for the held out data (that is, the data from 2009 and 2010).

~~~
train <- (Year < 2009)
Weekly.20092010 <- Weekly[!train,]
Direction.20092010 <- Direction[!train]
fit.glm2 <- glm(Direction~Lag2, data=Weekly, family=binomial, subset=train)
summary(fit.glm2)
~~~

~~~
probs2 <- predict(fit.glm2, Weekly.20092010, type = "response")
pred.glm2 <- rep("Down", length(probs2))
pred.glm2[probs2 > 0.5] <- "Up"
table(pred.glm2, Direction.20092010)

          Direction
pred.glm   Down     Up
    Down     9      5
    Up      34     56
~~~
In this case, we may conclude that the percentage of correct predictions on the test data is $$62.5\%$$. In other words, $$37.5\%$$ is the test error rate.

* For weeks goes up, the model is right $$91.8032787\%$$
* For weeks goes down, the model is right only $$20.9302326\%$$

### 10.e
Repeat (d) using LDA.
~~~
library(MASS)
fit.lda <- lda(Direction ~ Lag2, data=Weekly, subset=train)
fit.lda

Prior probabilities of groups:
     Down        Up
0.4477157 0.5522843

Group means:
            Lag2
Down -0.03568254
Up    0.26036581

Coefficients of linear discriminants:
           LD1
Lag2 0.4414162
~~~

~~~
pred.lda <- predict(fit.lda, Weekly.20092010, type = "response")
table(pred.lda$class, Direction.20092010)

        Direction.20092010
        Down Up
Down    9  5
Up     34 56
~~~
The percentage of correct predictions on the test data is $$62.5\%$$.
* For weeks goes up, the model is right $$91.8032787\%$$
* For weeks goes down, the model is right only $$20.9302326\%$$

### 10.f
Repeat (d) using QDA.
~~~
fit.qda <- qda(Direction ~ Lag2, data=Weekly, subset=train)
fit.qda

Prior probabilities of groups:
     Down        Up
0.4477157 0.5522843

Group means:
            Lag2
Down -0.03568254
Up    0.26036581

Coefficients of linear discriminants:
           LD1
Lag2 0.4414162
~~~
~~~
pred.qda <- predict(fit.qda, Weekly.20092010)
table(pred.qda$class, Direction.20092010)

          Direction.20092010
          Down Up
  Down    0  0
  Up     43 61
~~~
The percentage of correct predictions on the test data is $$58.663\%$$.In other words $$41.3461538\%$$ is the test error rate.
* For weeks goes up, the model is right $$100\%$$
* For weeks goes down, the model is right only $$0\%$$

We may note, that QDA achieves a correctness of $$58.6538462\%$$ even though the model chooses “Up” the whole time.

### 10.g
Repeat (d) using KNN with K = 1.
~~~
library(class)
train.X <- as.matrix(Lag2[train])
test.X <- as.matrix(Lag2[!train])
train.Direction <- Direction[train]
set.seed(1)
pred.knn <- knn(train.X, test.X, train.Direction, k = 1)
table(pred.knn, Direction.20092010)

      Direction.20092010
pred.knn Down Up
Down     21 30
Up       22 31
~~~
The percentage of correct predictions on the test data is $$50\%$$. In other words $$50\%$$ is the test error rate.
* For weeks goes up, the model is right $$50.8196721\%$$
* For weeks goes down, the model is right only $$48.8372093\%$$

### 10.h
Which of these methods appears to provide the best results on this data?

If we compare the test error rate, we see that logistic regression and LDA have the minimum error rates, followed by QDA and KNN.

### 10.i
Experiment with different combinations of predictors, including possible transformations and interactions, for each of the methods. Report the variables, method, and associated confusion matrix that appears to provide the best results on the held out data. Note that you should also experiment with values for K in the KNN classifier.
~~~
# Logistic regression with Lag2:Lag1
fit.glm3 <- glm(Direction ~ Lag2:Lag1, data = Weekly, family = binomial, subset = train)
probs3 <- predict(fit.glm3, Weekly.20092010, type = "response")
pred.glm3 <- rep("Down", length(probs3))
pred.glm3[probs3 > 0.5] = "Up"
table(pred.glm3, Direction.20092010)
mean(pred.glm3 == Direction.20092010)
0.5865385
~~~

~~~
# LDA with Lag2 interaction with Lag1
fit.lda2 <- lda(Direction ~ Lag2:Lag1, data = Weekly, subset = train)
pred.lda2 <- predict(fit.lda2, Weekly.20092010)
mean(pred.lda2$class == Direction.20092010)
0.5769231
~~~

~~~
# QDA with sqrt(abs(Lag2))
fit.qda2 <- qda(Direction ~ Lag2 + sqrt(abs(Lag2)), data = Weekly, subset = train)
pred.qda2 <- predict(fit.qda2, Weekly.20092010)
table(pred.qda2$class, Direction.20092010)
mean(pred.qda2$class == Direction.20092010)
0.5769231
~~~

~~~
# KNN k =10
pred.knn2 <- knn(train.X, test.X, train.Direction, k = 10)
table(pred.knn2, Direction.20092010)
mean(pred.knn2 == Direction.20092010)

# KNN k = 100
pred.knn3 <- knn(train.X, test.X, train.Direction, k = 100)
table(pred.knn3, Direction.20092010)
mean(pred.knn3 == Direction.20092010)
0.5576923
~~~
Out of these combinations, the original logistic regression and LDA have the best performance in terms of test error rates.

## 11
In this problem, you will develop a model to predict whether a given car gets high or low gas mileage based on the Auto data set.

### 11.a
Create a binary variable, **mpg01**, that contains a 1 if mpg contains a value above its median, and a 0 if mpg contains a value below its median. You can compute the median using the median() function. Note you may find it helpful to use the data.frame() function to create a single data set containing both **mpg01** and the other **Auto** variables.
~~~
attach(Auto)
mpg01 <- rep(0, length(mpg))
mpg01[mpg > median(mpg)] <- 1
Auto <- data.frame(Auto, mpg01)
~~~

### 11.b
Explore the data graphically in order to investigate the association between mpg01 and the other features. Which of the other features seem most likely to be useful in predicting mpg01? Scatterplots and boxplots may be useful tools to answer this question. Describe your findings.
~~~
cor(Auto[, -9])

                    mpg  cylinders    displacement horsepower  weight    acceleration  year     origin      mpg01
mpg           1.0000000 -0.7776175   -0.8051269 -0.7784268 -0.8322442    0.4233285  0.5805410  0.5652088  0.8369392
cylinders    -0.7776175  1.0000000    0.9508233  0.8429834  0.8975273   -0.5046834 -0.3456474 -0.5689316 -0.7591939
displacement -0.8051269  0.9508233    1.0000000  0.8972570  0.9329944   -0.5438005 -0.3698552 -0.6145351 -0.7534766
horsepower   -0.7784268  0.8429834    0.8972570  1.0000000  0.8645377   -0.6891955 -0.4163615 -0.4551715 -0.6670526
weight       -0.8322442  0.8975273    0.9329944  0.8645377  1.0000000   -0.4168392 -0.3091199 -0.5850054 -0.7577566
acceleration  0.4233285 -0.5046834   -0.5438005 -0.6891955 -0.4168392    1.0000000  0.2903161  0.2127458  0.3468215
year          0.5805410 -0.3456474   -0.3698552 -0.4163615 -0.3091199    0.2903161  1.0000000  0.1815277  0.4299042
origin        0.5652088 -0.5689316   -0.6145351 -0.4551715 -0.5850054    0.2127458  0.1815277  1.0000000  0.5136984
mpg01         0.8369392 -0.7591939   -0.7534766 -0.6670526 -0.7577566    0.3468215  0.4299042  0.5136984  1.0000000

pairs(Auto)

boxplot(cylinders ~ mpg01, data=Auto, main="cylinders vs mpg01")
boxplot(displacement ~ mpg01, data=Auto, main="displacement vs mpg01")
boxplot(horsepower ~ mpg01, data=Auto, main="horsepower vs mpg01")
boxplot(weight ~ mpg01, data=Auto, main="weight vs mpg01")
boxplot(acceleration ~ mpg01, data=Auto, main="acceleration vs mpg01")
boxplot(year ~ mpg01, data=Auto, main="year vs mpg01")
boxplot(origin ~ mpg01, data=Auto, main="origin vs mpg01")
~~~
We may conclude that there exists some association between "mpg01" and "cyclinders","weight","displacement" and "horsepower".

### 11.c
Split the data into a training set and a test set.
~~~
train <- (year %%2 == 0)
Auto.train <- Auto[train,]
Auto.test <- Auto[!train,]
mpg01.test <- mpg01[!train]
~~~

### 11.d
Perform LDA on the training data in order to predict **mpg01** using the variables that seemed most associated with **mpg01** in **(b)**. What is the test error of the model obtained?
~~~
library(MASS)
fit.lda <- lda(mpg01 ~ cylinders+weight+displacement+horsepower, data=Auto, subset=train)
fit.lda
pred.lda <- predict(fit.lda, Auto.test)
table(pred.lda$class, mpg01.test)
mean(pred.lda$class != mpg01.test)
[1] 0.1263736
~~~

### 11.e
Perform QDA on the training data in order to predict **mpg01** using the variables that seemed most associated with **mpg01** in **(b)**. What is the test error of the model obtained?
~~~
fit.qda <- qda(mpg01 ~ cylinders+weight+displacement+horsepower, data=Auto, subset=train)
fit.qda
pred.qda <- predict(fit.qda, Auto.test)
table(pred.qda$class, mpg01.test)
mean(pred.lda$class != mpg01.test)
[1] 0.1263736
~~~

### 11.f
Perform logistic regression on the training data in order to predict **mpg01** using the variables that seemed most associated with **mpg01** in **(b)**. What is the test error of the model obtained?
~~~
fit.glm <- glm(mpg01 ~ cylinders+weight+displacement+horsepower, data=Auto, family=binomial, subset=train)
summary(fit.glm)
probs <- predict(fit.glm, Auto.test, type = "response")
pred.glm <- rep(0, length(probs))
pred.glm[probs > 0.5] = 1
table(pred.glm, mpg01.test)
mean(pred.glm != mpg01.test)
[1] 0.1208791
~~~

### 11.g
Perform KNN on the training data, with several values of K, in order to predict **mpg01**. Use only the variables that seemed most associated with **mpg01** in **(b)**. What test errors do you obtain? Which value of K seems to perform the best on this data set?
~~~
train.X <- cbind(cylinders, weight, displacement, horsepower)[train, ]
test.X <- cbind(cylinders, weight, displacement, horsepower)[!train, ]
train.mpg01 <- mpg01[train]
set.seed(1)
pred.knn <- knn(train.X, test.X, train.mpg01, k = 1)
table(pred.knn, mpg01.test)
mean(pred.knn!=mpg01.test)
0.1538462
~~~
~~~
pred.knn <- knn(train.X, test.X, train.mpg01, k = 10)
table(pred.knn, mpg01.test)
mean(pred.knn!=mpg01.test)
[1] 0.1648352
~~~
~~~
pred.knn <- knn(train.X, test.X, train.mpg01, k = 100)
table(pred.knn, mpg01.test)
mean(pred.knn!=mpg01.test)
0.1428571
~~~
We have concluded that we have a test error of $$14.2857143\% $$ for K=100.  So, a K value of 100 seems to perform the best

## 12
This problem involves writing functions.

### 12.a
Write a function, **Power()**, that prints out the result of raising 2 to the 3rd power. In other words, your function should compute 23 and print out the results.
~~~
Power2 <- function() {
    2^3
}

Power()
~~~

### 12.b
Create a new function, Power2(), that allows you to pass any two numbers, x and a, and prints out the value of x^a. You can do this by beginning your function with the line.
~~~
Power2=function(x,a){
    x^a
}
Power2(3,8)
~~~

### 12.c
Using the Power2() function that you just wrote, compute $$10^3$$, $$8^17$$, and $$131^3$$.
~~~
Power2(10, 3)
Power2(8, 17)
Power2(131, 3)
~~~

### 12.d
Now create a new function, **Power3()**, that actually returns the result x^a as an R object, rather than simply printing it to the screen. That is, if you store the value x^a in an object called result within your function, then you can simply return() this result, using the following line:
~~~
Power3 <- function(x , a) {
    result <- x^a
    return(result)
}
~~~

### 12.e
Now using the **Power3()** function, create a plot of $$f(x) = x^2$$. The x-axis should display a range of integers from 1 to 10, and the y-axis should display $$x^2$$. Label the axes appropriately, and use an appropriate title for the figure. Consider displaying either the x-axis, the y-axis, or both on the log-scale. You can do this by using log=‘‘x’’, log=‘‘y’, or log=‘‘xy’’ as arguments to the plot() function.
~~~
x<-1:10
plot(x， Power(x, 2), xlab="Log of x", ylab="Log of x^2", main="Log of x^2 vs Log of x")
~~~

### 12.f
Create a function, **PlotPower()**, that allows you to create a plot of x against x^a for a fixed a and for a range of values of x. For instance, if you call
~~~
PlotPower <- function(x, a) {
    plot(x, Power3(x, a))
}

PlotPower(1:10, 3)
~~~

## 13
Using the **Boston** data set, fit classification models in order to predict whether a given suburb has a crime rate above or below the median. Explore logistic regression, LDA, and KNN models using various sub- sets of the predictors. Describe your findings.

~~~
attach(Boston)
crim01 <- rep(0, length(crim))
crim01[crim > median(crim)] <- 1
Auto <- data.frame(Boston, crim01)

train <- 1:(length(crim)/2)
test <- (length(crim)/2) + 1 : length(crim)
Boston.train <- Boston[train,]
Boston.test <- Boston[test,]
crim01.test <- crim01[test]
~~~

~~~
## logistic regression
fit.glm <- glm(crim01 ~ . - crim01 - crim, data=Boston, family=binomial, subset=train)
#summary(fit.glm)
probs <- predict(fit.glm, crim01.test, type = "response")
pred.glm <- rep(0, length(probs))
pred.glm[probs > 0.5] = 1
table(pred.glm, crim01.test)
mean(pred.glm != crim01.test)
[1] 0.1818182
~~~
We may conclude that, for this logistic regression, we have a test error rate of $$18.1818182\%$$.
~~~
## LDA
library(MASS)
fit.lda <- lda(crim01 ~ . - crim01 - crim, data=Boston, subset=train)
#fit.lda
pred.lda <- predict(fit.lda, Boston.test)
table(pred.lda$class, crim01.test)
mean(pred.lda$class != crim01.test)
[1] 0.1343874
~~~
We may conclude that, for this LDA, we have a test error rate of $$13.4387352\%$$.
~~~
## QDA
fit.qda <- qda(crim01 ~ . - crim01 - crim, data=Boston, subset=train)
#fit.lda <- lda(crim01 ~ . - crim01 - crim - chas - nox, data = Boston, subset = train)
pred.qda <- predict(fit.qda, Boston.test)
table(pred.qda$class, crim01.test)
mean(pred.lda$class != crim01.test)
0.1343874
#0.1501976
~~~

~~~
## KNN

### k=1
train.X <- cbind(zn, indus, chas, nox, rm, age, dis, rad, tax, ptratio, black, lstat, medv)[train, ]
test.X <- cbind(zn, indus, chas, nox, rm, age, dis, rad, tax, ptratio, black, lstat, medv)[!train, ]
train.crim01 <- crim01[train]
set.seed(1)
pred.knn <- knn(train.X, test.X, train.crim01, k = 1)
table(pred.knn, crim01.test)
mean(pred.knn!= crim01.test)
0.458498

### k=10
train.X <- cbind(zn, indus, chas, nox, rm, age, dis, rad, tax, ptratio, black, lstat, medv)[train, ]
test.X <- cbind(zn, indus, chas, nox, rm, age, dis, rad, tax, ptratio, black, lstat, medv)[!train, ]
train.crim01 <- crim01[train]
set.seed(1)
pred.knn <- knn(train.X, test.X, train.crim01, k = 10)
table(pred.knn, crim01.test)
mean(pred.knn!= crim01.test)
0.1185771

### k=10
train.X <- cbind(zn, indus, chas, nox, rm, age, dis, rad, tax, ptratio, black, lstat, medv)[train, ]
test.X <- cbind(zn, indus, chas, nox, rm, age, dis, rad, tax, ptratio, black, lstat, medv)[!train, ]
train.crim01 <- crim01[train]
set.seed(1)
pred.knn <- knn(train.X, test.X, train.crim01, k = 100)
table(pred.knn, crim01.test)
mean(pred.knn!= crim01.test)
0.4901186
~~~
