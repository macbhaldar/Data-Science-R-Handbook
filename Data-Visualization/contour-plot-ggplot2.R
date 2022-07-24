library(ggplot2)

# Data
set.seed(1)
df <- data.frame(x = rnorm(200), y = rnorm(200))

ggplot(df, aes(x = x, y = y)) +
  geom_density_2d()

# Number of levels
ggplot(df, aes(x = x, y = y)) +
  geom_density_2d(bins = 15)

# Scatter plot with contour lines
ggplot(df, aes(x = x, y = y)) +
  geom_point() + 
  geom_density_2d()

# Color
ggplot(df, aes(x = x, y = y)) +
  geom_density_2d(color = "red")

# Color based on the level
ggplot(df, aes(x = x, y = y)) +
  geom_density_2d(aes(color = ..level..))

# Change the color palette
ggplot(df, aes(x = x, y = y)) +
  geom_density_2d(aes(color = ..level..)) +
  scale_color_viridis_c()

# Fill the contour with stat_density_2d
ggplot(df, aes(x = x, y = y, fill = ..level..)) +
  stat_density_2d(geom = "polygon")

# geom_density_2d_filled function
ggplot(df, aes(x = x, y = y)) +
  geom_density_2d_filled()

# Color palette
ggplot(df, aes(x = x, y = y)) +
  geom_density_2d_filled() +
  scale_fill_brewer()

# Transparency
ggplot(df, aes(x = x, y = y)) +
  geom_density_2d_filled(alpha = 0.75)

# Filled contour with lines
ggplot(df, aes(x = x, y = y)) +
  geom_density_2d_filled() +
  geom_density_2d(colour = "black")

# Points and filled contour
ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  geom_density_2d_filled(alpha = 0.4) +
  geom_density_2d(colour = "black")

# Title of the legend
ggplot(df, aes(x = x, y = y)) +
  geom_density_2d_filled() +
  guides(fill = guide_legend(title = "Level"))
