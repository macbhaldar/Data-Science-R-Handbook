# ggforce: hull plots

library(ggforce)
library(tidyquant)
library(tidyverse)

mpg

# HULL PLOT PROGRESSION
## Hull Plots are used to indicate clusters / group assignment

# Make the Base Plot
g1 <- mpg %>%
  mutate(engine_size = str_c("Cylinder: ", cyl)) %>%
  ggplot(aes(displ, hwy)) +
  geom_point()

g1

# Add Cluster Assignments by Engine Size (Cyl)
g2 <- g1 +
  geom_mark_hull(
    aes(fill = engine_size, label = engine_size),
    concavity = 2.8
  )

g2


# add Theme and Formatting

g3 <- g2 +
  geom_smooth(se = FALSE, span = 1.0) +
  expand_limits(y = 50) +
  theme_tq() +
  scale_fill_tq() +
  labs(
    title = "Fuel Economy (MPG) Trends by Engine Size and Displacement",
    subtitle = "Hull plot to indicate clusters / group assignment",
    y = "Highway Fuel Economy (MPG)",
    x = "Engine Displacement Volume (Liters)",
    fill = "",
    caption = "Engine size has a negative relationship to fuel economy."
  )

g3
