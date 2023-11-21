library(stargazer)
library(plm)

library(tidyverse)
library(haven)
library(ivreg)


DDCGdata <- read_dta("vortrag/DDCGdata.dta")

df <- DDCGdata %>%
  dplyr::select(1:100) %>%
  dplyr::mutate(loggdp = log(gdppercapitaconstant2000us))
  
rm(DDCGData)
head(df)



pdf = pdata.frame(df, index=c("country_name", "year"))
head(pdf)


ivreg(
    y ~ plm::lag(y, 1) + factor(country_name) + factor(year) | plm::lag(demreg, 1) + plm::lag(demreg, 1) + factor(year) + factor(country_name)),
    data=pdf
    )
summary(ivreg)


