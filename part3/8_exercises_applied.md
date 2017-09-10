
##Applied
(8) This question involves the use of simple linear regression on the **Auto** data set.

(8.a) Use the **lm()** function to perform a simple linear regression with **mpg** as the response and **horsepower** as the predictor. Use the summary() function to print the results. Comment on the output.
~~~
Auto = read.csv('~/prj/git_prj/ml-book/part3/Auto.csv', header=T, na.strings="?")
#na.omit returns the object with incomplete cases removed
Auto = na.omit(Auto)
summary(Auto)

attach(Auto)
lm.fit = lm(mpg~horsepower)
summary(lm.fit)

Call:
lm(formula = mpg ~ horsepower)

Residuals:
     Min       1Q   Median       3Q      Max
-13.5710  -3.2592  -0.3435   2.7630  16.9240

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 39.935861   0.717499   55.66   <2e-16 ***
horsepower  -0.157845   0.006446  -24.49   <2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 4.906 on 390 degrees of freedom
Multiple R-squared:  0.6059,	Adjusted R-squared:  0.6049
F-statistic: 599.7 on 1 and 390 DF,  p-value: < 2.2e-16

~~~
For example:

i. Is there a relationship between the predictor and the response?

Yes, there is a relationship between horsepower and mpg as determined by testing the null hypothesis of all regression coefficients equal to zero. Since the F-statistic is far larger than 1 and the p-value of the F-statistic is close to zero, we can reject the null hypothesis and state there is a statistically significant relationship between horsepower and mpg.

ii. How strong is the relationship between the predictor and the response?

To calculate the **residual error** related to the response we use the **mean of the response** and the **RSE**. The mean of mpg is $$23.4459$$, the RSE of the lm.fit was $$4.906$$, which indicates a percentage error of $$20.9248\%$$.
The $$R^2$$ of the lm.fit was about $$0.6059$$, meaning$$60.59\%$$ of the variance in mpg is explained by horsepower.

iii. Is the relationship between the predictor and the response positive or negative?

The relationship between mpg and horsepower is negative.

iv. What is the predicted mpg associated with a horsepower of 98? What are the associated 95 % confidence and prediction intervals?

~~~
> predict(lm.fit, data.frame(horsepower=c(98)), interval="confidence")
       fit      lwr      upr
1 24.46708 23.97308 24.96108
> predict(lm.fit, data.frame(horsepower=c(98)), interval="predict")
       fit     lwr      upr
1 24.46708 14.8094 34.12476
~~~

(8.b) Plot the response and the predictor. Use the **abline()** function to display the least squares regression line.

~~~
plot(horsepower, mpg)
abline(lm.fit)
~~~

(8.c) Use the plot() function to produce diagnostic plots of the least squares regression fit. Comment on any problems you see with the fit.

~~~
par(mfrow=c(2,2))
plot(lm.fit)
~~~
Based on the redisual plots, there is some evidence of non-linearity

(9) This question involves the use of multiple linear regression on the Auto data set.

(9.a) Produce a scatterplot matrix which includes all of the variables in the data set.
~~~
pairs(Auto)
~~~

(9.b) Compute the matrix of correlations between the variables using the function **cor()**. You will need to exclude the name variable, which is qualitative.
~~~
cor(subset(Auto, select=-name))
~~~
(9.c) Use the **lm()** function to perform a multiple linear regression with mpg as the response and all other variables except name as the predictors. Use the summary() function to print the results. Comment on the output.
~~~
Call:
lm(formula = mpg ~ . - name, data = Auto)

Residuals:
    Min      1Q  Median      3Q     Max
-9.5903 -2.1565 -0.1169  1.8690 13.0604

Coefficients:
               Estimate Std. Error t value Pr(>|t|)    
(Intercept)  -17.218435   4.644294  -3.707  0.00024 ***
cylinders     -0.493376   0.323282  -1.526  0.12780    
displacement   0.019896   0.007515   2.647  0.00844 **
horsepower    -0.016951   0.013787  -1.230  0.21963    
weight        -0.006474   0.000652  -9.929  < 2e-16 ***
acceleration   0.080576   0.098845   0.815  0.41548    
year           0.750773   0.050973  14.729  < 2e-16 ***
origin         1.426141   0.278136   5.127 4.67e-07 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 3.328 on 384 degrees of freedom
Multiple R-squared:  0.8215,	Adjusted R-squared:  0.8182
F-statistic: 252.4 on 7 and 384 DF,  p-value: < 2.2e-16
~~~
i: Is there a relationship between the predictors and the response?

