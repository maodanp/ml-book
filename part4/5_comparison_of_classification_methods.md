## Logistic Regression v.s. LDA
In this chapter, we have considered three different classification approaches: **logistic regression**, **LDA**, and **QDA**. In Chapter 2, we also discussed the K-nearest neighbors(KNN) method. We now consider the types of secenarios in which one approach might dominate the others.

In the LDA framework, we can see that the log odds is given by:
$$
log(\frac{p_1(x)}{1-p_1(x)})=log(\frac{p_1(x)}{p_2(x)})=c_0+c_1x
$$
where $$c_0$$ and $$c_1$$ are functions of $$\mu_1, \mu_2, \sigma^2$$. In logistic regression:
$$
log(\frac{p_1(x)}{1-p_1(x)})=\beta_0+\beta_1x
$$
They are all linear functions of $$x$$. Hence, both logistic regression and LDA produce **linear decision boundaries**. The only difference between the two approaches lies in the fact that: **$$\beta_0, \beta_1$$ are estimated using maximum likehood**, whereas $$c_0, c_1$$ are computed using the estimated mean and variance from a normal distribution.

LDA assumes that the observations are drawn from a Gaussian distribution with a common covariance matrix in each class, and so can provide some improvements over logistic regression when the assumption approximately holds. Conversely, logistic regression can outperform LDA if there Gaussian assumption are not met.

## KNN v.s. Logistic Regression v.s. LDA
### KNN
KNN takes a completely different approach from the classifiers seen in this chapter, the $$K$$ training observations that are closest to $$x$$ are identified.Then $$X$$ is assigned to the class to which the plurality of these observations belong.

KNN is a completely non-parametric approach, no assumption are made about the shape of the decision boundary.*Therefore, we can expect this approach to dominate LDA and logistic regression when the decision boundary is highly non-linear*.

### QDA
QDA serves as a compromise between the non-parametric KNN method and the linear LDA and logistic regression approaches. Since QDA assumes a quadratic boundary, it can accurately model a wider range of problems than can the linear methods(相比于线性方法，能够更加准确的建立更加宽泛的问题模型).

Though not as flexible as KNN, QDA can perform better in the presence of a limited number of training observations because it does make some assumptions about the form of the decision boundary.

### Performances of these approaches
No one method will dominate the others in every situation.
* When the true decision boundaries are linear, then the LDA and logistic regression approaches will tend to perform well
* When the boundaries are moderately non-linear, QDA may give better results
* For much more complicated decision boundaries, a non-parametric approach such as KNN can be superior.But the level of smoothness for a non-parametric approach must be chosen carefully.In the next chapter we examine a number of approaches for choosing the correct level of smoothness and for selecting the best overall method
