# DDCG Slides

[TOC]

---

## About the Paper

Question

Authors

-   Daron Acemoglu

-   James A Robinson

-   Suresh Naidu

-   Pascual Restrepo


---
## Research Question

Why it is interesting:

---

## Problem: GDP Diversity and Dip

- heterogeneity of GDP growth
- Dip of GDP before democratization

Direct OLS is without much use

[FIGURE 1]

---

## Literature

Existing Literature



---

## Data

Democracy Data Sources

- Freedom House Index [@gorokhovskaiaFreedomHouseReport]
- Polity IV Database [@marshallPolityIVProject]
- Cheibub et al [@cheibubDemocracyDictatorshipRevisited2010]
- Boix et al [@boixCompleteDataSet2013]

Democracy Measure

- dichotomous (either 0 or 1)
- 1960 - 2010
- 184 Countries

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
model3 <- plm(
  y ~ dem + lag1 + lag2 + lag3 + lag4, #equation with 4 lags
  model="within", #The fixed effects within estimator
  data = pdf, 
  effect = "twoways" #country and year fixed effects
  )
```

---

## Results Table

[TABLE 2]

See Appendix for Calculation of *long run effects* -> & *short-run effects* ->

---

## Results Figure

[FIGURE 2]

See Appendix for Calculation of the dynamics ->

---

## Channels

Question: What are the main channels that impact growth

[TABLE 7]

See Appendix for Calculation

---

## Critique

- Dichotomous Measure of Democracy [@pelkeReanalysingLinkDemocracy2023]
- Short Time Frame <!-- lot of democratizations around 1990s-->
- Sensitivity to Sample Selection [@eberhardtDemocracyDoesCause2019]



---

## References



---

## Discussion Questions



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