Yes, there is a relationship between the predictors and the response by testing the null hypothesis of whether all the regression coefficients are zero.The F-statistic is far from 1(with a small p-value), indicating evidence against the null hypothesis.

ii: Which predictors appear to have a statistically significant relationship to the response?

Looking at the p-values associated with each perdictor's t-statistic, we see the **displacement, weight, year, origin** have a statistically significant relationship, while cylinders, horsepower and acceleration do not.

iii: What does the coefficient for the **year** variable suggest?

The regression coefficient for year, $$0.7508$$, suggests that for every one year, mpg increases by the coefficient. In other words, cars become more fuel efficient every year by almost 1 mpg/year.

(9.d) Use the **plot()** function to produce diagnostic plots of the linear regression fit. Comment on any problems you see with the fit. Do the residual plots suggest any unusually large outliers? Does the leverage plot identify any observations with unusually high leverage?

~~~
par(mfrow=c(2,2))
plot(lm.fit1)
~~~
The fit does not appear to be accurate because there is a discernible curve pattern to the residual plots. From the leverage plot, point 14 appears to have a high leverage, although not a high magnitude residual.

~~~
plot(predict(lm.fit1), rstudent(lm.fit1))
~~~
There are possible outliers as seen in the plot of studentized residuals because there are data with a value greater than 3.

(9.e) Use the * and : symbols to fit linear regression models with interaction effects. Do any interactions appear to be statistically significant?
~~~
lm.fit2=lm(mpg~cylinders*displacement+displacement*weight)
summary(lm.fit2)

Call:
lm(formula = mpg ~ cylinders * displacement + displacement *
    weight)

Residuals:
     Min       1Q   Median       3Q      Max
-13.2934  -2.5184  -0.3476   1.8399  17.7723

Coefficients:
                         Estimate Std. Error t value Pr(>|t|)    
(Intercept)             5.262e+01  2.237e+00  23.519  < 2e-16 ***
cylinders               7.606e-01  7.669e-01   0.992    0.322    
displacement           -7.351e-02  1.669e-02  -4.403 1.38e-05 ***
weight                 -9.888e-03  1.329e-03  -7.438 6.69e-13 ***
cylinders:displacement -2.986e-03  3.426e-03  -0.872    0.384    
displacement:weight     2.128e-05  5.002e-06   4.254 2.64e-05 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 4.103 on 386 degrees of freedom
Multiple R-squared:  0.7272,	Adjusted R-squared:  0.7237
F-statistic: 205.8 on 5 and 386 DF,  p-value: < 2.2e-16
~~~
From the correlation matrix, I obtained the two highest correlated pairs and used them in picking my interaction effects. From the p-values, we can see that the interaction between displacement and weight is statistically significant, while the interaction between cylinders and displacement is not.

(9.f) Try a few different transformations of the variables, such as log(X), √X, X2. Comment on your findings.
~~~
lm.fit3 = lm(mpg~log(weight)+sqrt(horsepower)+acceleration+acceleration+I(acceleration^2))
summary(lm.fit3)
~~~
~~~
par(mfrow(2,2))
plot(lm.fit3)

plot(predict(lm.fit3, rstudent(lm.fit3)))
~~~
log(weight), sqrt(horsepower), acceleration^2 all have statistically significant of some sort.
The residuals plot has less of a discernible pattern than the plot of all linear regression terms(残差图的可识别度比所有线性回归项的曲线少).
The studentized residuals displays potential outliers (>3). The leverage plot indicates more than three points with high leverage.

However, 2 problems are observed from the above plots: 1) the residuals vs fitted plot indicates heteroskedasticity (unconstant variance over mean) in the model. 2) The Q-Q plot indicates somewhat unnormality of the residuals.

So, a better transformation need to be applied to our model. From the correlation matrix in 9a., displacement, horsepower and weight show a similar nonlinear pattern against our response mpg. This nonlinear pattern is very close to a log form. So in the next attempt, we use log(mpg) as our response variable.

The outputs show that log transform of mpg yield better model fitting (better R^2, normality of residuals).

~~~
lm.fit2<-lm(log(mpg)~cylinders+displacement+horsepower+weight+acceleration+year+origin,data=Auto)
summary(lm.fit2)

par(mfrow=c(2,2))
plot(lm.fit2)

plot(predict(lm.fit2),rstudent(lm.fit2))
~~~

(10) This question should be answered using the Carseats data set.

(10.a) Fit a multiple regression model to predict Sales using Price,
Urban, and US.
~~~
library(ISLR)
summary(Carseats)

attach(Carseats)
lm.fit = lm(Sales~Price+Urban+Us)
summary(lm.fit)

