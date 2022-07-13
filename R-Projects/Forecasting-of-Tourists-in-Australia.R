# Forecasting of Tourists in Australia
  
knitr::opts_chunk$set(echo = TRUE)

pacman::p_load(e1071, tidyverse, caret, rmarkdown,
               corrplot, readxl, ModelMetrics, fpp2,expsmooth,CombMSC)
theme_set(theme_classic())

data(visitors)
view(visitors)

# Monthly Australian short-term overseas vistors. May 1985-April 2005
## Time Plot
autoplot(visitors) +
  ggtitle("Australian short-term overseas vistors") +
  xlab("Year") + ylab("# of Visitors(Thousands)") 

## Season Plots
ggseasonplot(visitors, year.labels = TRUE) +
  ylab("# of Visitors(Thousands)") +
  ggtitle("Monthly Australian short-term overseas vistors")

## Polar seasonal plot
ggseasonplot(visitors, polar=TRUE) +
  ylab("# of Visitors(Thousands)") +
  ggtitle("Monthly Australian short-term overseas vistors")

# ANALYSIS :

## Subseries Plot (y vs. year, by month):__ Blue Line gives the mean in this
ggsubseriesplot(visitors) +
  ylab("# of Visitors(Thousands)") +
  ggtitle("Monthly Australian short-term overseas vistors")

# ANALYSIS :
## Auto Correlation Plot

# Lag Plot
gglagplot(visitors)
# ACF or Correlogram
ggAcf(visitors)
autoplot(visitors) + xlab("Year") + ylab("# of Visitors(Thousands)")
ggAcf(visitors, lag= 48)

# ANALYSIS :

## Test Train Split
?visitors

visitors_split <- splitTrainTest(visitors, numTrain = length(visitors) - 24)
visitors_split$train
visitors_split$test

# Holt Winters Multiplicative Method

fit1 <- hw(visitors_split$train,seasonal="additive")
fit2 <- hw(visitors_split$train,seasonal="multiplicative")
fit1[["model"]]
fit2[["model"]]
autoplot(visitors) +
  autolayer(fit1, series="HW additive forecasts", PI=FALSE) +
  autolayer(fit2, series="HW multiplicative forecasts",
            PI=FALSE) +
  xlab("Year") +
  ylab("Monthly Visitors") +
  ggtitle("Monthly Australian overseas vistors") +
  guides(colour=guide_legend(title="Forecast"))


# ETS

fit <- ets(visitors_split$train) # using to generate a forecast but with prediction intervals
summary(fit)
autoplot(fit)
cbind('Residuals' = residuals(fit), 'Forecast errors' = residuals(fit,type='response')) %>%
  autoplot(facet=TRUE) + 
  xlab("Year") + ylab("")
### Forecasts with ETS Models
fit %>% forecast(h=24) %>%
  autoplot() + ylab("Monthly Australian overseas vistors") 


# Additive ETS with Box-Cox Transformed Series

lambda <- BoxCox.lambda(visitors)
fit2 <- ets(visitors_split$train,additive.only=TRUE,lambda=lambda) # using to generate a forecast but with prediction intervals
summary(fit2)
autoplot(fit2)
cbind('Residuals' = residuals(fit2), 'Forecast errors' = residuals(fit2,type='response')) %>%
  autoplot(facet=TRUE) + 
  xlab("Year") + ylab("")
### Forecasts with ETS Models
fit2_forecast <- fit2 %>% forecast(h=24) %>%
  autoplot() + ylab("Monthly Australian overseas vistors") 

# Seasonal Naive

seasonal_naive <- snaive(visitors_split$train, h=24)
summary(seasonal_naive)
autoplot(visitors) +
  autolayer(seasonal_naive,
            series="Seasonal naive", PI=FALSE) +
  ggtitle("Forecasts for Monthly Australian overseas vistors") +
  xlab("Year") + ylab("# of Visitors(Thousands") +
  guides(color=guide_legend(title="Forecast"))

# Which Method is best of - ETS, Additive ETS with Box-Cox Transformation and Seasonal Naive

## Forecast accuracy (using Test data)
accuracy(forecast(fit,h=24), visitors_split$test)
accuracy(forecast(fit2,h=24), visitors_split$test)
accuracy(forecast(seasonal_naive,h=24), visitors_split$test)

# Residual Test
#Finding Residuals
checkresiduals(fit)
checkresiduals(fit2)
checkresiduals(seasonal_naive)

"""
Analysis: ETS and Additive ETS with Box-Cox Transformation Residual plots show that there is White Noise as they mostly follow Normal Distribution and the ACF doesn't show Autocorrelation.

Seasonal Naive - After plotting the Residuals, we can see that the distribution doesn't look like a Normal Distribution.
Neither are 95% or more fall under the blue margins(95% confidence interval) in the ACF so there is no White Noise and it fails the Residual Test.
"""