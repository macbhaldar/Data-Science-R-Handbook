library(ggplot2)

# Data
x <- c(1, 2, 3, 4, 5, 4, 7, 8, 9)
y <- c(12, 16, 14, 18, 16, 13, 15, 20, 22)
df <- data.frame(x, y)

# Connected scatter plot
ggplot(df, aes(x = x, y = y)) +
  geom_path()

# highlight the values
ggplot(df, aes(x = x, y = y)) +
  geom_path() +
  geom_point(size = 2)

# Labelling points
labels <- 2013:2021
df <- data.frame(x, y, labels = labels)

ggplot(df, aes(x = x, y = y)) +
  geom_path(color = 4) +
  geom_point(size = 2, color = 4) +
  geom_text(aes(label = labels, x = x + 0.7, y = y))

# Adding arrows
ggplot(df, aes(x = x, y = y)) +
  geom_path(color = 4, arrow = arrow()) +
  geom_point(size = 2, color = 4) +
  geom_text(aes(label = labels, x = x + 0.7, y = y))

# Add an arrow between each pair of points
ggplot(df, aes(x = x, y = y)) +
  geom_segment(aes(xend = c(tail(x, n = -1), NA), 
                   yend = c(tail(y, n = -1), NA)),
               arrow = arrow(length = unit(0.4, "cm")),
               color = 4) +
  geom_point(size = 2, color = 4) +
  geom_text(aes(label = labels, x = x + 0.7, y = y))
