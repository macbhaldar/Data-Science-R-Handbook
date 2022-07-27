library(ggplot2)

# Basic scatter plot
ggplot(cars, aes(x = speed, y = dist)) +
  geom_point()

# color
ggplot(cars, aes(x = speed, y = dist)) +
  geom_point(colour = 4)

# Gradient color
ggplot(cars, aes(x = speed, y = dist, color = dist)) +
  geom_point()

# Transparency
ggplot(cars, aes(x = speed, y = dist, alpha = dist)) +
  geom_point(colour = 2)

# Color scale
ggplot(cars, aes(x = speed, y = dist,
                 colour = dist)) +
  geom_point(show.legend = FALSE) +
  scale_color_gradient(low = "#67c9ff", high = "#f2bbfc")

# Color based on values
ggplot(cars, aes(x = speed, y = dist)) +
  geom_point(aes(colour = dist > 25 & dist < 50),
             show.legend = FALSE) +
  geom_hline(yintercept = 25, linetype = "dashed") + 
  geom_hline(yintercept = 50, linetype = "dashed")

# Shape and size of the points
ggplot(cars, aes(x = speed, y = dist)) +
  geom_point(size = 3, shape = 17)
