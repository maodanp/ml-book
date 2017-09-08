## Libraries
~~~
library(MASS)
library(ISLR)

install.packages("ISLR")
~~~

## Simple Linear Regression
Using the $$lm()$$ function to fit a simple linear regression model. The basic syntax is $$lm(y~x, data)$$, where y is the response, x is the predictor, and data is the data set in which these two variables are kept.

The next line tells R that the variables are in Boston, if we attach Boston, the last line works fine because R now recognizes the variables.
~~~
fit1 = lm(medv~last, data=Boston)
attach(Boston)
fit1 = lm(medv~lstat)
~~~

If we type **lm.fit**, some basic information about the model is output. For more detailed information, we use **summary(lm.fit)**. This gives us p-values and standard errors for the coefficients, as well as the $$R^2$$ statistic and F-statistic for the model.
~~~
> fit1

Call:
lm(formula = medv ~ lstat, data = Boston)

Coefficients:
(Intercept)        lstat  
      34.55        -0.95  

> summary(fit1)

Call:
lm(formula = medv ~ lstat, data = Boston)

Residuals:
    Min      1Q  Median      3Q     Max
-15.168  -3.990  -1.318   2.034  24.500

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) 34.55384    0.56263   61.41   <2e-16 ***
lstat       -0.95005    0.03873  -24.53   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 6.216 on 504 degrees of freedom
Multiple R-squared:  0.5441,	Adjusted R-squared:  0.5432
F-statistic: 601.6 on 1 and 504 DF,  p-value: < 2.2e-16
~~~

It is safer to use the extractor functions like **coef()** to access them. In order to obtain a confidence interval for the coefficient estimates, we can use the confint() command
~~~
> coef(fit1)
(Intercept)       lstat
 34.5538409  -0.9500494

 > confint(fit1)
                 2.5 %     97.5 %
 (Intercept) 33.448457 35.6592247
 lstat       -1.026148 -0.8739505
~~~

The **predict()** function can be used to produce confidence intervals and prediction intervals for the prediction of **medv** for a given value of **lstat**.
~~~
> predict(fit1, data.frame(lstat=c(5,10,15)), interval='confidence')
       fit      lwr      upr
1 29.80359 29.00741 30.59978
2 25.05335 24.47413 25.63256
3 20.30310 19.73159 20.87461

> predict(fit1, data.frame(lstat=c(5,10,15)), interval='prediction')
       fit       lwr      upr
1 29.80359 17.565675 42.04151
2 25.05335 12.827626 37.27907
3 20.30310  8.077742 32.52846
~~~
As expected, the confidence and prediction intervals are centered around the same point, but the latter are substantially wider.
The **abline()** function can be used to draw any line, not just the least squares regression line. **abline(a,b)** draw a line with intercept a and slope b. The **lwd=3** command causes the width of the regression line to be increased by a factor of 3.
~~~
abline(a,b )
abline(fit1, lwd=3)
abline(fit1, lwd=3, col='red', pach=20)
~~~
**par(mfrow=c(2,2))** divides the plotting region into a $$2 \times 2$$ grid of panels.

## Multiple Linear regression
The syntax $$lm(y~x1+x2+x3)$$ is used to fit a model with three predictors, the **summary()** function now outputs the regression coefficients for all the predictors.
~~~
fit2=lm(medv~lstat+age, data=Boston)
summary(fit2)
fit3=lm(medv~., Boston)
summary(fit3)
par(mfrow=c(2,2))
plot(fit3)
fit4=update(fit3, ~., -age-indus)
summary(fit4)
~~~

## Non-linear Transformations of the Predictors
The **lm()** function can also accommodate non-linear transformations of the predictors. For instance, given a predictor X, we can create a predictor $$X^2$$ using $$I(X^2)$$.
~~~
fit5=lm(medv~lstat*age, Boston)
summary(fit5)
fit6=lm(medv~lstat+I(lstat^2), Boston); summary(fit6)

