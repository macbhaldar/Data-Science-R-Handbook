# Modeltime

library(modeltime)
library(tidymodels)
library(tidyverse)
library(timetk)
library(lubridate)

bike_sharing_daily

data <- bike_sharing_daily %>%
  select(dteday, cnt)

data %>% plot_time_series(dteday, cnt)

# TRAIN / TEST SPLITS

splits <- time_series_split(
  data,
  assess     = "3 months",
  cumulative = TRUE
)

splits %>%
  tk_time_series_cv_plan() %>%
  plot_time_series_cv_plan(dteday, cnt)

# FORECAST

## AUTO ARIMA
model_arima <- arima_reg() %>%
  set_engine("auto_arima") %>%
  fit(cnt ~ dteday, training(splits))

model_arima

## Prophet
model_prophet <- prophet_reg(
  seasonality_yearly = TRUE
) %>%
  set_engine("prophet") %>%
  fit(cnt ~ dteday, training(splits))

model_prophet

## Machine Learning - GLM
model_glmnet <- linear_reg(penalty = 0.01) %>%
  set_engine("glmnet") %>%
  fit(
    cnt ~ wday(dteday, label = TRUE)
    + month(dteday, label = TRUE)
    + as.numeric(dteday),
    training(splits)
  )

model_glmnet


# MODELTIME COMPARE

## Modeltime Table
model_tbl <- modeltime_table(
  model_arima,
  model_prophet,
  model_glmnet
)

## Calibrate
calib_tbl <- model_tbl %>%
  modeltime_calibrate(testing(splits))

## Accuracy
calib_tbl %>% modeltime_accuracy()

## Test Set Visualization
calib_tbl %>%
  modeltime_forecast(
    new_data    = testing(splits),
    actual_data = data
  ) %>%
  plot_modeltime_forecast()

## Forecast Future
future_forecast_tbl <- calib_tbl %>%
  modeltime_refit(data) %>%
  modeltime_forecast(
    h           = "3 months",
    actual_data = data
  )

future_forecast_tbl %>%
  plot_modeltime_forecast()
