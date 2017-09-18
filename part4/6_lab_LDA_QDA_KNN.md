## The Stock Market Data

~~~
library(ISLR)
names(Smarket)
dim(Smarket)
summary(Smarket)
pairs(Smarket)
~~~
The **cor()** function produces a matrix that contains all of the pairwise correlations among the predictors in a data set.
~~~
cor(Smarket[,-9])
~~~
As one would expect, the correlations between the lag variables and today's returns are close to zero(there appears to be little correlation between today's returns and previous days' returns).The only substantial correlation is between **Year** and **Volume**.

## Logistic Regression
Fit a logistic regression model in order to predict **Direction** using **Lag1** through **Lag5** and **Volume**. The **glm()** function fits generalized linear model.

~~~
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data=Smarket, family=binomial)
summary(glm.fit)
~~~
* The **predict()** function can be used to predict the probability that the market will go up, given values of the predictors.
* The **type="response"** option tells R to output probabilities of the form $$P(Y=1|X)$$.
* If no data set is supplied to the **predict()** function, then the probabilities are computed for the training data that was used to fit the logistic regression model.
* In order to make a predictioin as to whether the market will go up or down on a particular day, we must convert these predicted probabilities into class labels, **up or down**.
* **table()** function can be used to produce a Confusion matrix in order to determine how many observations were correctly or incorrectly classified.
* **mean()** function can be used to compute the fraction of days for which the prediction was correct.

~~~
glm.probs=predict(glm.fit, type="response")

glm.probs[1:10]

glm.pred=rep("Down", 1250)
glm.pred[glm.probs>.5]="Up"

table(glm.pred, Direction)
        Direction
glm.pred Down Up
    Down 145 141
    Up 457 507

mean(glm.pred==Direction)
  0.5216
~~~
* At first glance, it appears that the logistic regression model is working a little better than random guessing.
* However, this result is misleading because we trained and tested the model on the same set of 1250 observations.As we have seen previously, the training error rate is often overly optimistic-it tends to underestimate the test error rate(训练误差率往往过于乐观, 它往往低估了测试误差率！).

~~~
train=(Year<2005)
Smarket.2005=Smarket[!train,]
dim(Smarket.2005)
Direction.2005=Direction[!train]
~~~
* We now fit a logistic regression model using only the subset of the observations that correspond to datas before 2005, using **subset** argument(training was performed using only the dates before 2005).
* Then obtain predicted probabilities of the stock market going up for each of the days in out test-that is, for the days in 2005(testing was performed using only the dates in 2005).
* Computed the predictions for 2005 and compare them to the actual movements of the market over that time period

~~~
glm.fit=glm(Direction~Lag1+Lag2+Lag3+Lag4+Lag5+Volume, data=Smarket, family=binomial, subset=train)
gml.probs=predict(glm.fit, Smarket.2005, type="response")

glm.pred=rep("Down", 1250)
glm.pred[glm.probs>.5]="Up"
table(glm.pred, Direction.2005)
      Direction.2005
glm.pred Down Up
    Down 77 97
    Up   34 44
mean(glm.pred==Direction.2005)
  0.48

mean(glm.pred==Direction.2005)
  0.52
~~~

Perhaps by removing the variables that appear not to be helpful in predicting **Direction**, we can obtain a more effective model, and so removing such predictors may in turn yield an improvement.
> After all, using predictors that have no relationship with the response tends to cause a deterioration in the test error rate(since such predictors cause an increase in variance without a corresponding decrease in bias).

~~~
glm.fit=glm(Direction~Lag1+Lag2, data=Smarket, family=binomial, subset=train)
gml.probs=predict(glm.fit, Smarket.2005, type="response")
gml.probs=predict(glm.fit, Smarket.2005, type="response")

glm.pred=rep("Down", 1250)
glm.pred[glm.probs>.5]="Up"
table(glm.pred, Direction.2005)

        Direction.2005
glm.pred Down Up
      Down 35 35
      Up   76  106

mean(glm.pred==Direction.2005)
    0.582
~~~

## Linear Discriminant Analysis
Fit a LDA model using the **lda()** function, which is part of the **MASS** library.We fit the model using only the observations before 2005.

