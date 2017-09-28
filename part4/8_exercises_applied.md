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
Create a binary variable, mpg01, that contains a 1 if mpg contains a value above its median, and a 0 if mpg contains a value below its median. You can compute the median using the median() function. Note you may find it helpful to use the data.frame() function to create a single data set containing both mpg01 and the other Auto variables.
