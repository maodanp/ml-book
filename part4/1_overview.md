## why not linear regression
Linear regression is not appropriate in the case of a qualitative response.

We could consider encoding these value as a quantitative response variable, $$Y$$, as follows:
$$
f(n) =  
\begin{cases}  
1, &\text{if stroke} \\[2ex]
2, &\text{if drug overdose} \\[2ex]
2, &\text{if epileptic seizure}  
\end{cases}
$$
In practice there is no particular reason that this needs to be the case. If the response variables's values did take on a natural ordering, such as mild, moderate, and severe, and we felt the gap between mild and moderate was similar to the gap between moderate and severe, then a 1,2,3 coding would be reasonable.

> unfortunately, in general there is no natural way to convert a qualitative response variable with more than two levels into a quantitative response that is ready for linear regression.

The dummy variable approach cannot be easily extended to accommodate qualitative responses with more than two levels.For these reasons, it is preferable to use a classification method that is truly suited for qualitative response values, such as the ones presented next.
