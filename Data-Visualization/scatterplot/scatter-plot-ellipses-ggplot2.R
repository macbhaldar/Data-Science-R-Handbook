library(ggplot2)

set.seed(2)

# Data simulation
x <- runif(500)
y <- 4 * x ^ 2 + rnorm(length(x), sd = 4)
group <- ifelse(x < 0.4, "A",
                ifelse(x > 0.8, "C", "B"))
x <- x + runif(length(x), -0.15, 0.15)

# Data frame
df <- data.frame(x = x, y = y, group = group)

# Adding ellipses
ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  stat_ellipse()

# Customization : color, line type and line width
ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  stat_ellipse(color = 2,
               linetype = 2,
               lwd = 1.2)

# Confidence levels
ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  stat_ellipse(level = 0.9) +
  stat_ellipse(level = 0.95, color = 2) +
  stat_ellipse(level = 0.99, color = 3)

# Segments
ggplot(df, aes(x = x, y = y)) +
  geom_point() +
  stat_ellipse(segments = 10)

# Ellipses by group
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point() +
  stat_ellipse()

# Linetype by group
ggplot(df, aes(x = x, y = y, color = group,
               linetype = group)) +
  geom_point() +
  stat_ellipse()

# Filling the area of the ellipses

# Polygon
ggplot(df, aes(x = x, y = y))+
  geom_point() +
  stat_ellipse(geom = "polygon",
               fill = 4, alpha = 0.25)

# Polygon by group
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point() +
  stat_ellipse(geom = "polygon",
               aes(fill = group))

# Polygon by group with transparency
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point() +
  stat_ellipse(geom = "polygon",
               aes(fill = group), 
               alpha = 0.25)

# Ellipse types
# Normal ellipse
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point() +
  stat_ellipse(type = "t") +
  stat_ellipse(type = "norm", linetype = 2)

# Euclidean ellipse
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point() +
  stat_ellipse(type = "euclid")
