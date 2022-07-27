library(ggplot2)

set.seed(3)
x1 <- rnorm(500)
x2 <- rnorm(500, mean = 3)
x <- c(x1, x2)
group <- c(rep("G1", 500), rep("G2", 500))

df <- data.frame(x, group = group)

# Histogram by group in ggplot2
ggplot(df, aes(x = x, fill = group)) + 
  geom_histogram()

# colour
ggplot(df, aes(x = x, colour = group)) + 
  geom_histogram()

# identity position
ggplot(df, aes(x = x, fill = group, colour = group)) + 
  geom_histogram(alpha = 0.5, position = "identity")

# dodge position
ggplot(df, aes(x = x, fill = group, colour = group)) + 
  geom_histogram(position = "dodge")

# Borders color
ggplot(df, aes(x = x, fill = group)) + 
  geom_histogram(colour = "black",
                 lwd = 0.75,
                 linetype = 1,
                 position = "identity")

# fill color
ggplot(df, aes(x = x, colour = group)) + 
  geom_histogram(fill  = "white",
                 position = "identity")

# Custom border colors for each group
ggplot(df, aes(x = x, colour = group)) + 
  geom_histogram(fill  = "white",
                 position = "identity") +
  scale_color_manual(values = c("blue", "orange", "red"))

# Custom fill colors for each group
ggplot(df, aes(x = x, fill = group)) + 
  geom_histogram(color = 1, alpha = 0.75,
                 position = "identity") +
  scale_fill_manual(values = c("#8795E8", "#FF6AD5", "lightpink"))

# Custom legend title
ggplot(df, aes(x = x, fill = group, colour = group)) + 
  geom_histogram(alpha = 0.5, position = "identity") + 
  guides(fill = guide_legend(title = "Title"),
         colour = guide_legend(title = "Title"))

# Custom legend labels
ggplot(df, aes(x = x, fill = group, colour = group)) + 
  geom_histogram(alpha = 0.5, position = "identity") + 
  scale_color_discrete(labels = c("A", "B")) +
  scale_fill_discrete(labels = c("A", "B"))

# Legend position
ggplot(df, aes(x = x, fill = group, colour = group)) + 
  geom_histogram(alpha = 0.5, position = "identity") + 
  theme(legend.position = "left")

# Remove the legend
ggplot(df, aes(x = x, fill = group, colour = group)) + 
  geom_histogram(alpha = 0.5, position = "identity") + 
  theme(legend.position = "none")
