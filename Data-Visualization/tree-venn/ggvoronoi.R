library(ggvoronoi)
library(ggplot2)

# Data
set.seed(1)
x <- sample(1:400, size = 100)
y <- sample(1:400, size = 100)
dist <- sqrt((x - 200) ^ 2 + (y - 200) ^ 2)

df <- data.frame(x, y, dist = dist)

ggplot(df, aes(x, y)) +
  stat_voronoi(geom = "path")

# Observations
ggplot(df, aes(x, y)) +
  stat_voronoi(geom = "path") +
  geom_point()

# Path style
ggplot(df, aes(x, y)) +
  stat_voronoi(geom = "path",
               color = 4,      # Color of the lines
               lwd = 0.7,      # Width of the lines
               linetype = 1) + # Type of the lines
  geom_point()

# Voronoi heat map
ggplot(df, aes(x, y, fill = dist)) +
  geom_voronoi() +
  geom_point()

# path of the diagram
ggplot(df, aes(x, y, fill = dist)) +
  geom_voronoi() +
  stat_voronoi(geom = "path") +
  geom_point()

# transparency of the color
ggplot(df, aes(x, y, fill = dist)) +
  geom_voronoi(alpha = 0.75) +
  stat_voronoi(geom = "path") +
  geom_point()

# color
ggplot(df, aes(x, y, fill = dist)) +
  geom_voronoi() +
  stat_voronoi(geom = "path") +
  geom_point() +
  scale_fill_gradient(low = "#F9F9F9",
                      high = "#312271")

# remove the legend
ggplot(df, aes(x, y, fill = dist)) +
  geom_voronoi() +
  stat_voronoi(geom = "path") +
  geom_point() +
  theme(legend.position = "none")

# Bounding box
# Circle
s <- seq(0, 2 * pi, length.out = 3000)
circle <- data.frame(x = 120 * (1 + cos(s)),
                     y = 120 * (1 + sin(s)),
                     group = rep(1, 3000))

ggplot(df, aes(x, y, fill = dist)) +
  geom_voronoi(outline = circle,
               color = 1, size = 0.1) +
  scale_fill_gradient(low = "#B9DDF1",
                      high = "#2A5783",
                      guide = FALSE) +
  theme_void() +
  coord_fixed()