#contrasts(Urban)
#contrasts(US)
~~~
(10.b) Provide an interpretation of each coefficient in the model. Be
careful—some of the variables in the model are qualitative!

**Price**: The linear regression suggests a relationship between price and sales given the low p-value of the t-statistic. The coefficient states a negative relationship between Price and Sales: as Price increases, Sales decreases.

**UrbanYes**: The linear regression suggests that there isn’t a relationship between the location of the store and the number of sales based on the high p-value of the t-statistic.

**USYes**: The linear regression suggests there is a relationship between whether the store is in the US or not and the amount of sales. The coefficient states a positive relationship between USYes and Sales: if the store is in the US, the sales will increase by approximately 1201 units.

(10.c) Write out the model in equation form, being careful to handle the qualitative variables properly.
~~~
Sales = 13.04 + -0.05 Price + -0.02 UrbanYes + 1.20 USYes
~~~

(10.d) For which of the predictors can you reject the null hypothesis H0 :βj =0?
~~~
Price and USYes, based on the p-values, F-statistic, and p-value of the F-statistic.
~~~

(10.e) On the basis of your response to the previous question, fit a smaller model that only uses the predictors for which there is evidence of association with the outcome.
~~~
lm.fit2 = lm(Sales ~ Price + US)
summary(lm.fit2)
~~~

(10.f) How well do the models in (a) and (e) fit the data?

Based on the RSE and R^2 of the linear regressions, they both fit the data similarly, with linear regression from (e) fitting the data slightly better.

(10.g) Using the model from (e), obtain 95% confidence intervals for the coefficient(s).
~~~
confint(lm.fit2)
~~~

(10.h) Is there evidence of outliers or high leverage observations in the model from (e)?
~~~
plot(predict(lm.fit2), rstudent(lm.fit2))
~~~
All studentized residuals appear to be bounded by -3 to 3, so not potential outliers are suggested from the linear regression.

~~~
par(mfrow=c(2,2))
plot(lm.fit2)
~~~
There are a few observations that greatly exceed (p+1)/n (0.0076) on the leverage-statistic plot that suggest that the corresponding points have high leverage.

(11) In this problem we will investigate the t-statistic for the null hypoth- esis H0 : β = 0 in simple linear regression without an intercept. To begin, we generate a predictor x and a response y as follows.

~~~
> set . seed (1)
> x=rnorm(100)
> y=2*x+rnorm(100)
~~~

(11.a) Perform a simple linear regression of y onto x, without an intercept. Report the coefficient estimate $$\hat \beta$$, the standard error of this coefficient estimate, and the t-statistic and p-value associated with the null hypothesis $$H_0: \beta=0$$. Comment on these results. (You can perform regression without an intercept using the command **lm(y∼x+0)**.)

~~~
lm.fit = lm(y~x+0)
summary(lm.fit)
~~~
The p-value of the t-statistic is near zero so the null hypothesis is rejected.

(11.b) Now perform a simple linear regression of x onto y without an intercept, and report the coefficient estimate, its standard error, and the corresponding t-statistic and p-values associated with the null hypothesis $$H_0:\beta=0$$. Comment on these results.

~~~
lm.fit = lm(x~y+0)
summary(lm.fit)
~~~
The p-value of the t-statistic is near zero so the null hypothesis is rejected.

(11.c) What is the relationship between the results obtained in (a) and (b)?

Both results in (a) and (b) reflect the same line created in 11a. In other words, $$y=2x+ \epsilon$$ could also be written $$x=0.5 \times (y - \epsilon)$$.

(11.d) For the regression of Y onto X without an intercept, the t-statistic for $$H_0:\beta=0$$ takes the form $$\hat \beta/SE(\hat \beta)$$, where $$\hat \beta$$ is given by (3.38), and where
$$
SE(\hat \beta)=\sqrt{\frac{\sum_{i=1}^n(y_i-x_i\hat \beta)^2}{(n-1)\sum_{i'=1}^n x_{i'}^2}}
$$

~~~
(sqrt(length(x)-1) * sum(x*y)) / (sqrt(sum(x*x) * sum(y*y) - (sum(x*y))^2))
~~~
This is same as the t-statistic shown above.

(10.e) Using the results from (d), argue that the t-statistic for the regression of y onto x is the same as the t-statistic for the regression of x onto y.

If you swap t(x,y) as t(y,x), then you will find t(x,y) = t(y,x).

