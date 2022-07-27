library(ggplot2)

set.seed(1)

# Data simulation
x <- runif(500)
y <- 5 * x ^ 2 + rnorm(length(x), sd = 2)
group <- ifelse(x < 0.4, "A",
                ifelse(x > 0.8, "C", "B"))
x <- x + runif(length(x), -0.2, 0.2)

# Data frame
df <- data.frame(x = x, y = y, group = group)

# Scatter plot by group
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point()

# Changing the colors
cols <- c("#1170AA", "#55AD89", "#EF6F6A")
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point() +
  scale_color_manual(values = cols)

# Changing the shape and the size
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point(shape = 17, size = 2)

# Shape by group
ggplot(df, aes(x = x, y = y, color = group,
               shape = group)) +
  geom_point(size = 2)

# Legend title
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point(size = 2) +
  guides(colour = guide_legend(title = "Title"))

# Custom key labels
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point(size = 2) +
  scale_color_discrete(labels = c("G1", "G2", "G3"))

# Remove the legend
ggplot(df, aes(x = x, y = y, color = group)) +
  geom_point(size = 2) +
  theme(legend.position = "none")
