# DDCG Notes to Slides

## About the Paper

Democracy Does Cause Growth

- very prominent paper, widely recognized
- published = JPE
    - Wokring Paper 2014
    - Final Publication 2019

- research by 4 economists from top-university
    - Acemlgu & Robinson (know already from Settlers Mortality Paper)
    - 2 other Professors
- impact on literature / research
    - as most papers by acemoglu

*Lets talk about existinng Research*


---

## Literature on Growth and Democracy

- vast research (basic econometric question (What causes growth?)
- dates back to Lipset Hypothesis (1959): 
    - growth => democracy
- 90s: first econometric tests : 
    - simple Diff in Diff  (Robert Barro) => negative effect
- 2000s: more advanced statistical methods, example Giavazzi & Tabellini
    - => inconclusive, nto always significnat
- Acemoglu et al 2019: conclusive evidence:
    -  Democracy => growth

*So, how do they do it*?

---

## Data

*Democracy Measure*

- constructed from 4 different data sources (Freedom House, Polity IV, 2 papers)
- dichotomous / binary: either 0 (not democracy) or 1 (democracy)
- 1960-2010 (50 years), 184 countries

[FIGURE DEMOCRATIZATIONS]

122 democratizations in this time frame, most around 1990s (post soviet transformations)

*Growth Data* (gdp per capita, 2000 Dollars) & other economic variables  = World Bank

=> cross country sample of data

*what does the data show us? that we have 2 problems*

---

## Problem: GDP Diversity and Dip

2 problems in the research

- GDP growth = **very** heterogenous
- before a democratization = decline in growth
    - often reason for protests etc

[FIGURE DIP]

standard Diff in Diff not applicable

*How to the Authors overcome the Problems?*

---

## Method



*Use 3 novel Approaches*

1. ***Dynamic Linear Panel Model** with Fixed Effects*
2. *Semiparametric Estimation* (relax assumption of linear relationship)
3. *Instrument Variable Regression* (regional waves of democratization)



Explanation

- **Dynamic**: Lags of variables (to account for the Dip)
- **linear**: Linear relationship assumption between democracy and growth
- **Panel**: cross country comparison
- **Within Estimator**: Estimator for Fixed Effects Models
    - country fixed effects
    - year fixed effects



Formula (looks like a beast, but lets explain)

$$
y_{ct} = \beta D_t + \sum_{j=1}^p \gamma_j y_{ct-j} + \alpha_c + \delta_t + \epsilon_{ct}
$$


-   $y_ct$ = log GDP per capita in country *c* at time *t*

-   $D_{ct}$ = Dichotomous measure of democracy

-   *p* = number of lags of log GDP for control

-   $\alpha$ = country fixed effects (filter out the heterogenity)

-   d = time fixed effects (filter out the effects of in one year many countries democratizing)

-   $e$ = error term

lets look at results ->



---

## Fixed Effects Model

[TABLE 2]

- different number of lags (1,2,4,8) 
- log level estimate
    - change one unit of x (binary indicator = democratization)
    - 100*Beta % change (already multiplied by 100 in table)
- preferred specification = column 3
    - SE = small, 
    - results statistically significant (for all except one year)
    - on average: **Democratiztaion leads to  0.78% increase in GDP** 
        - in the year the country democratises
    - after 25 years = 16.895% increase
    - Long run = 21.40% higher Gdp per Capita

---

## Trend Estimate

[FIGURE TREND]

x-Axis = number of years after democratization

y Axis = change in gdp per capita log points compared to nondemocracies



- black = trend estimate
- dashed = 95 % confidence intervals

after 25 years = **16,895** % higher GDP

=> effect levelling off = "one off"

- no different trend for given country after democratization
- transitory, just higher gdp per capita



---


## Interlude: Replication in R

- [Model Specification](https://skriptum.github.io/DDCG/vortrag/2-Panel-Models.html)
- [Results Table](https://skriptum.github.io/DDCG/vortrag/3-Table2.html) 
- [Trend Estimate](https://skriptum.github.io/DDCG/vortrag/4-Figure2.html#plot)
- [Channels Table](https://skriptum.github.io/DDCG/vortrag/6-IVReg.html)



*so, lets understand why Democracy causes growth*

---

## Channels

[TABLE CHANNELS]

*big table, important cells highlighted*

Main Channels

- more investment
- Economic Reforms
- Government Expenditure
- Enrollment (Primary + Secondary)

essentially: Democratization => **state capacity & human capital building**

fits existing research on Question

- Paper later in this course on state capacity
- Romer endogenous growth => human capital focus



---

## Critique

*1: Measure of Democracy*

- Democracy: not binary, but scale (democracy, authoritarian rule, dictatorship)
- newer analysis does it (Lars Pelke: Varieties of Democracy index)
- Research not conclusive yet



2: *Short Time Frame*

- only 50 years
- only 1 of the 3 waves of democratization we historically had



3: Markus Eberhardt Comment

- Sensitivity to Sample Selection

- long run effect => only half the magnitude 

*that was it, lets summarize*

---

## Summary

Results show: democratization => one off effect on gdp per capita (causes growth)

mailny trough

- higher state capacity
- buildup of human capital

*also prepared some discussion questions while researching*

---

## Discussion

*Are there **alternative political frameworks** that could also facilitate these mechanisms (state capacity and education expansion) or is it easier in democracies?* 

- elephant in the room = China (achieved both)
- communist states in general = high state capacity



*What are the **Policy Implications** drawn from the link between democracy and growth* 

- especially if it only average effect
- what if there is a "dip" in gdp per cap after democratization 
    - think post-soviet states



---

## References

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

