library(MASS)
library(ISLR)
### Simple linear regression
#fix(Boston)
names(Boston)
?Boston
plot(medv~lstat, Boston)
fit1=lm(medv~lstat, data=Boston)
fit1
summary(fit1)
#abline(fit1, lwd=3, col='red', pch=20)
abline(fit1, col='red')
names(fit1)
confint(fit1)
predict(fit1, data.frame(lstat=c(5,10,15)), interval='confidence')
predict(fit1, data.frame(lstat=c(5,10,15)), interval='prediction')
###Multiple linear regression
fit2=lm(medv~lstat+age, data=Boston)
summary(fit2)
fit3=lm(medv~., Boston)
summary(fit3)
par(mfrow=c(2,2))
plot(fit3)
fit4=update(fit3, ~., -age-indus)
summary(fit4)

### Nonlinear terms and Interactions
fit5=lm(medv~lstat*age, Boston)
summary(fit5)
fit6=lm(medv~lstat+I(lstat^2), Boston); summary(fit6)
attach(Boston)
par(mfrow=c(1,1))
plot(medv~lstat)
points(lstat, fitted(fit6), col='red', pch=20)
fit7=lm(medv~poly(lstat, 4))
points(lstat, fitted(fit7), col='blue', pch=20)

###Qualitative predictors
fix(Carseats)
names(Carseats)
summary(Carseats)
fit8=lm(Sales~.+Income:Advertising+Age:Price,Carseats)
summary(fit8)
contrasts(Carseats$ShelveLoc)

###Writing R functions
regplot=function(x,y){
  fit=lm(y~x)
  plot(x,y)
  abline(fit, col='red')
}
attach(Carseats)
regplot(Price, Sales)

regplot=function(x,y,...){
  fit=lm(y~x)
  plot(x,y,...)
  abline(fit, col='red')
}
regplot(Price, Sales, xlab='Price', ylab='Sales', col='blue', pch=20)

plot(predict(lm.fit1), rstudent(lm.fit1))

lm.fit2=lm(mpg~cylinders*displacement+displacement*weight)
summary(lm.fit2)

lm.fit3 = lm(mpg~log(weight)+sqrt(horsepower)+acceleration+acceleration+I(acceleration^2))
summary(lm.fit3)

par(mfrow=c(2,2))
plot(lm.fit3)
plot(predict(lm.fit3), rstudent(lm.fit3))


lm.fit2<-lm(log(mpg)~cylinders+displacement+horsepower+weight+acceleration+year+origin,data=Auto)
summary(lm.fit2)
par(mfrow=c(2,2))
plot(lm.fit2)
plot(predict(lm.fit2),rstudent(lm.fit2))

### applied no.10.
library(ISLR)
summary(Carseats)

attach(Carseats)
lm.fit = lm(Sales~Price+Urban+US)
summary(lm.fit)
par(mfrow=c(2,2))
plot(lm.fit)

lm.fit2 = lm(Sales ~ Price + US)
summary(lm.fit2)
par(mfrow=c(2,2))
plot(lm.fit2)
confint(lm.fit2)

set.seed(1)
x = rnorm(100)
y = 2*x + rnorm(100)

lm.fit = lm(y~x+0)
summary(lm.fit)

(sqrt(length(x)-1) * sum(x*y)) / (sqrt(sum(x*x) * sum(y*y) - (sum(x*y))^2))

lm.fit = lm(y~x)
lm.fit2 = lm(x~y)
summary(lm.fit)
summary(lm.fit2)


## applied no.11.
set.seed(1)
x = rnorm(100)
y = 2*x
lm.fit1 = lm(y~x+0)
lm.fit2 = lm(x~y+0)
summary(lm.fit1)
summary(lm.fit2)

## applied no.12
set.seed(1)
x <- rnorm(100)
eps <- rnorm(100, 0, sqrt(0.25))
y = -1 + 0.5*x + eps
plot(x,y)

lm.fit = lm(y~x)
summary(lm.fit)

plot(x, y)
abline(lm.fit, lwd=3, col=2)
abline(-1, 0.5, lwd=3, col=3)
legend(-1, legend = c("model fit", "pop. regression"), col=2:3, lwd=3)


lm.fit2=lm(y~x+I(x^2))
summary(lm.fit2)


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

set.seed(1)
eps1 = rnorm(100, 0, 0.5)
x1 = rnorm(100)
y1 = -1 + 0.5*x1 + eps1
plot(x1, y1)
lm.fit1 = lm(y1~x1)
summary(lm.fit1)

abline(lm.fit1, lwd=3, col=2)
abline(-1, 0.5, lwd=3, col=3)
legend(-1, legend = c("model fit", "pop. regression"), col=2:3, lwd=3)

## applied no.14.
set.seed(1)
x1=runif(100)
x2=0.5*x1+rnorm(100)/10
y=2+2*x1+0.3*x2+rnorm(100)
cor(x1, x2)
plot(x1, x2)

lm.fit = lm(y~x1+x2)
summary(lm.fit)

lm.fit = lm(y~x1)
summary(lm.fit)

lm.fit = lm(y~x2)
summary(lm.fit)

## applied no.15.
library(MASS)
attach(Boston)
lm.fit=lm(crim~., data=Boston)
summary(lm.fit)
coefficients(lm.fit)[2]

