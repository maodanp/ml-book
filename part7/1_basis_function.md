## 7.1 Polynomial Regression

A polynomial function :
$$
\hat f(x_0)=\hat \beta_0 + \hat \beta_1x_0 + \hat \beta_2 x_0^2 + \ldots +\hat \beta_jx_0^j + \epsilon_i
$$
This approach is known as polynomial regression. Generally speaking, it is unusual to use $$d$$ greater than 3 or 4 because for large values of $$d$$, the polynomial curve can become overly flexible and can take on some very strange shapes. This is especially true near the boundary of the $$X$$ variable.

We actually not really interested in the coefficient; more interested in the fitted function values at any value $$x_0$$.

Since $$\hat f(x_0)$$ is a linear function of the $$\hat \beta_l$$, can get a simple expression for **pointwise-variances** $$Var[\hat f(x_0)]$$ at any value $$x_0$$. In the figure we have computed the fit and pointwise standard errors on a gride of values for $$x_0$$. We show $$\hat f(x_0)  \pm 2se[\hat f(x_0)]$$.

Logistic regression follows naturally. For example, in figure we model:
$$
Pr(y_i \gt 250|x_i) = \frac{exp(\hat \beta0 + \hat \beta1x0 + \hat \beta2 x0^2 + \ldots +\hat \beta_jx0^j)}{1+exp(\hat \beta0 + \hat \beta1x0 + \hat \beta2 x0^2 + \ldots +\hat \beta_jx0^j)}
$$
To get confidence intervals, compute upper and lowest bounds on the logit scale, and then invert to get on probability scale.

## 7.2

Using polynomial functions of the features as predictors in a linear model imposes a global structure on the non-linear function of $$X$$(将特征的多项式函数作为线性模型中的预测因子，对X的非线性函数施加全局结构). We can instead use *step functions* in order to avoid imposing such a global structure.

Here, we break the range of $$X$$ into bins, and fit a different constant in each bin. This amounts to converting a continous variable into an ordered categorical variable.(这相当于将连续的变量转换为有序的分类变量).
$$
C_0(X)=I(X \lt c_1); C_1(X)=I( c_1\le X \lt c_2); \ldots; C_k(X) = I(c_k \le X)
$$
Where $$I()$$ is an indicator function that returns a 1 if the condition is true, and returns a 0 otherwise.

We then use least squares to fit a linear model using $$C_1(X), C_2(X), \ldots, C_K(X)$$ as predictors:
$$
y_i=\beta_0+\beta_1C_1(x_i)+\ldots+\beta_kC_K(x_i)+\epsilon_i
$$
For a given value of $$X$$, at most one of $$C_1, C_2,\ldots,C_K$$ can be non-zero.

Unfortunately, unless there are natural breakpoints int the predictors, piecewise-constant functions can miss the action. Nevertheless, step function approaches are very popular in biostatistics and epidemiology, among other disciplines.

## 7.3

Polynomial and piecewise-constant regression models are in fact special cases of a basis function approach. The idea is to have at hand a family of functions or transformations that can be applied to a variable $$X$$: $$b_1(X), b_2(X), \ldots, b_K(X)$$.
$$
y_i=\hat \beta_0 + \hat \beta_1b_1(x_i) + \hat \beta_2b_2(x_i) + \ldots +\hat \beta_Kb_K(x_i) + \epsilon_i
$$
Note that the basis function $$b_1(), b_2(), \ldots$$ are fixed and known.

Hence, we can use least squares to estimate the unknown regression coefficients, and this means that all o f the inference tools for linear models that are discussed in Chapter 3 are available in this setting.

We can use wavelets or Fourier series to construct basis functions. In the next section, we investigate a very common choice for a basis function: *regression splines*.
