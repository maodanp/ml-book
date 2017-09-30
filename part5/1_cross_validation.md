## cross-validation

training error v.s. test error
* The *test error* is the average error that results from using a statistical learning method to predict the response on a new observation, one that was not used in training the method.
* The *training error* can be easily calculated by applying the statistical learning method to the observations used in its training.
* But the *training error* rate is quite different from the test error rate, and in particular the former can *dramatically underestimate* the latter.

more on prediction-error estimates
* Best solution: a large designated test set. Often not available.
* Some methods make a *mathematical adjustment* to the training error rate in order to estimate the test error rate. These include the *Cp statistic, AIC and BIC*.
* We instead consider a class of methods that estimate the test error by *holding out* a subset of the training observations from the fitting process, and then applying the statistical learning method to those held out observations.

### The Validation Set Approach

* Here, we randomly divide the available set of samples into two parts: a *training set* and a *validation* or *hold-out set*.
* The model is fit on the training set, and the fitted model is used to predict the responses for the observations in the validation set.
* The resulting validation-set error provides an estimate of the test error. This is typically assessed using MSE in the case of a quantitative response and misclassification rate in the case of a qualitative (discrete) response.

Drawbacks of validation set approach
* the validation estimate of the test error can be highly variable, depending on precisely which observations are included in the training set and which observations are included in the validation set.
* In the validation approach, only a subset of the observations (those that are included in the training set rather than in the validation set) are used to fit the model.
* This suggests that the validation set error may tend to overestimate the test error for the model fit on the entire data set.
