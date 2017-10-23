## An Overview of Smoothing Splines
Consider this criterion for fitting a smooth function $$g(x)$$ to some data:
$$
minimize_{g \in S} \sum_{i=1}^n(y_i-g(x_i))^2 + \lambda\int g''(x_i)^2dt
$$
The first term is RSS, and tries to make $$g(x)$$ match the data at each $$x_i$$.

The second term is a roughness penalty and controls how wiggly $$g(x)$$ is. It is modulated by the tuning parameter $$\lambda$$.

* If $$g$$ is very smooth, then $$g'(t)$$ will be close to constant and $$\int g''(x_i)^2dt$$ will take on a small value. Conversely, if $$g$$ is jumpy and variable than $$g'(t)$$ will vary significantly and $$\int g''(x_i)^2dt$$ will take on a large value.


* The smaller $$\lambda$$, the more wiggly the function, eventually interpolating $$y_i$$ when $$\lambda=0$$. As $$\lambda \to \infty $$, the function $$g(x)$$ becomes linear.

## Choosing the Smoothing Parameter

We have seen that a smoothing spline is simply a natural cubic spline with knots at every unique value of $$x_i$$. The roughness penalty still controls the roughness via $$\lambda$$.

* Smoothing splines avoid the knot-selection issue, leaving a single $$\lambda$$ to be chosen.

* The algorithmic details are too complex to describe here. In R, the function `smooth.spline()` will fit a smoothing spline.

* The vector of $$n$$ fitted values can be wiritten as $$\hat g_{\lambda}=S_{\lambda}y$$, where $$S_{\lambda}$$ is a $$n \times n$$ matrix.

* The **effective degrees of freedom** are given by:
  $$
  df_{\lambda}=\sum_{i=1}^n\{S_\lambda\}_{ii}
  $$
  We can specify $$df$$ rather than $$\lambda$$!











