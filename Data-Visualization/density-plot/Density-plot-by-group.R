library(ggplot2)

# Data
set.seed(5)
x <- c(rnorm(200, mean = -2, 1.5),
       rnorm(200, mean = 0, sd = 1),
       rnorm(200, mean = 2, 1.5))
group <- c(rep("A", 200), rep("B", 200), rep("C", 200))
df <- data.frame(x, group)


# Basic density plot in ggplot2
ggplot(df, aes(x = x, colour = group)) +
  geom_density()

# color palette for the lines
cols <- c("#F76D5E", "#FFFFBF", "#72D8FF")
ggplot(df, aes(x = x, colour = group)) +
  geom_density(lwd = 1.2, linetype = 1) + 
  scale_color_manual(values = cols)

# Fill the density areas
ggplot(df, aes(x = x, colour = group, fill = group)) +
  geom_density()

# Transparency and custom colors
cols <- c("#F76D5E", "#FFFFBF", "#72D8FF")
ggplot(df, aes(x = x, fill = group)) +
  geom_density(alpha = 0.7) + 
  scale_fill_manual(values = cols)

# Remove the lines
cols <- c("#F76D5E", "#FFFFBF", "#72D8FF")
ggplot(df, aes(x = x, fill = group)) +
  geom_density(alpha = 0.8, color = NA) + 
  scale_fill_manual(values = cols)

# Legend customization
# Custom title
ggplot(df, aes(x = x, fill = group)) +
  geom_density() + 
  guides(fill = guide_legend(title = "Title"))

# Custom labels
ggplot(df, aes(x = x, fill = group)) +
  geom_density() + 
  scale_fill_hue(labels = c("G1", "G2", "G3"))

# Remove the legend
ggplot(df, aes(x = x, fill = group)) +
  geom_density() + 
  theme(legend.position = "none")