Call:
lm(formula = medv ~ lstat + I(lstat^2), data = Boston)

Residuals:
     Min       1Q   Median       3Q      Max
-15.2834  -3.8313  -0.5295   2.3095  25.4148

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 42.862007   0.872084   49.15   <2e-16 ***
lstat       -2.332821   0.123803  -18.84   <2e-16 ***
I(lstat^2)   0.043547   0.003745   11.63   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 5.524 on 503 degrees of freedom
Multiple R-squared:  0.6407,	Adjusted R-squared:  0.6393
F-statistic: 448.5 on 2 and 503 DF,  p-value: < 2.2e-16
~~~
We use the **anova()** function to further quantify the extent to which the quadratic fit is superior to the linear fit.
~~~
> lm.fit=lm(medv∼lstat) > anova(lm.fit ,lm.fit2)
anova()
      Analysis
Model 1: Model 2: Res.Df
1 504
2 503
---
of Variance Table
medv ∼ lstat
medv ∼ lstat + I(lstat^2)
RSS Df Sum of Sq F Pr(>F) 19472
15347 1 4125 135 <2e -16 ***
~~~
The  **anova()** function performs a hypothesis test comparing the two models.Here the F-statistic is 135 and the associated p-value is virtually zero. This provides very clear evidence that the model containing the predictors $$lstat$$ and $$lstat^2$$ is far superior to the model that only contains the predictor $$lstat$$.

In order to create a cubic fit, wee can use a better approach involves using the **poly()** function to create the polynomial with **lm()**.
~~~
 > lm.fit5=lm(medv∼poly(lstat ,5))
 > summary(lm.fit5)
~~~
This leads to an improvement in the model fit! However, further investigation of the data reveals that no polynomial terms beyond fifth order have significant p-values in a regression fit.

## Qualitative predictors
Given a qualitative variable such as **Shelveloc**, R generates dummy variables automatically.

~~~
> fit8=lm(Sales~.+Income:Advertising+Age:Price,Carseats)
> summary(fit8)

Call:
lm(formula = Sales ~ . + Income:Advertising + Age:Price, data = Carseats)

Residuals:
    Min      1Q  Median      3Q     Max
-2.9208 -0.7503  0.0177  0.6754  3.3413

Coefficients:
                     Estimate Std. Error t value Pr(>|t|)    
(Intercept)         6.5755654  1.0087470   6.519 2.22e-10 ***
CompPrice           0.0929371  0.0041183  22.567  < 2e-16 ***
Income              0.0108940  0.0026044   4.183 3.57e-05 ***
Advertising         0.0702462  0.0226091   3.107 0.002030 **
Population          0.0001592  0.0003679   0.433 0.665330    
Price              -0.1008064  0.0074399 -13.549  < 2e-16 ***
ShelveLocGood       4.8486762  0.1528378  31.724  < 2e-16 ***
ShelveLocMedium     1.9532620  0.1257682  15.531  < 2e-16 ***
Age                -0.0579466  0.0159506  -3.633 0.000318 ***
Education          -0.0208525  0.0196131  -1.063 0.288361    
UrbanYes            0.1401597  0.1124019   1.247 0.213171    
USYes              -0.1575571  0.1489234  -1.058 0.290729    
Income:Advertising  0.0007510  0.0002784   2.698 0.007290 **
Price:Age           0.0001068  0.0001333   0.801 0.423812    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.011 on 386 degrees of freedom
Multiple R-squared:  0.8761,	Adjusted R-squared:  0.8719
F-statistic:   210 on 13 and 386 DF,  p-value: < 2.2e-16
~~~
The **contrasts()** function returns the coding that R uses for the dummy variables.
~~~
> contrasts(Carseats$ShelveLoc)
       Good Medium
Bad       0      0
Good      1      0
Medium    0      1
~~~
