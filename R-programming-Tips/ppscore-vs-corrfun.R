# PPSCORE VS CORRELATION FUNNEL

library(ppsr) # devtools::install_github('https://github.com/paulvanderlaken/ppsr')
library(correlationfunnel)
library(tidyverse)

customer_churn_tbl %>% glimpse()


# THE CONTENDER: Predictive Power Score (ppscore)

# Make the ppscore
churn_ppsr_score <- customer_churn_tbl %>%
  select(-customerID) %>%
  score_predictors(y = 'Churn', do_parallel = TRUE) %>%
  as_tibble()

churn_ppsr_score %>% glimpse()

# Plotting 1Bar
customer_churn_tbl %>%
  select(-customerID) %>%
  visualize_pps(y = "Churn", do_parallel = TRUE)

# Plotting Matrix
g <- customer_churn_tbl %>%
  select(-customerID) %>%
  visualize_pps(do_parallel = TRUE)

g +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# CORRELATION FUNNEL: A Binary Version of the Correlation Matrix

customer_churn_binned_tbl <- customer_churn_tbl %>%
  select(-customerID) %>%
  mutate(TotalCharges = ifelse(is.na(TotalCharges), 0, TotalCharges)) %>%
  binarize()

customer_churn_binned_tbl %>% glimpse()

customer_churn_binned_tbl %>%
  correlate(target = Churn__Yes) %>%
  plot_correlation_funnel() +
  geom_point(size = 3, color = "#2c3e50")


# TOP FEATURES

library(tidymodels)
library(xgboost)
library(vip)

recipe_spec <- recipe(Churn ~ ., data = customer_churn_tbl) %>%
  step_rm(customerID) %>%
  step_dummy(all_nominal(), -Churn)

recipe_spec %>% prep() %>% juice() %>% glimpse()

wflw_fit_xgb <- workflow() %>%
  add_model(boost_tree(mode = "classification") %>% set_engine("xgboost")) %>%
  add_recipe(recipe_spec) %>%
  fit(customer_churn_tbl)

wflw_fit_xgb$fit$fit$fit %>% vip()
