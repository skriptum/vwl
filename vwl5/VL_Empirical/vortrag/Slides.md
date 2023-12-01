# DDCG Slides

[TOC]

Figures

- Figure DIP
- Figure DEM
- figure TREND

Tables

- Table 2 = DLPM
- Table 7 = Channels

---

## About the Paper

Question

Authors

-   [Daron Acemoglu](https://economics.mit.edu/sites/default/files/styles/facutly_profile_feature_image/public/2022-12/daron-acemoglu30.jpg?h=620fd1cb&itok=2p17a0hs) (MIT)

-   [James A. Robinson](https://harris.uchicago.edu/files/styles/square/public/2022-01/james-robinson-headshot-2022.jpeg?itok=NVPPH7Na) (U. of Chicago)

-   [Suresh Naidu](https://www.sipa.columbia.edu/sites/default/files/styles/1_1_1536x1536/public/2023-10/Suresh%20Naidu%20Headshot.png.jpeg?itok=atidRtoO) (Columbia)

-   [Pascual Restrepo](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Fifs.org.uk%2Finequality%2Fwp-content%2Fuploads%2F2022%2F03%2FPascual-Restrepo-1.jpg&f=1&nofb=1&ipt=f7bbe9b625908183da52bcb9c3d1cb8ab1a2d2d4f47670feb0a38645567d3d99&ipo=images) (Boston U.)

[Cover of JPE](https://economics.sas.upenn.edu/sites/default/files/2020-02/jpe%20jan2020.jpg)

::: notes

- research by 4 economicst from top-university
- very prominent paper, widely recognized
- impact on literature / research

:::


---
## Literature on Growth and Democracy

Existing Literature





---

## Problem: GDP Diversity and Dip

- heterogeneity of GDP growth
- Dip of GDP preceding democratization

-> direct OLS not applicable

[FIGURE DIP]

::: notes

2 problems in the research

- GDP growth = **very** heterogenous
- before a democratization = decline in growth
    - often reason for protests etc

[Figure]

:::



---

## Data

Democracy Measure

- constructed from different sources
- dichotomous 
- 1960 - 2010, 184 Countries

Growth Data = World Bank

[FIGURE DEM]

::: notes

*Democracy Measure*

- constructed from 4 different data sources (Freedom House, Polity IV, 2 papers)
- dichotomous / binary: either 0 (not democracy) or 1 (democracy)
- 1960-2010 (50 years), 184 countries

*Growth Data* (gdp per capita, 2000) & other economic variables  = World Bank

Figure: 122 democratizations in this time frame

:::

---

## Method

3 Approaches

1. **Dynamic Linear Panel Model** with *Within Estimator*
2. Semiparametric Estimation
3. Instrument Variable Regression (see Appendix ->)

Panel Formula

$$
y_{ct} = \beta D_t + \sum_{j=1}^p \gamma_j y_{ct-j} + \alpha_c + \delta_t + \epsilon_{ct}
$$

R Code

```R
model <- plm(
  y ~ dem + lag1 + lag2 + lag3 + lag4, #equation with 4 lags
  model="within", #The fixed effects within estimator
  data = pdf, #panel data frame
  effect = "twoways" #country and year fixed effects
  )
```

---

## Results Table

[TABLE 2]

See Appendix for Calculation of *long run effects* -> & *short-run effects* ->

::: notes

:::

---

## Results Figure

[FIGURE TREND]

See Appendix for Calculation of the dynamics ->

:::

- black = trend estimate
- dashed = 95 % confidence intervals

after 25 years = **XX**

=> effect levelling off = "one off"

:::

---

## Channels

Question: What are the main channels that impact growth

[TABLE 7]

Democratization => Economic reforms, school enrolment, more taxes

=> **state capacity & human capital building**

See Appendix for Calculation

---

## Critique

- Dichotomous Measure of Democracy [@pelkeReanalysingLinkDemocracy2023]
- Short Time Frame 
- Sensitivity to Sample Selection [@eberhardtDemocracyDoesCause2019]



::: notes

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

:::

---

## References



---

## Discussion Questions

1. Are there <u>alternative political frameworks</u> that could also facilitate these mechanisms (state capacity and education expansion) or is it easier in democracies?
2. Could there be <u>non-linear relationships</u> between democracy and economic growth, e.g optimal level of democracy? 
3. What actionable <u>policy recommendations</u> can be drawn from the observed link between democracy and economic growth?



::: notes

*Are there **alternative political frameworks** that could also facilitate these mechanisms (state capacity and education expansion) or is it easier in democracies?* 

- elephant in the room = China (achieved both)
- communist states in general = high state capacity



*Could there be **non-linear relationships** between democracy and economic growth, e.g optimal level of democracy?* 

- a level of democracy beyond which growth is hurt?
- for example monetary policy = undemocratic in most democracy today



*What are the **Policy Implications** drawn from the link*

:::

---

## Appendix: IV Model Specification

$$
y_{ct} = \beta D_{ct} + \sum_{j=1}^p \gamma_j y_{ct-j} + \alpha_c + \delta_t + \epsilon_{ct}
$$

with D as IV:

$$
D_{ct} = \sum_{j=1}^p \pi_j Z_{ct-j}+ \sum_{j=1}^p \phi y_{ct-j} + \Phi_c+ \mu_t+ v_{ct}
$$

Code:

```R
iv_model_2 <- plm(
    y ~ dem + plm::lag(y, 1:4) | 
    plm::lag(demreg,1:4) + plm::lag(y, 1:4),
    data=pdf,
    effect = "twoways",
    )
```



---

## Appendix: IV Model Results

[TABLE 6]

---

## Appendix: Long Run Effects

Formula:
$$
effect_{long} = \frac{ \hat\beta }{1- \sum_{j=1}^p \hat\gamma_j}
$$

Code:
```R
beta_hat <- coef(model3)["dem"]
gamma_hat <- (coef(model3)[2:5])

long_run_effect_3 <- beta_hat / (1 - sum(gamma_hat))
```

---

## Appendix: Short Run Effects

Formula taken from Stata Code File (`Table2_final.do`, lines 32-87):

$$
effect_{t} = \hat\beta + \sum_{j=1}^p \hat\gamma_j * effect_{t-j}
$$

Code:
```R
dem_shortrun <- coef(model3)["dem"]
lag1 <- (coef(model3)[2])
lag2 <- (coef(model3)[3])
lag3 <- (coef(model3)[4])
lag4 <- (coef(model3)[5])
```

```{r}
effect1 <- dem_shortrun
effect2 <- (effect1 * lag1) + dem_shortrun
effect3 <- (effect2 * lag1) + (effect1 * lag2) + dem_shortrun
effect4 <- (effect3 * lag1) + (effect2 * lag2) + (effect1 * lag3) + dem_shortrun
effects <- c(effect1,effect2, effect3, effect4)
```

```{r}
for (i in 5:30) {
  eff <- (effects[i-1] * lag1) + (effects[i-2] * lag2) + (effects[i-3] * lag3) + (effects[i-4] * lag4) + dem_shortrun
  effects <- c(effects, eff)
}
```

---

## Appendix: Figure 2

Dynamic Effects of Democratization 30 years after event with 95% Confidence Intervals

```R
ggplot(trend, aes(x = 1:30, y = effects)) +
  geom_line() + #trend estimate
  geom_line(aes(y = upper), linetype = "dashed") + #upper confidence interval
  geom_line(aes(y = lower), linetype = "dashed") + #lower confidence interval
  geom_hline(yintercept = 0, color="gray") + #zero line
  geom_hline(yintercept = 10, color="gray") + #10 GDP per capita log point mark
  geom_hline(yintercept = 20, color="gray") + #20 GDP per capita log point mark
  geom_hline(yintercept = 30, color="gray") + #30 GDP per capita log point mark
  labs(
    x = "Years since Democratization",  #x axis label
    y = "Change in GDP per Capita Log Points") + #y axis label
  theme_classic() +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank())
```

---

## Appendix: Table 7

Formula for Dynamic Linear Panel Model and Regression

$$
m_{ct} = \beta D_{ct} + \sum_{j=1}^p \gamma_j y_{ct-j} + \sum_{j=1}^p \eta_j m_{ct-j} + \alpha_c + \delta_t+\epsilon_{ct}
$$

```R
model1 <- plm(
  loginvpc ~ dem + plm::lag(y,1:4)+ plm::lag(loginvpc, 1:4), # 4 lags for y and the variable
  model="within", #The fixed effects within estimator
  data = pdf, 
  effect = "twoways" #country and year fixed effects
  )
```