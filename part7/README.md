Linear model are relatively simple to describe and implement, and have advantage over other approaches in terms of interpretation and inference. However, standard linear regression can have significant limitations in terms of predictive power. This is because the linearity assumption is almost always an approximation, and sometimes a poor one.

In this chapter we relax the linearity assumption while still attempting to maintain as much interpretability as possible.We do this by examining very simple extensions of linear models like polynomial regression and step functions, as well as more sophisticated approaches such as **splines**, **local regression**, and **generalized additive models**.

* *Polynomial regression* extends the linear model by adding extra predictors, obtained by raising each of the original predictors to a power.This approach provides a simple way to provide a non-linear fit to data.
* *Step function* cut the range of a variable into $$K$$ distinct regions in order to produce a qualitative variable. This has the effect of fitting a piecewise constant function.
* Regression splines are more flexible than polynomials and step function, and in fact are an extension of the two. They involve dividing the range of $$X$$ into $$K$$ distinct regions. Within each region, a polynomial function is fit to the data.However, these polynomials are constrained so that they join smoothly at the region boundaries, or knots.
* *Smoothing splines* are similar to regression splines, by arise in a slightly different situation. Smoothing splines result from minimizing a residual sum of squares criterion subject to a smoothness penalty.
* *Local regression* is similar to splines, but differs in an important way. The regions are allowed to overlap, and indeed they do so in a very smooth way.
* *Generalized additive models* allow us to extend the methods above to deal with multiple predictors.

In Section 7.1-7.6, we present a number of approaches for modeling the relationship between a response $$Y$$ and a single predictor $$X$$ in a flexible way.

In Section 7.7, we show that these approaches can be seamlessly integrated in order to model a response $$Y$$ as a function of several predictors $$X_1, \ldots, X_p$$.
