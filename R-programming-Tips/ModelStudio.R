# ModelStudio: Interactive Studio for Explanatory Model Analysis

library(modelStudio)
library(DALEX)
library(tidyverse)
library(tidymodels)

data_tbl <- mpg %>%
  select(hwy, manufacturer:drv, fl, class)

# MODEL
fit_xgboost <- boost_tree(learn_rate = 0.3) %>%
  set_mode("regression") %>%
  set_engine("xgboost") %>%
  fit(hwy ~ ., data = data_tbl)

fit_xgboost

# EXPLAINER
explainer <- DALEX::explain(
  model = fit_xgboost,
  data  = data_tbl,
  y     = data_tbl$hwy,
  label = "XGBoost"
)

# MODEL STUDIO
modelStudio::modelStudio(explainer)
