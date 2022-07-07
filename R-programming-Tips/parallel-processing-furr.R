# furrr: Parallel Processing 

library(tidyverse)
library(timetk)
library(lubridate)
library(furrr)
library(tictoc)

sales_data_tbl <- walmart_sales_weekly %>%
  select(id, Date, Weekly_Sales) %>%
  set_names(c("id", "date", "value"))

# PURRR

tic()
sales_data_tbl %>%
  nest(data = c(date, value)) %>%
  mutate(model = map(data, function(df) {
    Sys.sleep(1)
    lm(value ~ month(date) + as.numeric(date), data = df)
  }))
toc()

# FURRR (Parallel Processing)
plan(multisession, workers = 6)

tic()
sales_data_tbl %>%
  nest(data = c(date, value)) %>%
  mutate(model = future_map(data, function(df) {
    Sys.sleep(1)
    lm(value ~ month(date) + as.numeric(date), data = df)
  }))
toc()
