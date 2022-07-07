# Trelliscope JS: Interactive Data Visualization with ggplot

library(tidyverse)
library(plotly)
library(trelliscopejs)


mpg

# GGPLOT
## Add Labels: Displ Min/Max, Hwy Min/Max/Mean
mpg %>%
  ggplot(aes(displ, hwy)) +
  geom_point(size = 4) +
  geom_smooth(se = FALSE, span = 1) +
  facet_trelliscope(
    ~ manufacturer,
    ncol      = 4,
    nrow      = 3
  )


# MEGA BONUS: INTERACTIVE (plotly)
mpg %>%
  ggplot(aes(displ, hwy)) +
  geom_point() +
  geom_smooth(se = FALSE, span = 1) +
  facet_trelliscope(
    ~ manufacturer,
    ncol      = 4,
    nrow      = 3,
    as_plotly = TRUE
  )
