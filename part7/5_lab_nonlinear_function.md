Here we explore the use of nonlinear models using some tools in R.

```
require(ISLR)
attach(Wage)
```

## Polynomials

First we will use polynomials, and focus on a single predictor age:

~~~
fit=lm(wage~poly(age, 4), data=Wage)
summary(fit)
~~~

The `poly()` function generation a basis of *orthogonal polynomials*.

Lets make a plot of the fitted function, along with the standard errors of the fit.

~~~
agelims=range(age)
age.grid=seq(from=agelims[1],to=agelims[2])
preds=predict(fit, newdata=list(age=age.grid), se=TRUE)

se.bands=cbind(preds$fit+2*preds$se, preds$fit-2*preds$se)
plot(age,wage,col="darkgrey")
lines(age.grid, preds$fit, lwd=2, col="blue")
matlines(age.grid, se.bands, col="blue", lty=2)
~~~

There are other more direct ways of doing this in R. For example

~~~
fita=lm(wage~age+I(age^2)+I(age^3)+I(age^4), data=Wage)
summary(fita)
plot(fitted(fit), fitted(fita))
~~~

Here, `I()` is a *wrapper* function; we need it because `age^2` means something to the formula language, while `I(age^2)` is protected.

The coefficient are different to those we got before! however, the fits are the same:

~~~
plot(fitted(fit), fitted(fita))
~~~

By using orthogonal polynomials in this simple way, it turns out that we can separately test for each coefficient. So if we look at the summary again, we can see that the linear, quadratic and cubic terms are significant, but not the quartic.

This only works with lienar regression, and if there is a single predictor. In general we would use `anova()` as this next example demonstrates.

~~~
fita=lm(age~education, data=Wage)
fitb=lm(age~education+age, data=Wage)
fitc=lm(age~education+poly(age, 2), data=Wage)
anova(fita, fitb, fitc, fitd)
~~~

### Polynomial logistic regression

Now we fit a logistic regression model to a binary response variable, constructed from `wage`, we code the big earners (`>250K`) as 1, else 0.

~~~
fit=glm(I(wage>250)~poly(age, 3), data=Wage, family=binomial)
summary(fit)
preds=predict(fit, list(age=age), se=T)
se.bands=preds$fit + cbind(fit=0, low=-2*preds$se, upper=2*preds$se)
se.bands[1:5,]
~~~

We have done the computations on the logit scale. To transform we need to apply the inverse logit mapping.

$$p=\frac{e^\eta}{1+e^\eta}$$

We can do this simultaeously for all three columns of `se.bands`:

~~~
prob.bands=exp(se.bands)/(1+exp(se.bands))
matplot(age.grid,prob.bands,col="blue",lwd=c(2,1,1),lty=c(1,2,2,),type="l",ylim=c(0,.1))
points(jitter(age), I(wage>250)/10, pch="l",cex=.5)
~~~

## Splines

Splines are more flexible than polynomials, but the idea is rather similar.

Here we will explore cubic splines.

~~~
require(splines)
fit=lm(wage~bs(age, knots=(25,40,60)), data=Wage)
plot(age, wage, col="darkgrey")
lines(age.grid, predict(fit, list(age=age.grid)), col="darkgreen", lwd=2)
abline(v=c(25,40,60), lty=2,cal="darkgreen")
~~~

The smoothing splines does not require knot selection, but it does have a smoothing parameter, which can conveniently be specified via the effective degrees of freedom or `df`.

~~~
fit=smooth.spline(age, wage, df=16)
lines(fit, col="red", lwd=2)
~~~

Or we can use LOO cross-validation to select the smoothing parameter for use automatically.

~~~
fit=smooth.spline(age, wage, cv=TRUE)
lines(fit, col="purple", lwd=2)
fit
~~~

## Generalized Additive Models

So far we have focused on fitting models with mostly single nonlinear terms. The `gam` package makes it easier to work with multiple nonlinear terms. In addition, it makes how to plot these functions and their standard errors.

~~~
require(gam)
gam1=gam(wage~s(age, df=4)+s(year, df=4)+education,data=Wage)
par(mfrow=c(1,3))
plot(gam1, se=T)
gam2=gam(I(wage>250)~s(age, df=4)+s(year, df=4)+education, data=Wag, family=binomial)
~~~

Lets see if we need a nonlinear terms for year

~~~
gam2a=gam(I(wage>250)~s(age, df=4)+year+education, data=Wag, family=binomial)
anova(gam2a, gam2, test="Chisq")
~~~

One nice feature of the `gam` package is that it konws how to plot the function nicely, even for models fit by `lm` and `glm`.

~~~
par=(mfrow=c(1,3))
lm1=lm(wage~ns(age, df=4)+ns(year, df=4)+education, data=Wage)
plot.gam(lm1, se=T)

~~~