(10.f) In R, show that when regression is performed with an intercept, the t-statistic for $$H_0:\beta=0$$ is the same for the regression of y onto x as it is for the regression of x onto y.
~~~
lm.fit = lm(y~x)
lm.fit2 = lm(x~y)
summary(lm.fit)
summary(lm.fit2)
~~~
You can see the t-statistic is the same for the two linear regressions.

(12) This problem involves simple linear regression without an intercept.

(12.a) Recall that the coefficient estimate βˆ for the linear regression of Y onto X without an intercept is given by (3.38). Under what circumstance is the coefficient estimate for the regression of X onto Y the same as the coefficient estimate for the regression of Y onto X?

When the sum of the squares of the observed y-values are equal to the sum of the squares of the observed x-values.

(12.b) Generate an example in R with n = 100 observations in which the coefficient estimate for the regression of X onto Y is different from the coefficient estimate for the regression of Y onto X.

~~~
set.seed(1)
x = rnorm(100)
y = 2*x
lm.fit = lm(y~x+0)
lm.fit2 = lm(x~y+0)
summary(lm.fit)
summary(lm.fit2)
~~~
The regression coefficients are different for each linear regression.

(c) Generate an example in R with n = 100 observations in which the coefficient estimate for the regression of X onto Y is the same as the coefficient estimate for the regression of Y onto X.

~~~
set.seed(1)
x <- rnorm(100)
y <- -sample(x, 100)

sum(x^2)
sum(y^2)

lm.fit <- lm(y~x+0)
lm.fit2 <- lm(x~y+0)
summary(lm.fit)
summary(lm.fit2)
~~~
The regression coefficients are the same for each linear regression. So long as sum sum(x^2) = sum(y^2) the condition in 12a. will be satisfied. Here we have simply taken all the xixi in a different order and made them negative.

(13) In this exercise you will create some simulated data and will fit simple linear regression models to it. Make sure to use set.seed(1) prior to starting part (a) to ensure consistent results.

(13.a) Using the **rnorm()** function, create a vector, x, containing 100 observations drawn from a $$N(0, 1)$$ distribution. This represents a feature, X.
~~~
set.seed(1)
x <- rnorm(100)
~~~

(13.b) Using the **rnorm()** function, create a vector, eps, containing 100 observations drawn from a $$N(0,0.25)$$ distribution i.e. a normal distribution with mean zero and variance 0.25.
~~~
eps <- rnorm(100, 0, sqrt(0.25))
~~~

(13.c) Using x and eps, generate a vector y according to the model
$$
Y = -1 + 0.5X + \epsilon
$$
What is the length of the vector y? What are the values of $$\beta_0$$ and $$\beta_1$$ in this linear model?
~~~
y = -1 + 0.5x + eps
~~~
The length is 100 for y. $$\beta_0 = -1$$, $$\beta_1 = 0.5$$,

(13.d) Create a scatterplot displaying the relationship between x and y. Comment on what you observe.
~~~
plot(x,y)
~~~
I observe a linear relationship between x and y with a positive slope, with a variance as is to be expected.

(13.e) Fit a least squares linear model to predict y using x. Comment on the model obtained. How do βˆ0 and βˆ1 compare to β0 and β1?
~~~
lm.fit = lm(y~x)
summary(lm.fit)

Call:
lm(formula = y ~ x)

Residuals:
     Min       1Q   Median       3Q      Max
-1.08311 -0.32783 -0.09303  0.27894  1.30310

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept) -0.99850    0.05124 -19.487  < 2e-16 ***
x            0.46312    0.05128   9.031 1.53e-14 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 0.512 on 98 degrees of freedom
Multiple R-squared:  0.4542,	Adjusted R-squared:  0.4486
F-statistic: 81.56 on 1 and 98 DF,  p-value: 1.533e-14
~~~
The linear regression fits a model close to the true value of the coefficients as was constructed. The model has a large F-statistic with a near-zero p-value so the null hypothesis can be rejected.

(13.f) Display the least squares line on the scatterplot obtained in (d). Draw the population regression line on the plot, in a different color. Use the legend() command to create an appropriate legend.
~~~
plot(x, y)
abline(lm.fit, lwd=3, col=2)
abline(-1, 0.5, lwd=3, col=3)
legend(-1, legend = c("model fit", "pop. regression"), col=2:3, lwd=3)
~~~

(13.g) Now fit a polynomial regression model that predicts y using x and x2. Is there evidence that the quadratic term improves the model fit? Explain your answer.
~~~
lm.fit2=lm(y~x+I(x^2))
summary(lm.fit2)
~~~
There is evidence that model fit has increased over the training data given the slight increase in $$R^2$$ and $$RSE$$. Although, the p-value of the t-statistic suggests that there isn’t a relationship between $$y$$ and $$x^2$$.

