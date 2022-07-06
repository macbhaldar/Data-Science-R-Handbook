# Statistical Plotting with ggstatsplot

library(ggstatsplot)
library(tidyverse)

# DATA PREPARATION
txhousing

set.seed(123)
txhousing_sampled_tbl <- txhousing %>%
  dplyr::sample_frac(size = 0.10)

# Compare multiple numeric variables to show relationships

# Plot
txhousing_sampled_tbl %>%
  ggcorrmat(
    cor.vars    = sales:date,
    matrix.type = "upper",
    sig.level   = 0.05
  )


# Compare categories to show differences between groups

top_5_cities <- txhousing_sampled_tbl %>%
  count(city, sort = TRUE) %>%
  slice(1:5) %>%
  pull(city)

txhousing_sampled_tbl %>%
  filter(city %in% top_5_cities) %>%
  ggbetweenstats(
    x = city,
    y = median,
    type = "robust",
    
    # Tag outliers
    outlier.tagging    = TRUE,
    outlier.label.args = list(color = "red", size = 3),
    
    title = "Comparison of Median Home Prices, Top 5 Texas Cities"
  )