## Conceptual
(1). describe the null hypothesis to which the p-values given in Table 3.4 correspond.

The null hypothesis for "TV" is that in the presence of radio ads and newspaper ads,TV ads has no effect on sales(there are similar null hypothesis for radio, newspaper). The low p-values of TV and radio suggest that the null hypothesis are false for TV and radio, the high p-values of newspaper suggests that the null hypothesis is true for newspaper.

(2). Carefully explain the differences between the KNN classifier and KNN regression methods.

KNN classifier and KNN regression methods are closely related in formula. However, the final result of KNN classifier is the classification output for Y(qualitative), where as the output for a KNN regression predicts the quantitative value for $$f(x)$$.

(3). Suppose we have a data set with five predictors, X1 = GPA, X2 = IQ, X3 = Gender (1 for Female and 0 for Male), X4 = Interaction between GPA and IQ, and X5 = Interaction between GPA and Gender. The response is starting salary after graduation (in thousands of dollars). Suppose we use least squares to fit the model, and get $$\hat \beta_0 = 50, \hat \beta_1 = 20, \hat \beta_2 = 0.07, \hat \beta_3=35, \hat \beta_4=0.01, \hat \beta_5= -10$$.

$$Y = 50 + 20(gpa) + 0.07(iq) + 35(gender) + 0.01(gpa * iq) - 10 (gpa * gender)$$

(3.a): which answer is correct, and why?

$$
Y = 50 + 20 k_1 + 0.07 k_2 + 35 gender + 0.01(k_1 * k_2) - 10 (k_1 * gender)
$$
$$
male: (gender = 0)   50 + 20 k_1 + 0.07 k_2 + 0.01(k_1 * k_2)
$$
$$
female: (gender = 1) 50 + 20 k_1 + 0.07 k_2 + 35 + 0.01(k_1 * k_2) - 10 (k_1)
$$

Once the GPA is high enough, males earn more on average.

(3.b): Predict the salary of a female with IQ of 110 and a GPA of 4.0
(3.c): Since the coefficient for the GPA/IQ interaction term is vary small, there is very little evidence of an interaction effect. Justify your answer.

False, we must examine the **p-value** of the regression coefficient to determine if the interaction term is statistically significant or not.

(4).Collect a set of data (n=100 observations) containing a single predictor and a quantitative response, then fit a linear regression model to the data, as well as a separate cubic regression, i.e. $$Y=\beta_0+\beta_1X+\beta_2X^2+\beta_3X^3+\epsilon$$.

(4.a) Suppose that the true relationship between X and Y is linear. Consider the training residual sum of squares(RSS) for the linear regression, and also for the cubic regression. Would we expect one to be lower than the other,Would we expect them to be the same, or is there not enough information to tell?

Expect the polynomial regression to have a lower training RSS than the linear regression because it could make a tighter fit against data that matched with a wider irreducible error $$var(\epsilon)$$.

(4.b) Answer (a) using test rather than training RSS

Converse to (a). I would expect the polynomial regression to have a higher test RSS as the overfit from training would have more error than the linear regression.

(4.c) Suppose that the true relationship between X and Y is not linear, but we don’t know how far it is from linear. Consider the training RSS for the linear regression, and also the training RSS for the cubic regression. Would we expect one to be lower than the other, would we expect them to be the same, or is there not enough information to tell? Justify your answer.

polynomial regression has lower train RSS than the linear fit because of high flexibility: no matter what the underlying true relationship is the more flexible model will closer follow points and reduce train RSS.

(4.d) Answer (c) using test rather than training RSS.

There is not enough information to tell which test RSS would be lower for either regression given the problem statement is defined as not knowing "how far it is from linear". If it is closer to linear than cubic, the linear regression test RSS could be lower than the cubic regression test RSS. Or, if it is closer to cubic than linear, the cubic regression test RSS could be lower than the linear regression test RSS. It is dues to bias-variance tradeoff: it is not clear what level of flexibility will fit data better.
