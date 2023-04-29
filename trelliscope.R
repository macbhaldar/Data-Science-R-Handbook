library(tidyverse)
library(plotly)
library(trelliscopejs)

mpg


mpg %>% 
  ggplot(aes(displ, hwy)) +
  geom_point(size=4) + 
  geom_smooth(se = FALSE, span = 1) +
  facet_trelliscope(
    ~ manufacturer,
    ncol = 4,
    nrow = 3
  )

mpg %>% 
  ggplot(aes(displ, hwy)) +
  geom_point(size=4) + 
  geom_smooth(se = FALSE, span = 1) +
  facet_trelliscope(
    ~ manufacturer,
    ncol = 4,
    nrow = 3,
    as_plotly = TRUE
  )