(13.h) Repeat (a)–(f) after modifying the data generation process in such a way that there is less noise in the data. The model (3.39) should remain the same. You can do this by decreasing the vari- ance of the normal distribution used to generate the error term ε in (b). Describe your results.
~~~
set.seed(1)
eps1 = rnorm(100, 0, 0.125)
x1 = rnorm(100)
y1 = -1 + 0.5*x1 + eps1
plot(x1, y1)
lm.fit1 = lm(y1~x1)
summary(lm.fit1)

abline(lm.fit1, lwd=3, col=2)
abline(-1, 0.5, lwd=3, col=3)
legend(-1, legend = c("model fit", "pop. regression"), col=2:3, lwd=3)
~~~
As expected, the error observed in $$R^2$$ and $$RSE$$ **decreases** considerably.

(13.i) Repeat (a)–(f) after modifying the data generation process in such a way that there is more noise in the data. The model (3.39) should remain the same. You can do this by increasing the variance of the normal distribution used to generate the error term ε in (b). Describe your results.
~~~
set.seed(1)
eps1 = rnorm(100, 0, 0.5)
x1 = rnorm(100)
y1 = -1 + 0.5*x1 + eps1
plot(x1, y1)
lm.fit2 = lm(y1~x1)
summary(lm.fit2)

abline(lm.fit2, lwd=3, col=2)
abline(-1, 0.5, lwd=3, col=3)
legend(-1, legend = c("model fit", "pop. regression"), col=2:3, lwd=3)
~~~
As expected, the error observed in $$R^2$$ and $$RSE$$ **decreases** considerably.

(13.j) What are the confidence intervals for β0 and β1 based on the original data set, the noisier data set, and the less noisy data set? Comment on your results.

All intervals seem to be centered on approximately 0.5, with the second fit’s interval being narrower than the first fit’s interval and the last fit’s interval being wider than the first fit’s interval.

(14) This problem focuses on the **collinearity** problem.

(14.a) Perform the following commands in R:
The last line corresponds to creating a linear model in which y is a function of x1 and x2. Write out the form of the linear model. What are the regression coefficients?
~~~
set.seed(1)
x1=runif(100)
x2=0.5*x1+rnorm(100)/10
y=2+2*x1+0.3*x2+rnorm(100)
~~~
$$
Y = 2 + 2X_1 + 0.3X_2 + \epsilon
$$
$$\beta_0 = 2, \beta_1 = 2, \beta_2 = 0.3$$

(14.b) What is the correlation between x1 and x2? Create a scatterplot displaying the relationship between the variables.
~~~
cor(x1, x2)
plot(x1, x2)
~~~

(14.c) Using this data, fit a least squares regression to predict $$y$$ using $$x1$$ and $$x2$$. Describe the results obtained. What are $$\hat \beta_0, \hat \beta_1, \hat \beta_2$$? How do these relate to the true $$\beta_0, \beta_1, \beta_2$$? Can you reject the null hypothesis $$H_0:\beta_1=0$$? How about the null hypothesis $$H_0:\beta_2=0$$?
~~~
lm.fit = lm(y~x1+x2)
summary(lm.fit)

Call:
lm(formula = y ~ x1 + x2)

Residuals:
    Min      1Q  Median      3Q     Max
-2.8311 -0.7273 -0.0537  0.6338  2.3359

Coefficients:
            Estimate Std. Error t value Pr(>|t|)    
(Intercept)   2.1305     0.2319   9.188 7.61e-15 ***
x1            1.4396     0.7212   1.996   0.0487 *  
x2            1.0097     1.1337   0.891   0.3754    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 1.056 on 97 degrees of freedom
Multiple R-squared:  0.2088,	Adjusted R-squared:  0.1925
F-statistic:  12.8 on 2 and 97 DF,  p-value: 1.164e-05
~~~

$$\beta_0 = 2.1305, \beta_1 = 1.4396, \beta_2 = 1.0072$$

The regression coefficients are close to the true coefficients, although with high standard error. We can reject the null hypothesis for $$\beta_1$$ because its p-value is below 5%. We cannot reject the null hypothesis for $$\beta_2$$ because its p-value is much above the 5% typical cutoff, over 60%.










## Reference
[q-q plots](http://onlinestatbook.com/2/advanced_graphs/q-q_plots.html)

[QQ plot图——评价你的统计模型是否合理](http://www.genedenovo.com/news/391.html)

[Ch3 applied](http://blog.princehonest.com/stat-learning/ch3/applied.html)
