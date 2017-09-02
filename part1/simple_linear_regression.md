# Simple Linear Regression

* By far the most common approach involves minimizing the** least squares criterion**.

* Let $$\hat y_i = \vec \beta_0 + \vec \beta_1x_1$$ be prediction for $$Y$$ $$x = y$$ based on the $$i$$th value of $$X$$.

* Then $$e_i = y_i - \hat y_i$$ represents the $$i$$th **redisual**

* We define the residual sum of squares\(RSS\) as
$$
RSS = e\_1^2 + e\_2^2 + ... + e\_n^2
$$
or equivalently as:
$$
RSS = (y_1 - \hat y_1)^2 + (y_2 - \hat y_2)^2 +  ... + (y_n - \hat y_n)^2
$$
* The least squares approach chooses $$\hat \beta_0$$ and $$\hat \beta_1$$ to minimize the RSS. The minimizing values can be shown to be
$$\hat \beta_1 = \frac{\sum_{i=1}^n(x_i - \overline x)(y_i - \overline y)}{\sum_{i=1}^n(x_i - \overline x)^2}\\$$
and
$$\hat \beta_0 = \hat y - \hat{\beta_1}\overline{x}$$
where $$\overline{y} = \frac{1}{n}\sum_{i=1}^ny_i$$ and $$\overline{x} = \frac{1}{n}\sum_{i=1}^nx_i$$
