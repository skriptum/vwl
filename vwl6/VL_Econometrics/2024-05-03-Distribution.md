# 03.05.2024 OLS Distribution and Tests

## Sampling Distribution of OLS-Estimator

Assumption: 

- error $\epsilon$​​ = independent of explanatory variables
- normally distributed with mean = 0 and sd = $\sigma^2$

=> depends on empirical topic



e.g Wage regression

- wage > 0 $\neq$ normal distributed
- minimum wage => population eran exaclty minimum

=> solve with *log*

Theorem

$$
\implies \hat{ \beta_j } \sim Normal[\beta_j, Var(\beta_j)] \\
$$

 

## t-statistic

Normal Model with CLM Assumptions

$$
y = \beta_0 + \beta_1 x_1 + \beta_2 x_2 + ...+ \beta_k x_k + u
$$

Distribution of Beta => follows T-distribution


$$
(\hat{ \beta_j }- \beta_j) / se(\hat{ \beta_j }) \sim t_{n-k-1}
$$

Test the Null Hypothesis ($H_0 : \beta_j \le 0$)

$$
t_{\beta_j} = \hat{ \beta_j } / se(\beta_j)
$$

---

**Example**: hourly wage equation for *n=526*

$$
ln \widehat{ \text{wage} } = 
\underset{(.104)}{.284} + 
\underset{(.007)}{.092 \cdot educ} + 
\underset{(.0017)}{.0041\cdot exper}+ 
\underset{(.003)}{.022 \cdot tenure}
$$

- $H_0$: $\beta_{exper} \le 0$ vs $H_1: \beta_{exper} > 0$​
- Test Statistic: $t_{\beta_j} = \hat{ \beta_j } / se(\beta_j)$
- Rejection Rule: 
    - calculate distribution value 
        - use normal distribution, because *df>120*
        - choose significance level = 5%
    - $N(0.95) = 1.645$
- Calculate $t_{exper} = \frac{ 0.0041 }{0.0017}= 2.41$
- 2.41 > 1.645 => $H_1$ accepted

=> variable is different from 0 => **good**



## Confidence Intervals

= interval estimates

$$
\hat{ \beta_j } \pm c \cdot se(\hat{ \beta_j })
$$

 

Example: 

- given: degrees of freedom = 25, Confidence = 95%
- c = 2.06 ([look here](https://www.omnicalculator.com/statistics/critical-value?c=EUR&v=which_test:2,alpha:0.05,prec:4,tdf:25,alt:0.000000000000000))
- $[\hat{ \beta_j }-2.06 \cdot se(\hat{ \beta_j }),\hat{ \beta_j }+2.06 \cdot se(\hat{ \beta_j })]$



## Test Hypotheses: Multiple Parameters

Test a single hypothesis with more than one $\beta$

Example: Returns to Education at junior colleges vs. four year colleges

$$
\ln wage = \beta_0+ \beta_1 junior + \beta_2 univ+ \beta_3 exper + u
$$

 Result:

$$
\ln wage = 
\underset{.021}{1.472} + 
\underset{.0069}{.0667} junior +
\underset{.0023}{.0769} univ +
\underset{.0002}{.0049} exper
$$

 Numerator: $\hat{ \beta_1 }-\hat{ \beta_2 } = 0.0067-0.0769 = -0.0102$

Denominator: fucking complicated?!!!!!



## F-Test

*probably (hopefully) not relevant*

to test mutliple hypothesis at the same time

**Example**: Salary of a Baseball Player

$$
\ln salary = \beta_0+\beta_1 years + \beta_2 gamesyr + \beta_3 bavg + \beta_4 hrunsyr + \beta_5 rbisyr + u
$$

 

Hypothesis: after controlling for years and games/yr, the other performance statistics do not have any effect

$$
H_0: \beta_3=0, \beta_4 = 0, \beta_5 = 0
$$

 Results in unrestricted Model:

$$
\ln \widehat{salary} = 
\underset{0.29}{11.19} + 
\underset{0.0121}{0.0689} years +
\underset{0.0026}{0.0126} gamesyr + \\
\underset{0.0011}{0.0009} bavg +
\underset{0.0161}{0.0144} hrunsyr +
\underset{0.0072}{0.0108} rbisyr \\
SSR = 183.186, R^2 = 0.6728
$$

 Result in restricted Model

$$
\ln \widehat{salary} =
\underset{.11}{11.22} +
\underset{.0125}{.0713} years +
\underset{.0013}{.0202} gamesyr \\
SSR = 198.311, R^2 = .5971
$$

F-Test

$$
F = \frac{ (SSR_r -SSR_{ur})/q}{SSR_{ur}/(n-k-1)}
$$

 

- Question: increase in SSR large enough to consider dropping?
- F = always nonnegative
- *q* = $df_r-df_{ur}$
- $n-k-1 = df_{ur}$

Rejection Rule: c is taken from F distribution

$$
F > c, \text{ with c =} F_{q,n-k-1}(1-\alpha)
$$

 

also often used: F-Statistic to test all variables (confirm that they are different from 0)
