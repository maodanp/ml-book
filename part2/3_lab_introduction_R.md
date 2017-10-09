## Basic Commands

* Use the function **c()** to combine values into a vector.
* Get the length of vectors(including lists) and factors by using **length()**.
~~~
x <- c(1,3,2,5)
length(x)
~~~
* The **ls()** function allows us to look at a list of all of the objects, such as data and functions, that we have saved so far.
* The **rm()** function can by used to delete any that we don't want, also possible to remove all objects at once.
~~~
ls()
rm(x,y)
rm(list=ls())
~~~

* The **matrix()** function ca be used to create a matrix of numbers. We focus on the first three inputs: the data,  the number of rows, the number of column.
* Alternatively, the **byrow=TRUE** option can be used to populate the matrix in order of the rows.
*  The **sqrt()** function returns the square root of each element of a vector or matrix; The command **x^2** raises each element of x to the power 2; any powers are possible, including fractional or negative powers.
~~~
x = matrix(data=c(1,2,3,4), nrow=2, ncol=2)
~~~

* The **rnorm()** function generates a vector of random normal variables, with first argument $$n$$ the sample size.
* The **cor()** function to compute the correlation between $$x, y$$.
~~~
x = rnorm(50)
y = x + rnorm(50, mean=50, sd=.1)
cor(x, y)
~~~

* The **mean()** and **var()** functions can be used to compute the mean and variance of a vector of numbers
* Applying **sqrt()** to the output of **var()** will give the standard deviation. Or we can simply use the **sd()** function.
~~~
set.seed (3)
y=rnorm(100)
mean(y)
var(y)
sqrt(var(y))
sd(y)
~~~

## Graphics
* The **plot()** function is the primary way to plot data in R.
* To create a pdf, we use the **pdf()** function, and to create a jpeg, we use the **jpeg()** function.
* The function **dev.off()** indicates to R that we are done creating the plot.
~~~
x=rnorm(100)
y=rnorm(100)
plot(x,y)
plot(x,y,xlab="this is the x-axis",ylab="this is the y-axis",
main="Plot of X vs Y")

pdf("Figure.pdf")
plot(x,y,col="green")
dev.off()
~~~

* The **seq()** function can be used to create a sequence of numbers.
~~~
x=seq(1,10)
x=seq(-pi,pi,length=50)
~~~

* The **contour()** function produces a contour plot in order to represent three-dimensional data; it is like a topographical map.
~~~
contour (x,y,f)
contour(x,y,f,nlevels=45,add=T)
fa=(f-t(f))/2
contour(x,y,fa,nlevels=15)
~~~

* The **image()** function works the same way as **contour()**, except that it produces a color-coded plot whose colors depend on the z value.
* sometimes used to plot temperature in weather forecasts.
* Alternatively, **persp()** can be used to produce a three-dimensional plot. The arguments **theta** and **phi** control the angles at which the plot is viewed.


## Indexing Data
~~~
A=matrix(1:16,4,4)
A[2,3]
A[c(1,3), c(2,4)]
A[1:3, 2:4]
A[1:2,]
A[,1:2]
~~~
The use of a negative sign - in the index tells R to keep all rows or columns except those indicated in the index.
~~~
A[-c(1,3),]
~~~
The **dim()** function outputs the number of rows followed by the number of columns of a given matrix
~~~
dim(A)
~~~

## Loading Data
We can use the function **write.table()** to export data.Once the data has been loaded, the **fix()** function can be used to view it in a spreadsheet like window.
~~~
Auto = read.table("Auto.data")
fix(Auto)
~~~

The data set also includes a number of missing observations, indicated by a question mark ?. Missing values are a common occurrence in real data sets.

Using the option **header=T(or header=TRUE)** in the **read.table()** function tells R that the first line of the file contains the variable names, and using the option **na.strings** tells R that any time it sees a particular character or set of characters, it should be treated as a missing element of the data matrix.
~~~
Auto = read.table("Auto.data", header=T, na.strings="?")
fix(Auto)
dim(Auto)

397 9
~~~
There are various ways to deal with the missing data, we choose to use the **na.omit()** function to simply remove these rows.
~~~
Auto=na.omit(Auto)
dim(Auto)

392 9
~~~
Once the data are loaded correctly, we can use **names()** to check the variable names
~~~
names(Auto)
~~~

## Additional Graphical and Numerical Summaries
The **as.factor()** function converts quantitative variables into qualitative variables.
~~~
attach(Auto)
plot(cylinders, mpg)

cylinders = as.factor(cylinders)
~~~

If the variable plotted on the x-axis is categorial, then *boxplots* will automatically be produced by the *plot()* function.
~~~
plot(cylinders, mpg)
plot(cylinders, mpg, varwidth=T)
~~~

The **hist()** function can be used to plot a histogram.
~~~
hist(mpg)
~~~

The **pairs()** function creates a scatterplot matrix.
~~~
pairs(Auto)
pairs(~ mpg + displacement + horsepower + weight + acceleration, Auto)
~~~

In conjunction with the **plot()** function, **identify()** provides a useful interactive method for identifying the value for a particular variable for points on a plot.
~~~
plot(horsepower, mpg)
identify(horsepower, mpg, name)
~~~

The **summary()** function produces a numerical summary of each variable in a particular data set.
