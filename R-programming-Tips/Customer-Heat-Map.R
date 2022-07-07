# ggplot2: Customer Heat Map

library(tidyverse)
library(tidyquant)

sales_by_customer_tbl <- read_rds("data/sales_by_customer.rds")

sales_by_customer_tbl

# HEATMAP DATA WRANGLE

prop_sales_by_customer_tbl <- sales_by_customer_tbl %>%
  group_by(bikeshop_name) %>%
  mutate(prop = quantity / sum(quantity)) %>%
  ungroup() %>%
  
  # AVOID THIS ROOKIE MISTAKE - DON'T FORGET TO SORT BY TOP PRODUCT

select(-quantity) %>%
  pivot_wider(
    id_cols     = bikeshop_name,
    names_from  = product_category,
    values_from = prop
  ) %>%
  arrange(-`Elite Road`) %>%
  mutate(bikeshop_name = fct_reorder(bikeshop_name, `Elite Road`)) %>%
  pivot_longer(
    cols      = -bikeshop_name,
    names_to  = "product_category",
    values_to = "prop"
  )


# HEATMAP VISUALIZATION

prop_sales_by_customer_tbl %>%
  
  ggplot(aes(product_category, bikeshop_name)) +
  
  # Geometries
  geom_tile(aes(fill = prop)) +
  geom_text(aes(label = scales::percent(prop, accuracy = 1)),
            size = 3) +
  
  
  # Formatting
  scale_fill_gradient(low = "white", high = palette_light()[1]) +
  labs(
    title = "Heatmap of Customer Purchasing Habits",
    subtitle = "Used to investigate Customer Similarity",
    x = "Bike Type (Product Category)",
    y = "Bikeshop (Customer)"
  ) +
  
  theme_tq() +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    legend.position = "none",
    plot.title = element_text(face = "bold"),
    plot.subtitle = element_text(face = "bold.italic")
  )
