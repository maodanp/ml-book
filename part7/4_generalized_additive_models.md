*Generalized additive models*(GAMs) provide a general framework for extending a standard linear model by **allowing non-linear functions of each of the variables, while maintaining additivity**. GAMs can be applied with both quantitative and qualitative responses.

## GAMs for Regression Problems

$$
y_i=\beta_0+f_1(x_{i1})+f_2(x_{i2})+\ldots+f_p(x_{ip})+\epsilon_i
$$

It is called an additive model because we calculate a separate $$f_j$$ for each $$X_j$$, and then add together all of their contributions.

Advantages and limitations of a GAM:

* GAMs allow us to fit a non-linear $$f_j$$ for each $$X_j$$, so that we can automatically model non-linear relationships that standard linear regression will miss. This means that we don't need to manually try out many different transformations on each variable individually.
* The non-linear fits can potentially make more accurate predictions for the response $$Y$$.
* Because the model is additive, we can still examine the effect of each $$X_j$$ on $$Y$$ individually while holding all of the other variables fixed. Hence if we are interested in inference, GAMs provides a useful representation.
* The smoothness of the function  $$f_j$$ for the variable $$X_j$$ can be summarized via degree of freedom.
* The main limitation of GAMs is that the model is restricted to be additive. With many variables, important interactions can be missed.

GAMs provide a useful compromise between linear and fully nonparametric models.
