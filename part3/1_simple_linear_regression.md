# Simple Linear Regression
## Estimation of the parameters by least squares
* By far the most common approach involves minimizing the** least squares criterion**.

* Let $$\hat y_i = \vec \beta_0 + \vec \beta_1x_1$$ be prediction for $$Y$$ $$x = y$$ based on the $$i$$th value of $$X$$.

* Then $$e_i = y_i - \hat y_i$$ represents the $$i$$th **redisual**

* We define the residual sum of squares\(RSS\) as
$$
RSS = e_1^2 + e_2^2 + ... + e_n^2
$$
or equivalently as:  
$$
RSS = (y_1 - \hat y_1)^2 + (y_2 - \hat y_2)^2 +  ... + (y_n - \hat y_n)^2
$$
* The least squares approach chooses $$\hat \beta_0$$ and $$\hat \beta_1$$ to minimize the RSS. The minimizing values can be shown to be
$$
\hat \beta_1 = \frac{\sum_{i=1}^n(x_i - \overline x)(y_i - \overline y)}{\sum_{i=1}^n(x_i - \overline x)^2}
$$

$$
\hat \beta_0 = \hat y - \hat{\beta_1}\overline{x}
$$
where $$\overline{y} = \frac{1}{n}\sum_{i=1}^ny_i$$ and $$\overline{x} = \frac{1}{n}\sum_{i=1}^nx_i$$

## Assessing the Accuracy of the Coefficient Estimates

In real applications, we have access to a set of observations from which we can compute the least squares line; however, the population regression line is unobserved, it's like the relationship between sample mean and population mean.
If we estimate $$\beta_0$$ and $$\beta_1$$ on the basis of a particular data set, then our estimates won't be exactly equal to $$\beta_0$$ and $$\beta_1$$, but if we could average the estimates obtained over a huge number of data sets, then the average of these estimates obtained over a huge number of data sets, then the average of these estimates would be spot on!  

### terms
* standard deviation(标准差): 即方差的标准化，反映样本的离散程度。
$$
\sigma = \sqrt{\frac{1}{N}\sum_{i=1}^N(x_i-u)^2}
$$
* standard error(标准误差): 样本统计量（这里的样本统计量可以是平均数，标准差，相关系数等等）的标准差，衡量抽样样本（统计量）的误差。
知道总体的标准差：
$$
SE(\overline{x}) = \frac{\sigma}{\sqrt{n}}
$$
如果不知道总计的标准差，用样本的标准差的无偏估计：
$$
SE(\overline{x}) = \frac{s}{\sqrt{n-1}}
$$
* residual standard error(剩余标准差、均方差):真实值和估计值之间差称为残差/剩余，则残差/剩余的标准差即为RSE.
$$
RSE = \frac{RSS}{n-2}
$$
* $$\chi_2$$ distribution

$$
X \sim N(\mu, \sigma^2)
$$
则显然有：
$$
\sum_{i=1}^n(\frac{X_i-\mu}{\sigma})^2 \sim \chi^2(n)
$$
与之比较类似的形式:
$$
\sum_{i=1}^n(\frac{X_i-\overline X}{\sigma})^2 \sim \chi^2(n-1)
$$
$$\overline X$$ 是一个与 $$X_i$$相关的随机变量，相关性被抵消，所以**随机性**下降了。

统计学中的**average**和**mean**是两种不同的概念。
* 前者是基于一定数量的样本通过求平均值得出的summary statistics,是样本统计量(Sample statistics)的样本均值；后者是作为总体参数（Population parameter）的总体均值.
* 后者求解往往需要先知道这个population服从于什么分布.

但现实生活当中我们无法从小样本中得知这个总体是服从什么分布的，只能用算数平均值来代替。这样一来,当你知道样本总和（n*样本均值）时，只知道其中n-1个值就可以推出剩下的一个是多少了，也就是说只有一个是不自由的。求样本标准差时我们只知道样本均值所以除以（n-1）,求总体标准差时我们知道总体均值所以除以n.


### SE for slop and intercept
$$
SE(\hat{\beta_0})^2 = \sigma^2[\frac{1}{n} + \frac{\overline{x}^2}{\sum_{i=1}^n(x_i - \overline{x})^2}]
$$
$$
SE(\hat{\beta_1})^2 = \frac{\sigma^2}{\sum_{i=1}^n(x_i - \overline{x})^2}
$$
where $$\sigma^2=Var(\epsilon)$$. For these formulas to be strictly valid, we need to assume that the error $$\epsilon_i$$ for each observation are uncorrelated with common variance $$\sigma^2$$
### confidence intervals
These SE can be used to compute **confidence intervals**. A 95% confidence intervals is defined as a range of values such that with 95% probability, the range will contain the true unknown value of the parameter.That is, there is approximately a 95% chance that the interval will contain the true value of $$\beta_1$$
$$
[\hat{\beta_1} - 2SE(\hat{\beta_1}), \hat{\beta_1} + 2SE(\hat{\beta_1})]
$$

