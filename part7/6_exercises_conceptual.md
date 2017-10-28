## Q1

It was mentioned in the chapter that a cubic regression spline with one knot at ξξ can be obtained using a basis of the form $$x,x^2,x^3,(x-\xi)_{+}^3$$, where $$(x-\xi)_{+}^3=(x-\xi)^3$$ if$$ x \gt \xi$$ and equals 0 otherwise. We will now show that a function of the form
$$
f(x) = \beta_0+\beta_1x+\beta_2x^2+\beta_3x^3+\beta_4(x-\xi)_{+}^2
$$

### 1.a

Find a cubic polynomial
$$
f_1(x) = a_1+b_1x+c_1x^2+d_1x^3
$$
such that $$f(x)=f_1(x)$$ for all $$x \lt \xi$$. Express $$a_1, b_1, c_1,d_1$$ in terms of $$\beta_0,\beta_1,\beta_2,\ldots$$.

For  $$x \lt \xi$$, we have
$$
f(x) = \beta_0+\beta_1x+\beta_2x^2+\beta_3x^3
$$
so we take $$a_1=\beta_0, b_1=\beta_1, c_1=\beta_2, d_1=\beta_3$$.

### 1.b

Find a cubic polynomial
$$
f_2(x) = a_2+b_2x+c_2x^2+d_2x^3
$$
such that $$f(x)=f_2(x)$$ for all $$x \lt \xi$$. Express $$a_2, b_2, c_2,d_2$$ in terms of $$\beta_0,\beta_1,\beta_2,\beta_3,\beta_4$$.

For  $$x \gt \xi$$, we have
$$
f(x) = \beta_0+\ldots+\beta_4(x-\xi)^3=(\beta_0-\beta_4\xi^3)+(\beta_1+3\xi^2\beta_4)x+(\beta_2-3\beta_4\xi)x^2+(\beta_3+\beta_4)x^3
$$
so we take $$a_2=(\beta_0-\beta_4\xi^3),b_2=(\beta_1+3\xi^2\beta_4),c_2=\beta_2-3\beta_4\xi,d_2=\beta_3+\beta_4$$.

### 1.c

Show that $$f_1(\xi)=f_2(\xi)$$. That is, $$f(x)$$ is continuous at $$\xi$$.



### 1.d

Show that $$f_1(\xi)=f_2(\xi)$$. That is, $$f(x)$$ is continuous at $$\xi$$.Therefore, $$f(x)$$ is indeed a cubic spline.

## Q2

Suppose that a curve $$\hat g$$ is computed to smoothly fit a set of n points using the following formula:
$$
\hat g=min(\sum_{i=1}^n(y_i-g(x_i))^2+\lambda\int[g^{(m)}(x)]^2)
$$

where $$g^{(m)}$$ represents the $$m$$th derivative of $$g$$.

Provide example sketches of $$\hat g$$ in each of the following scenarios

(a)  $$\lambda=\infty,m=0$$

In this case $$\hat g=0$$ because a large smoothing parameter forces $$g^{(0)}(x) \to 0$$

(b) $$\lambda=\infty,m=1$$

In this case $$\hat g=c$$ because a large smoothing parameter forces $$g^{(1)}(x) \to 0$$

(c) $$\lambda=\infty,m=2$$

In this case $$\hat g=cx+d$$ because a large smoothing parameter forces $$g^{(2)}(x) \to 0$$

(d) $$\lambda=\infty,m=3$$

In this case $$\hat g=cx^2+dx+e$$ because a large smoothing parameter forces $$g^{(3)}(x) \to 0$$

(e) $$\lambda=0,m=3$$

This penalty term doesn't play any role, so in this case $$g$$ is the interpolating spline.

## Q3

Suppose we fit a curve with basis function $$b_1(x)=x, b_x(x)=(x-1)^2(x \gg 1)$$. We fit the linear regression model:
$$
Y=\beta_0+\beta_1b_1(X)+\beta_2b_2(X)+\epsilon
$$

and obtain coefficient estimates $$\hat \beta_0=1, \hat \beta_1=1,\hat \beta_2=-2$$. Sketch the estimated curve between $$X=-2$$ and $$X=2$$. Note the intercepts, slopes, and other relevant information.

## Q5

Suppose two curves, $$\hat g_1$$ and $$\hat g_2$$, defined by
$$
\hat g_1=min(\sum_{i=1}^n(y_i-g(x_i))^2+\lambda\int[g^{(3)}(x)]^2)
$$

$$
\hat g_2=min(\sum_{i=1}^n(y_i-g(x_i))^2+\lambda\int[g^{(4)}(x)]^2)
$$

where $$g^{(m)}$$ represents the $$m$$th derivative of $$g$$.



(a). As  $$\lambda \to \infty$$, will $$\hat g_1$$ or $$\hat g_2$$ have the smaller training RSS?

The smoothing spline  $$\hat g_2$$ will probably have the smaller training RSS because it will be a higher order polynomial due to the order of the penalty term(it will be more flexible)

(b). As  $$\lambda \to \infty$$, will $$\hat g_1$$ or $$\hat g_2$$ have the smaller test RSS?

As mentioned above we expect $$\hat g_2$$ to be more flexible, so it may overfit the data. It will probably be $$\hat g_1$$ that have the smaller test RSS

(b). As  $$\lambda \to 0$$, will $$\hat g_1$$ or $$\hat g_2$$ have the smaller training and test RSS?

If $$\lambda=0$$, we have $$\hat g_1=\hat g_2$$, so they will have the same training and test RSS
