## What Is Statistical Learning?
Suppose that we observe a quantitative response $$Y$$ and $$p$$ different predictors, $$X_1, X_2,...X_p$$, we assume that there is some relationship between $$Y$$ and $$X=(X_1, X_2,..., X_p)$$, which can be written in the very general form:
$$
Y=f(X) + \epsilon
$$
Here, $$f$$ is some fixed but unknown function of $$X_1, X_2,...X_p$$$, and $$\epsilon$$ is a *random error term*, which is independent of $$X$$ and has mean zero.
In essence, statistical learning refers to a set of approaches for estimating $$f$$.

### Why Estimate $$f$$?
There are two main reasons that we may wish to estimate $$f$$: *prediction* and *inference*.

#### Prediction
We can predict $$Y$$ using:
$$
\hat Y = \hat f(X)
$$
where $$\hat f$$ represents our estimate for $$f$$, and $$\hat Y$$ represents the resulting prediction for $$Y$$.

The accuracy of $$\hat Y$$ as a prediction for $$Y$$ depends on two quantities, **reducible error ** and **irreducible error**. Even if it were possible to form a perfect estimate for $$f$$, so that our estimated response took the form $$\hat Y=f(X)$$, our prediction would still have some error in it! This is because $$Y$$ is also a function of $$\epsilon$$, which cannot be predicted using $$X$$.

Assume for a moment that both $$\hat f$$ and $$X$$ are fixed, then it's easy to show that：
$$
E(Y - \hat Y) = E[f(X) + \epsilon - \hat f(X)]^2=[f(X)-\hat f(X)]^2 + Var(\epsilon)
$$
Where $$E(Y - \hat Y)$$ represents the average, or expected value, of the squared different between predicted and actual value of $$Y$$, and $$Var(\epsilon)$$ represents the variance associated with the error term $$\epsilon$$.

> The focus of this book is on techniques for estimating $$f$$ with the aim of minimizing the reducible error. Irreducible error will always provide an upper bound on the accuracy of our prediction for $$Y$$, this bound is almost always unknown in practice.

#### Inference
We are often interested in understanding that way that $$Y$$ is affected as $$X_1, X_2,...X_p$$$ change. In this situation we wish to estimate $$f$$, but our goal is not necessarily to make predictions for $$Y$$.

We instead want to understand the relationship between $$X$$ and $$Y$$, or more specially, to understand how $$Y$$ changes as a function of $$X_1, X_2,...X_p$$$.

In this setting, one may be interested in answering the following questions:
* Which predictors are associated with the response?
* What is the relationship between the response and each predictor?
* Can the relationship between $$Y$$ and each predictor be adequately summarized using a linear equation, or is the relationship more complicated?

Depending on whether our ultimate goal is prediction, inference, or a combination of the two, different methods for estimating $$f$$ may be appropriate.

### How Do We Estimate $$f$$?
Our goal is to apply a statistic learning method to the training data in order to estimate the unknown function $$f$$. Broadly speaking, most statistic learning methods for this task can be characterized as either parametric or non-parametric.

### Some Trade-Offs
* Prediction accuracy versus interpretability -- Linear models are easy to interpret; thin-plate splines are not.
* Good fit versus over-fit or under-fit -- How do we know when the fit is just right?
* Parsimony versus black-box -- We often prefer simpler model involving fewer variables over a black-box predictor involving them all.