### Hypothesis Testing
In the case of the advertising data, 95% confidence interval for $$\beta_0$$ is [6.130, 7.935] and the 95% confidence interval for $$\beta_1$$ is [0.042, 0,053]. Therefore, we can conclude that in the absence of any advertising, sales will(on average), fall somewhere between 6130 and 7940 units.
SE can also be used to preform **hypothesis tests** on the coefficients.The most common hypothesis test involves testing the null hypothesis of(There is no relationship between X and Y):
$$
H_0 : \beta_1 = 0
$$
versus the alternative hypothesis(There is some relationship between X and Y):
$$
H_a : \beta_1 \neq 0
$$
To test the null hypothesis, we need to determine whether $$\hat \beta_1$$(estimate for $$\beta_1$$) is far from zero that we can confident that $$\beta_1$$ is non-zero.

We compute a t-statistic give by:
$$
t = \frac{\hat{\beta_1} - 0}{SE(\hat{\beta_1})}
$$
which measures the number of standard deviations that $$\hat \beta_1$$ is away from 0.If there really is no relationship between X and Y, then we expect that the formal formula will have a t-distribution with n-2 degrees of freedom.

p值是Fisher先提出来的“显著性检验”理论体系中的概念：
* 有一个命题，称之为”零假设“（null hypothesis）$$H_0$$；
* 找到一个统计量T，可以计算T的统计分布；
* 一次试验结果可以计算得到一个确切的T值（$$T_0$$），在$$H_0$$成立的情况下，出现比$$T_0$$更极端情况的概率值记作p值
* 如果p很小，则可以作为”零假设并不成立“的有力证据。

Consequently, it is a simple matter to compute the probability of observing any value equal to $$|t|$$ or larger, assuming $$\beta_1 = 0$$. We call this probability the **p-value**. If we see a small p-value, then we can infer that there is an association between the predictor and the response.

## Assessing the Accuracy of the Model
It's natural to want to quantify the extent to which the model fits the data. The quality of a linear regression fit is typically assessed using two quantities: the residual standard error(RSE) and the $$R^2$$ statistic.

### Residual Standard Error
The RSE is an estimate of the standard deviation. whether or not the RSE is an acceptable prediction depends on the problem context.
$$
RSE = \sqrt{\frac{1}{n-2}RSS} = \sqrt{\frac{1}{n-2} \sum_{i=1}^2(y_i - \hat y_i)^2}
$$
where the residual sum-of-squares is $$RSS=\sum_{i=1}^2(y_i - \hat y_i)^2$$
The RSE is considered a measure of the lack of the model to the data(模型对数据是否合适的一种度量):
* if the predictions obtained using the model are very close to the true outcome value, we can conclude that the model fits the data very well.
* on the other hand, RSE may be quite large, indicating that the model doesn't fit the data well.
In advertising data set, the mean value of sales over all markets is approximately 14000 units, and so the percentage error is $$3260/14000=23\%$$

### $$R^2$$ Statistics
The RSE provides an absolute measure, it takes the form of a proportion——the proportion of variance explained:
$$
R^2 = \frac{TSS - RSS}{TSS} = 1 - \frac{RSS}{TSS}
$$
* $$TSS = \sum(y_i - \overline{y})^2$$ is the total sum of squares, which measures the total variance in the response $$Y$$, and can be thought of as the amount of variability inherent in the response before the regression is performed(一种在regression 执行前响应中固有的变量)
* $$RSS=\sum_{i=1}^2(y_i - \hat y_i)^2$$ is the residual sum of squares, which measures the amount of variability that is left unexplained after performing the regression(执行完regression后不明原因/不可解释的变量)
* An $$R^2$$ statistic that is close to 1 indicates that a large proportion of the variability in the response has been explained by the regression
* A number near 0 indicates that the regression did't explain much of the variability in the response; this might occur because the linear model is wrong, or the inherent error $$\sigma^2$$ is high, or both


## References
[如何理解自由度](https://www.zhihu.com/question/20983193)

[卡方分布](http://publish.get.com.tw/bookpre_pdf/G1680A-1.PDF)

[standard deviation 和standard error的区别](https://www.zhihu.com/question/21925923)

[p value](http://blog.sina.com.cn/s/blog_61f013b801011h55.html)

[统计学假设检验中 p 值的含义具体是什么](https://www.zhihu.com/question/23149768)

[hypothesis testing](https://statistics.laerd.com/statistical-guides/hypothesis-testing-3.php)

[Stastical Learning ch2](http://online.stanford.edu/course/statistical-learning-winter-2014)
