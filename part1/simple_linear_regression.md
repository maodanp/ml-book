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
\Theta = \sqrt{\frac{1}{N}\sum_{i=1}^N(x_i-u)^2}
$$
* standard error(标准误差): 样本统计量（这里的样本统计量可以是平均数，标准差，相关系数等等）的标准差，衡量抽样样本（统计量）的误差。
知道总体的标准差：
$$
SE\overline{x} = \frac{\theta}{\sqrt{n}}
$$
如果不知道总计的标准差，用样本的标准差的无偏估计：
$$
SE\overline{x} = \frac{s}{\sqrt{n-1}}
$$
* residual standard error:



## References

[standard deviation 和standard error的区别](https://www.zhihu.com/question/21925923)
