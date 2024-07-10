# 01.06.2024 Applications



## Rescaling Variables

General: Scaling does not change important things:

- R-Squared = no change
- Significacne = no change 
- Residuals and SSR = change
- SE and CI = change (divide by scaler)
- OLS Estimates change (but after transformation in same units do not change)



Example: Salary equation with thousands of dollars instead of dollars

Why do this? make numbers easier interpretable



## Functional Form Specifications

Example: Housing prices and Nitrogen Oxide Emissions (*nox*)

$$
\ln \widehat{price} =
\underset{.19}{9.23} +
\underset{.066}{-.718} \ln nox +
\underset{.019}{.306} rooms
$$

- $\beta_1$ = **elasticity** price / nox (1% nox $\uparrow$ => 0.718% $\downarrow$​ price)
- $\beta_2$ = **semi-elasticity** of price / rooms
    - multiply by 100 = *approximate* effect 
    - $\Delta room=1$ => 30% price $\uparrow$​

**Note:** the approximation is not very exact for larger percentages!

Alternative: $100 [exp(\beta_2)-1]$ (for values > 0.2)



### Percentages and Percentage Points!

Example

1. $\ln wage = \beta_1 - 0.05 \ unempl. rate$
2. $\ln wage = \beta_1 - 0.05  \ln (unempl. rate)$

Interpretation

1. unempl. rate increase by **one percentage point** (8->9) => $\uparrow$ wages by 5%
2. unempl. rate increasy by **one percent** (8.00-8.08) => $\downarrow$ wages by 0.05%



### Quadratics

used to capture marginal effects

$$
\ln wage = 3.73 + .298exper - .0061 exper^2
$$

find marginal effect: $\frac{ \delta \ln wage }{\delta exper} = 0.298 - 2*0.0061* exper$

**Result:** marginal diminishing effect of experience (negative sign before quadratic)

- 1st year = $.298 - 2\cdot (0.0061)\cdot (0) = .298$ (no experience in first year of job)
    - .298 cents per hour increase
- 2nd year = $.298 - 2\cdot (0.0061)\cdot (1) = .286$​ 
- 10 to 11th year = $.298 - 2\cdot (0.0061)\cdot (10) = .176$



Maximum of the wage: $\frac{ -\beta_1 }{2 \beta_2} = 24.4$



### Interaction Terms

Example

$$
price = \beta_0 + \beta_1 sqrft + \beta_2 bdrms + \underline{\beta_3 sqrft \cdot bdrms} + u
$$

 Partial Effect of *bdrms* on price 

- $\frac{ \delta price }{\delta bdrms} = \beta_2 + \beta_3 sqrft$
- interaction effect: if $\beta_3 > 0$ additional bedroom => higher increase in housing price for larger house



## Goodness of Fit

Problem with R-squared: adding a variable only increases it

=> **adjusted R-squared** (has penalty for additiona variables)

$$
\bar{ R }^2 = \frac{ SSR / (n-k-1) }{SST / (n-1)}
$$

 How to go from R-squared to adjusted?

$$
\bar{ R^2 } = 1- \frac{ (1-\bold{R^2})(n-1) }{(n-k-1)}
$$

 Note: 

- adj. R-squared can be negative!

### Selection of Regressors

Example of choosing between different models

$$
Model 1& RDintens = \beta_0 + \beta_1 \ln sales + u  \\
&R^2 = 0.061
\bar{ R^2 }=0.03) \\
Model 2& RDintens = \beta_0 + \beta_1 sales +\beta_2 sales^2+ u  \\
&R^2 = 0.148; \bar{ R^2 }=0.09
$$

 

Second Model: 

- better R-squarer
- better adjusted R^2 (even though it has one independent variable more)



> [!note]
>
> never compare two models with different specifications for *dependent* variable



### Overcontrolling Example: Beer Tax

- Idea: Beer Tax => lower Beer Consumption => lower traffic deaths
- $fatalities = \beta_0 + \beta_1 tax + \beta_2 miles + u$

why not include *beer consumption*?

- is this omitted variable bias?
- **NO**, because holding consumption fixed is not our interest!
- we want to follow our idea, and therefore include tax





## Prediction

Confidence Intervals for $\theta_0 = \hat{ \theta_0 }\pm 2 \cdot se(\hat{ \theta_0 })$​

- variance of prediction = smallest at mean values of $x_j$



How to predict $y$ if formula is only $\ln y$, e.g $\ln salary = \beta_0 + \beta_1 x_k + ... + u$

- For given $x_k = 5000$ => $\ln salary = 7.013$

Methods

- **Naive**: $y = e^{\ln y} = exp(7.013) = 1110.983$ (Underestimates the result!)
- **Smearing**: 
    - $\hat{ y } = \hat{ \alpha_0 } \cdot exp(\ln y)$
    - calculate $\hat{ \alpha_0 } = n^{-1} \sum_{i=1}^n exp(\hat{ u_i })$
    - Result: $y = 1.136 \cdot exp(7.013) = 1262.076$
- **regression**
    - fucking complicated, create a new regression just for it
    - Result: $1117 \cdot exp(7.013) = 1240.967$
- **normality assumption**
    - $y = \exp \frac{RSS^2 }{2} \exp (\ln y) =\exp \frac{0.50477^2 }{2} \exp (7.013)= 1261.929 $





