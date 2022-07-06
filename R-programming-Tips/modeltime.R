library(tidyverse)
library(timetk)
library(modeltime)

m4_monthly %>%
  group_by(id) %>%
  plot_time_series(date, value)

a <- 1

add2 <- function(x, y) {
  x + y
}

add2(3, 4)

library(modeltime)
library(modeltime.ensemble)
library(modeltime.gluonts)