~~~
library(MASS)
lda.fit=lda(Direction~Lag1+Lag2, data=Smarket, subset=train)
lda.fit

 Prior probabilities of groups:
  Down   Up
  0.492 0.508

Group means :
        Lag1     Lag2
Down    0.0428  0.9339
Up     -0.0395  -0.0313

Coefficients of linear discriminants:
            LD1
Lag1 -0.6420190
Lag2 -0.5135293
~~~

* **Prior probabilities**: LDA output indicates that $$\hat \pi_1=0.492$$ and $$\hat \pi_2=0.508$$.
* **Group mean**: the average of each predictor within each class, and are used by LDA as estimates of $$u_k$$
* **Coefficients of LDA**: provides the linear combination of **Lag1** and **Lag2** that are used to form the LDA decision rule.In other words, these are the multipliers of the elements of $$X=x$$ in $$(4.19)$$. if $$-0.642 \times Lag1 -0.514 \times Lag2$$ is large, then the LDA classifier will predict a market increase, if it is small, then the LDA classifier will predict a market decline.

~~~
lda.pred = predict(lda.fit, Smarket.2005)
lad.class = lad.pred$class
table(lda.class, Direction.2005)
        Direction.2005
glm.pred Down Up
     Down 35  35
     Up   76  106

mean(lda.class==Direction.2005)
  0.56
~~~
The default threshold $$50 \%$$ to the posterior probabilities allow us to recreate the predictions contained in **lds.pred$class**

~~~
sum(lda.pred$posterior[,1]>=.5)
  70

sum(lda.pred$posterior[,1]<.5)
  182
~~~

## Quadratic Discriminant Analysis
QDA is implemented in R using the **qda()** function, which is also part of the **MASS** library. The syntax is identical to that of **lda()**.

~~~
qda.fit=qda(Direction~Lag1+Lag2, data=Smarket, subset=train)
qda.fit

Prior probabilities of groups:
 Down   Up
 0.492 0.508

 Group means :
         Lag1     Lag2
 Down    0.0428  0.9339
 Up     -0.0395  -0.0313
~~~
The output contains the group means, but it doesn't contain the coefficients of the linear discriminants, because the QDA classifier involves a quadratic, rather than a linear, function of the predictors.

The **predict()** function works in exactly the same fashion as for LDA

~~~
qda.class=predict(qda.fit, Smarket, Smarket.2005)$class
table(qda.class, Direction.2005)

        Direction.2005
glm.pred Down Up
    Down 30  20
    Up   81  121

mean(qda.class == Direction.2005)
  0.599
~~~
The QDA predictions are accurate almost $$60\%$$ of the time, this suggests that the quadratic from assumed by QDA may capture the true relationship more accurately than the linear forms assumed by LDA and logistic regression.

These model-fitting functions have a two-step approach in which we first **fit the model** and then we **use the model to make predictions**.

## K-nearest Neighbors
Perform KNN using the **knn()** function, which is part of the **class** library. **knn()** forms predictions using a single command, the function requires four inputs.
1. A matrix containing the predictors associated with the training data, labeled **train.X** below.
2. A matrix containing the predictors associated with the data for which we wish to make predictions, labeled **test.X** below.
3. A vector containing the class labels for the training observations labeled **train.Direction** below.
4. A value for K, the number of nearest neighbors to be used by the classifier.

~~~
library(class)
train.X=cbind(Lag1, Lag2)[train,]
test.X=cbind(Lag1, Lag2)[!train,]
train.Direction=Direction[train]

set.seed(1)
knn.pred=knn(train.X, test.X, train.Directioin, k=1)
table(knn.pred, Direction.2005)
      Direction.2005
glm.pred Down Up
    Down 43  58
    Up   68  83
mean(knn.pred==Directioin.2005)
  0.5

knn.pred=knn(train.X, test.X, train.Directioin, k=1)
table(knn.pred, Direction.2005)
      Direction.2005
glm.pred Down Up
    Down 48  54
    Up   63  87
mean(knn.pred==Directioin.2005)
  0.536
~~~

The results have improved slightly, but increasing K further turns out to provide no further improvements. It appears that for this data, QDA provides the best results of the methods that we have examined so far.
