### vectors, data, matrices, subsetting
x=c(2,7,5)
x
y=seq(from=4,length=3,by=3)
?seq
y
x+y
x/y
x^y
x[2]
x[2:3]
x[-2]      #remove the element 2 from x and return the subsetted vector.   2 5
x[-c(1,2)] #moving the collection of indices 1 and 2.   5
z=matrix(seq(1,12),4,3)
z
z[3:4,2:3] # see 3,4 row and 2,3 column
z[,2:3]
z[,1]    #drop it's matrix status  1,2,3,4
z[,1,drop=FALSE] #keep that one column matrix
dim(z)
ls()
rm(y)
ls()

### Generating random data, graphics
x=runif(50)
y=rnorm(50)
plot(x,y)
plot(x,y,xla="Random Uniform",ylab="Random Normal",pch="*",col="blue")
par(mfrow=c(2,1))
plot(x,y)
hist(y)
par(mfrow=c(1,1))

### Reading in data
Auto=read.csv("~/prj/git_prj/...")
names(Auto)
dim(Auto)
class(Auto)
summary(Auto)
plot(Auto$cylinders,Auto$mpg)
attach(Auto)
search() #Gives a list of attached packages (see library), and R objects
plot(cylinders, mpg)
cylinders=os.factor(cylinders)


