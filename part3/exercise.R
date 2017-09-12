Auto = read.csv('~/prj/git_prj/ml-book/part3/Auto.csv', header=T, na.strings="?")
#na.omit returns the object with incomplete cases removed
Auto = na.omit(Auto)
summary(Auto)

attach(Auto)
lm.fit = lm(mpg~horsepower)
summary(lm.fit)

predict(lm.fit, data.frame(horsepower=c(98)), interval="confidence")
predict(lm.fit, data.frame(horsepower=c(98)), interval="predict")
plot(horsepower, mpg)
abline(lm.fit)

par(mfrow=c(2,2))
plot(lm.fit)

pairs(Auto)
cor(subset(Auto, select=-name))

lm.fit1=lm(mpg~.-name, data=Auto)
summary(lm.fit1)

par(mfrow=c(2,2))
plot(lm.fit1)

x = runif(100, -50, 50)
y=exp(x)
plot(x,y)