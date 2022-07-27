library(ggplot2)

set.seed(136)
df <- data.frame(y = rnorm(300),
                 group = sample(LETTERS[1:3],
                                size = 300,
                                replace = TRUE))

library(ggplot2)

# Box plot by group
ggplot(df, aes(x = group, y = y)) + 
  geom_boxplot()

# Adding error bars
ggplot(df, aes(x = group, y = y)) + 
  stat_boxplot(geom = "errorbar", # Error bars
               width = 0.25) +    # Bars width
  geom_boxplot()

# Horizontal box plot by group
# Option 1: change the order of the variables
ggplot(df, aes(x = y, y = group)) + 
  stat_boxplot(geom = "errorbar",
               width = 0.25) + 
  geom_boxplot()

# Option 2: use coord_flip
ggplot(df, aes(x = group, y = y)) + 
  stat_boxplot(geom = "errorbar",
               width = 0.25) + 
  geom_boxplot() +
  coord_flip()

# Color customization
ggplot(df, aes(x = group, y = y, fill = group)) + 
  stat_boxplot(geom = "errorbar",
               width = 0.25) + 
  geom_boxplot()

# fill color
# Fill colors
cols <- c("#CFD8DC", "#90A4AE", "#455A64")

ggplot(df, aes(x = group, y = y, fill = group)) + 
  stat_boxplot(geom = "errorbar",
               width = 0.25) + 
  geom_boxplot(alpha = 0.8,          # Fill transparency
               colour = "#474747",   # Border color
               outlier.colour = 1) + # Outlier color
  scale_fill_manual(values = cols)   # Fill colors

# Legend customization
# Change the title
ggplot(df, aes(x = group, y = y, fill = group)) + 
  stat_boxplot(geom = "errorbar", width = 0.25) + 
  geom_boxplot() +
  guides(fill = guide_legend(title = "Title"))

# Change the labels
ggplot(df, aes(x = group, y = y, fill = group)) + 
  stat_boxplot(geom = "errorbar", width = 0.25) + 
  geom_boxplot() +
  scale_fill_hue(labels = c("G1", "G2", "G3"))

# Remove the legend
ggplot(df, aes(x = group, y = y, fill = group)) + 
  stat_boxplot(geom = "errorbar", width = 0.25) + 
  geom_boxplot() +
  theme(legend.position = "none")

