library(ggplot2)

# Sample data set
set.seed(1)
df <- data.frame(x = LETTERS[1:10],
                 y = sample(20:35, 10, replace = TRUE))

ggplot(df, aes(x = x, y = y)) +
  geom_segment(aes(x = x, xend = x, y = 0, yend = y)) +
  geom_point()

# horizontal lollipop chart
ggplot(df, aes(x = x, y = y)) +
  geom_segment(aes(x = x, xend = x, y = 0, yend = y)) +
  geom_point() +
  coord_flip()

# Lollipop customization

# Points
ggplot(df, aes(x = x, y = y)) +
  geom_segment(aes(x = x, xend = x, y = 0, yend = y)) +
  geom_point(size = 4, pch = 21, bg = 4, col = 1) +
  coord_flip()

# Segments
ggplot(df, aes(x = x, y = y)) +
  geom_segment(aes(x = x, xend = x, y = 0, yend = y),
               color = "gray", lwd = 1.5) +
  geom_point(size = 4, pch = 21, bg = 4, col = 1) +
  coord_flip()

# Custom labels
ggplot(df, aes(x = x, y = y)) +
  geom_segment(aes(x = x, xend = x, y = 0, yend = y),
               color = "gray", lwd = 1) +
  geom_point(size = 4, pch = 21, bg = 4, col = 1) +
  scale_x_discrete(labels = paste0("G_", 1:10)) +
  coord_flip()

# Rotate the labels
ggplot(df, aes(x = x, y = y)) +
  geom_segment(aes(x = x, xend = x, y = 0, yend = y),
               color = "gray", lwd = 1) +
  geom_point(size = 4, pch = 21, bg = 4, col = 1) +
  scale_x_discrete(labels = paste("Group", 1:10)) +
  theme(axis.text.x = element_text(angle = 90,
                                   vjust = 0.5, hjust = 1))

# Theme
ggplot(df, aes(x = x, y = y)) +
  geom_segment(aes(x = x, xend = x, y = 0, yend = y),
               color = "gray", lwd = 1) +
  geom_point(size = 4, pch = 21, bg = 4, col = 1) +
  scale_x_discrete(labels = paste0("G_", 1:10)) +
  coord_flip() +
  theme_minimal()

# Teext
ggplot(df, aes(x = x, y = y)) +
  geom_segment(aes(x = x, xend = x, y = 0, yend = y),
               color = "gray", lwd = 1) +
  geom_point(size = 7.5, pch = 21, bg = 4, col = 1) +
  geom_text(aes(label = y), color = "white", size = 3) +
  scale_x_discrete(labels = paste0("G_", 1:10)) +
  coord_flip() +
  theme_minimal()

# Lollipop order
ggplot(df, aes(x = reorder(x, -y), y = y)) +
  geom_segment(aes(x = reorder(x, -y),
                   xend = reorder(x, -y),
                   y = 0, yend = y),
               color = "gray", lwd = 1) +
  geom_point(size = 4, pch = 21, bg = 4, col = 1) +
  xlab("Group") +
  ylab("") +
  coord_flip() +
  theme_minimal()
