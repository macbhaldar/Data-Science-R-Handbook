# grafify: Easy Graphs and ANOVAs

# remotes::install_github("ashenoy-cmbi/grafify@*release", dependencies = T)

library(grafify)
library(tidyverse)

mpg

# GRAPHING 2-VARIABLES

# Scatterbar SD
mpg %>%
  plot_scatterbar_sd(cyl, hwy)

# Scatterbox
mpg %>%
  plot_scatterbox(cyl, hwy, jitter = 0.2, s_alpha = 0.5)

# Dotviolin
mpg %>%
  plot_dotviolin(cyl, hwy, dotsize = 0.4, ColPal = "bright")

# GRAPHING 3-VARIABLES

mpg %>%
  plot_3d_scatterbox(cyl, hwy, class, s_alpha = 0)

# BEFORE-AFTER PLOTS

mpg %>%
  group_by(model, year) %>%
  summarize(mean_hwy = mean(hwy)) %>%
  ungroup() %>%
  plot_befafter_colors(year, mean_hwy, model)
