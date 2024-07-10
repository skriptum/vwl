# 16.04.2024 Multiple Regression

Why multiple Regression?

- control for other factors
- explain more of the variation of *y*
- flexible functional form



Example:

$$
wage = \beta_0 + \beta_1 educ+\beta_2 experience + \epsilon
$$

**Interpretation** $\beta_1$ = change in *y* w.r.t $x_1$, holding all other factors fixed

**Assumption** here: $E(u | x_1,x_2) = 0$ : 

- u same for all combinations of $x_1, x_2$



## OLS Expected Value

Assumptions: (for a normal CLM = Classical Linear Model)

1. parameters ($\beta_i$​) are linear (*variables can be nonlinear*)
2. random sample of population
3. no perfect collinearity 
    - variables are not constant
    - no perfect linearity of variables
    - nonlinear functions of same variable are allowed, e.g $y = \beta_0+\beta_1 x + \beta_2 x^2+u$
4. zero conditional mean: $E(u | x_1,x_2,...) = 0$

=> estimate = truth: $E(\hat{ \beta }) = \beta$



### Misspecification

Irrelevant Variables

- no effect on unbiasedness
- effect on variance of OLS-estimator



Omitted Variable Bias

- true model: $y = \beta_0+\beta_1 x_1 + \beta_2 x_2$
- our model: $\hat{ y } = \hat{ \beta_1 } + \hat{ \beta_2 } \hat{ \delta }$ (delta = slope between $x_1$ and $x_2$)
- => $Bias(\beta_1) = E(\beta_1)-\beta_1$



## OLS Variance

5th assumption: **Homoskedasticity**

- error *u* = same variance for all given values
- $Var(u | x_1,...) = \sigma^2$

Variance formula

$$
Var (\hat{ \beta_1 }) = \frac{ \sigma^2 }{SST_j(1-R_j^2)}
$$

- SST = total sample variation
- R = R-sqaured



6th Assumption: 

Normality of Errors
