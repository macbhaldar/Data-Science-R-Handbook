# gghalves: Half Dot Plots and Half Boxplots

library(gghalves)
library(tidyverse)
library(tidyquant)

mpg


# BASIC JITTER PLOT

mpg %>%
  filter(cyl != 5) %>%
  mutate(cyl = factor(cyl)) %>%
  ggplot(aes(cyl, hwy)) +
  geom_jitter() +
  theme_tq()

# BOXPLOT: Distribution

mpg %>%
  filter(cyl != 5) %>%
  mutate(cyl = factor(cyl)) %>%
  ggplot(aes(cyl, hwy)) +
  geom_boxplot(outlier.colour = "red") +
  theme_tq()

# HALF-BOXPLOT / HALF-DOTPLOT
mpg %>%
  filter(cyl != 5) %>%
  mutate(cyl = factor(cyl)) %>%
  ggplot(aes(cyl, hwy, color = cyl)) +
  
  geom_half_boxplot(outlier.color = "red") +
  geom_half_dotplot(
    aes(fill = cyl),
    dotsize = 0.75,
    stackratio = 0.5,
    color = "black"
  ) +
  
  facet_grid(cols = vars(cyl), scales = "free_x") +
  scale_color_tq() +
  scale_fill_tq() +
  theme_tq() +
  labs(
    title = "Highway Fuel Economy by Engine Size",
    subtitle = "Half-Boxplot + Half-Dotplot"
  )

# INSPECT CYL 6
mpg %>%
  filter(cyl == 6) %>%
  ggplot(aes(class, hwy, fill = class)) +
  geom_boxplot() +
  scale_fill_tq() +
  theme_tq() +
  labs(title = "6 Cylinder Vehicles: Pickup and SUV causing Bi-Modal Relationship")


# Bonus: With Half Plots
mpg %>%
  filter(cyl == 6) %>%
  ggplot(aes(class, hwy, fill = class)) +
  geom_half_boxplot(
    outlier.colour = "red"
  ) +
  geom_half_dotplot(
    aes(fill = class),
    dotsize = 0.75,
    stackratio = 0.5,
    color = "black"
  ) +
  scale_color_tq() +
  scale_fill_tq() +
  theme_tq() +
  labs(title = "6 Cylinder Vehicles: Pickup and SUV causing Bi-Modal Relationship")
