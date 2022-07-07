# Easystats Performance

# install.packages("performance", dependencies = TRUE)

library(tidyverse)
library(performance)

mpg

# PERFORMANCE

model_lm <- lm(hwy ~ displ + class, data = mpg)

model_lm

check_model(model_lm)


# TIDYMODELS

library(tidymodels)

## Linear Regression
model_lm_tidy <- linear_reg() %>%
  set_engine("lm") %>%
  fit(hwy ~ displ + class, data = mpg)

check_model(model_lm_tidy)
