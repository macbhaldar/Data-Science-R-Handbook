library(reshape)
library(ggplot2)

set.seed(2)

# Grid
t <- seq(0, 1, by = 0.001)
p <- length(t) - 1

# 5 paths
n <- 5
I <- matrix(rnorm(n * p, 0, 1 / sqrt(p)), n, p)

# Data frame
df1 <- data.frame(apply(I, 1, cumsum))

df <- data.frame(x = seq_along(df1[, 1]),
                 df1)

# Long format
df <- melt(df, id.vars = "x")


# Line chart of several variables
ggplot(df, aes(x = x, y = value, color = variable)) +
  geom_line()

# Lines width and style
ggplot(df, aes(x = x, y = value, color = variable)) +
  geom_line(linetype = 3,
            lwd = 1.1)

# Color customization
cols <- c("#D43F3A", "#EEA236", "#5CB85C", "#46B8DA", "#9632B8")
ggplot(df, aes(x = x, y = value, color = variable)) +
  geom_line() +
  scale_color_manual(values = cols)

# Highlight some lines
cols <- c("gray", "gray", "gray", "#5CB85C", "gray")
ggplot(df, aes(x = x, y = value, color = variable)) +
  geom_line() +
  scale_color_manual(values = cols)

# Legend customization

# Title
ggplot(df, aes(x = x, y = value, color = variable)) +
  geom_line() +
  guides(color = guide_legend(title = "Title"))

# Legend labels
ggplot(df, aes(x = x, y = value, color = variable)) +
  geom_line() +
  scale_color_discrete(labels = paste("V", 1:5))

# Remove the legend
ggplot(df, aes(x = x, y = value, color = variable)) +
  geom_line() +
  theme(legend.position = "none")
