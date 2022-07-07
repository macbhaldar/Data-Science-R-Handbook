# Survival Plots in R

library(tidyverse)
library(janitor)
library(tidyquant)
library(patchwork)
library(survival)
library(survminer)


customer_churn_tbl <- read_csv("data/customer_churn.csv") %>%
  clean_names() %>%
  mutate(churn = ifelse(churn == "Yes", 1, 0)) %>%
  mutate_if(is.character, as_factor)

customer_churn_tbl

# SURVIVAL MODEL

sfit_2 <- survfit(Surv(tenure, churn) ~ contract, data = customer_churn_tbl)

g1 <- ggsurvplot(
  sfit_2,
  conf.int = TRUE,
  data     = customer_churn_tbl
)

g1

# CUSTOMIZE WITH TIDYQUANT THEME TQ 
g1$plot

g1$plot +
  theme_tq() +
  scale_fill_tq() +
  scale_color_tq() +
  labs(title = "Customer Churn Survival Plot")


# ADDING A RISK TABLE
g2 <- ggsurvplot(
  sfit_2,
  conf.int = TRUE,
  data     = customer_churn_tbl,
  risk.table = TRUE
)

g2_plot <- g2$plot +
  theme_tq() +
  scale_fill_tq() +
  scale_color_tq() +
  labs(
    title = "Customer Churn Survival Plot"
  )

g2_table <- g2$table +
  theme_tq() +
  scale_fill_tq() +
  scale_color_tq() +
  theme(panel.grid = element_blank())

g2_plot / g2_table + plot_layout(heights = c(2,1))

# FACETING BY GROUPS
g3 <- ggsurvplot_facet(
  sfit_2,
  conf.int = TRUE,
  data     = customer_churn_tbl,
  facet.by = "gender",
  nrow     = 1
)

g3 +
  theme_tq() +
  scale_fill_tq() +
  scale_color_tq() +
  labs(title = "Survival Plot by Customer Gender")
