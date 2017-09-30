## Resampling Methods

**Resampling methods** are an indispensable tool in model statistics. They involve repeatedly drawing samples from a training set and refitting a model of interest on each sample in order to obtain additional information about the fitted model.

Resampling approaches can be computationally expensive, because they involve fitting the same statistical method multiple times using different subsets of the training data. However, due to recent advances in computing power, the computational requirements of Resampling methods generally are not prohibitive.

In this chapter, we discuss two of the most commonly used resampling methods, **cross-validation** and the **bootstrap**.
* cross-validation: can be used to estimate the test error associated with a given statistical learning method in order to *evaluate its performance(model assessment)*, or to *select the appropriate level of flexibility(model selection)*.
* The bootstrap is used in several contexts, most commonly to provide a measure of accuracy of a parameter estimate or of a given statistical learning method.
