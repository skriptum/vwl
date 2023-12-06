# DDCG Notes to Slides

## About the Paper

- research by 4 economists from top-university
    - Acemlgu & Robinson (know already from Settlers Mortality Paper)
    - 2 other Professors
- very prominent paper, widely recognized
- impact on literature / research
    - as most papers by acemoglu
- published = JPE
    - Wokring Paper 2014
    - Final Publication 2019




---

## Literature on Growth and Democracy

- vast research (basic econometric question (What causes growth?)
- dates back to Lipset Hypothesis (1959): 
    - growth => democracy
- 90s: first econometric tests : 
    - simple OLS Regressions (Robert Barro) => negative effect
- 2000s: more advanced statistical methods 
    - => inconclusive, nto always significnat
- Acemoglu et al 2019: conclusive evidence:
    -  Democracy => growth

---

## Data

*Democracy Measure*

- constructed from 4 different data sources (Freedom House, Polity IV, 2 papers)
- dichotomous / binary: either 0 (not democracy) or 1 (democracy)
- 1960-2010 (50 years), 184 countries

*Growth Data* (gdp per capita, 2000 Dollars) & other economic variables  = World Bank

[FIGURE DEMOCRATIZATIONS]

122 democratizations in this time frame, most around 1990s (post soviet transformations)



---

## Problem: GDP Diversity and Dip

2 problems in the research

- GDP growth = **very** heterogenous
- before a democratization = decline in growth
    - often reason for protests etc

[FIGURE DIP]

standard OLS not applicable

- omitted variable bias





---

## Method



*Different Approaches*

1. ***Dynamic Linear Panel Model** with Fixed Effects*
2. *Semiparametric Estimation* (relax assumption of linear relationship)
3. *Instrument Variable Regression* (regional waves of democratization)

Explanation

MOdel focuses on "switchers" (countries that democratise)

- **Dynamic**: Lags of variables (to account for the Dip)
- **linear**: Linear relationship assumption (democracy and growth)
- **Panel**: cross country comparison
- **Within Estimator**: Estimator for Fixed Effects Models
    - country fixed effecrs
    - year fixed effects



Formula (looks like a beast, but lets explain)

$$
y_{ct} = \beta D_t + \sum_{j=1}^p \gamma_j y_{ct-j} + \alpha_c + \delta_t + \epsilon_{ct}
$$


-   $y_ct$ = log GDP per capita in country *c* at time *t*

-   $D_{ct}$ = Dichotomous measure of democracy

-   *p* lags of log GDP for control

-   $\alpha$ = country fixed effects (filter out the heterogenity)

-   d = time fixed effects (filter out the effects of in one year many countries democratizing)

-   $e$ = error term

lets look at results ->



---

## Fixed Effects Model

[TABLE 2]

- different number of lags = authors preffered specification = 4 lags
- log level estimate
    - one unit of x (binary indicator = democratization)
    - 100*Beta % change (already multiplied by 100 in table)
- preferred specification = column 3
    - Democratiztaion leads to  0.78% increase in GDP this year
    - after 25 years = 16.895% increase
    - Long run = 21.40% higher Gdp per Capita
    - SE = small, statistically significant

---

## Trend Estimate

[FIGURE TREND]



- black = trend estimate
- dashed = 95 % confidence intervals

after 25 years = **16,895** % higher GDP

=> effect levelling off = "one off"

- no different trend for given country after democratization
- just higher gdp per capita
- important for the statistical model!



---

## Channels

[TABLE CHANNELS]

Democratization => **state capacity & human capital building**

---


## Interlude: Replication in R

- [Model Specification](https://skriptum.github.io/DDCG/vortrag/2-Panel-Models.html)
- [Results Table](https://skriptum.github.io/DDCG/vortrag/3-Table2.html) 
- [Trend Estimate](https://skriptum.github.io/DDCG/vortrag/4-Figure2.html#plot)
- [Channels Table](https://skriptum.github.io/DDCG/vortrag/6-IVReg.html)



---

## Critique

*Dichotomous Measure of Democracy*

- not binary, scale (democracy, illiberate democracy, authoritarian rule, dictatorship)
- newer analysis does it (Lars Pelke: Varieties of Democracy)

*Short Time Frame*

- only 50 years
- only 1 of the 3 waves of democratization 

*Sensitivity to Sample Selection*

- depends heavily on the eastern communist states (+ short time)
- Markus Eberhardt Comment: 
    - random drop of observations (ca 5%)
    - => effect only half



---

## References

...

---

*Are there **alternative political frameworks** that could also facilitate these mechanisms (state capacity and education expansion) or is it easier in democracies?* 

- elephant in the room = China (achieved both)
- communist states in general = high state capacity



*Could there be **non-linear relationships** between democracy and economic growth, e.g optimal level of democracy?* 

- a level of democracy beyond which growth is hurt?
- for example monetary policy = undemocratic in most democracy today



*What are the **Policy Implications** drawn from the link between democracy and growth* 

- especially if it only average effect
- what if there is a "dip" in life quality after democratization 
    - think post-soviet states

---

## Appendix: Semiparametric

[FIGURE]

- no parametric assumption for GDP development 
    - not linear like in first

- but assumption for likelihood of transition to democracy
- results confirm



---

## Appendix: IV

*First Stage:*
$$
y_{ct} = \beta D_{ct} + \sum_{j=1}^p \gamma_j y_{ct-j} + \alpha_c + \delta_t + \epsilon_{ct}
$$

*Second Stage: with D as IV*
$$
D_{ct} = \sum_{j=1}^p \pi_j Z_{ct-j}+ \sum_{j=1}^p \phi y_{ct-j} + \Phi_c+ \mu_t+ v_{ct}
$$

waves of democratization

-   external factor that influences both demotracy and GDP
-   not rely on country democracy value!
-   regionally limited due to similiar politics  culture etc.
-   7 regions in world
-   confirm results

