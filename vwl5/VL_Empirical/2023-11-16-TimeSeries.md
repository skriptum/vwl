# 16.11.2023 Time Series

## Time Series

```{r}
library(tseries)
```

**Import Data**

```{r}
data <- read.table("data/Per_Capita_GDP_Data_1870-1987.asc", header=T)
head(data)
```

Bind the Column and Data set together = `cbind()`

```{r}
startyear <- 1870
year <- seq(from=startyear, to= 1987, by=1)
data_GDP <- cbind(year, data) 
head(data_GDP) # new year column
```

**Define Time Series**

```{r}
data_ts <- ts(data_GDP, startyear)
class(data_ts)
```

```         
[1] "mts"    "ts"     "matrix"
```

MTS = multiple Time Series

**apply diff**

```{r}
us_diff <- diff(log(data_ts[,"USA"]))
```

1.  Take the Column USA
2.  log the GDP
3.  now take the Difference $\Delta y = y_{t} - y_{t-1}$

=\> Growth Rate of Log GDP in USA

**Plot**

```{r}
plot(data_ts[,c("USA")])
```

```{r}
plot(us_diff)
```

## Panel Data

```{r}
library(plm)
library(stargazer)
```

```{r}
data(wagepan, package='wooldridge') # directly from package witoout loading
head(wagepan)
```

Get Panel Data from thsi with `pdata.frame()`

```{r}
wagepan.p <- pdata.frame(wagepan, index=c("nr","year") ) #added HA: individual index and time index
pdim(wagepan.p)
```

-   n = number of individuals / regions = 545
-   T = Number of observations of the indiviudals = 8
-   N = n\*T

**Regressions with `plm()`**

1\) Simple linear Regression with all data pooled

```{r}
wagemodel1 <- plm(lwage ~ married + union + exper, data=wagepan.p, model="pooling")
```

2\) now same as above but with controls

```{r}
wagemodel2 <- plm(lwage ~ married + black + union + educ + exper, data=wagepan.p, model="pooling")
```

3\) estimate fixed effects model (based on "within-transformation" of data) \<--\> pooling model

**NOTE: use for my Acemoglu Paper!!**

```{r}
wagemodel3 <- plm(lwage ~ married + union + educ + exper, data=wagepan.p, model="within")
```

Summary

```{r}
summary(wagemodel3)
```

4\) same, but with year dummy for shock absorption

Used with `factor(year)` for easy year incuding of the variables

```{r}
wagemodel4 <- plm(lwage ~ married + black + union + educ + exper + factor(year), data=wagepan.p, model="pooling")
```

Combine all and get stargazer to analyze it

```{r}
#| results='asis' 
mywagemodels <- list(wagemodel1,wagemodel2,wagemodel3,wagemodel4)
stargazer(
  mywagemodels, 
  type="html"
  #out="data/mywagemodels.html"
  )
```

## ggplot

```{r}
library(tidyverse)
```

Replicating the Data from AJR 2001

```{r}
load("data/dataset_AJR2001.Rdata")
head(data)
```

Simple:

```{r}
ggplot(data=data, aes(x = logem4, y=logpgp95)) +
    geom_point() + 
    geom_smooth(method="lm")
```

Advanced:

```{r}
figure <- ggplot(data, aes(x = logem4, y=logpgp95)) + #Settler mortality and GDP per Cap
  #geom_point() + #if we want to use points
  geom_text(aes(label=data[,1]),hjust=0, vjust=0) + #if we want the country names as points
  geom_smooth(color="black",method="lm", se=FALSE) + 
  theme_classic()+ 
  coord_cartesian(xlim=c(2,8), ylim=c(4,10.5)) + 
  labs(
    title="Figure 1 from AJR (2001) with ggplot()",
    x="Log of European Settler Mortality", 
    y="Log GDP per capita, PPP, 1995"
    )
figure
```
