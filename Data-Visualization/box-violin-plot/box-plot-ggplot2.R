library(ggplot2)

# Data
set.seed(3)
y <- rnorm(500)
df <- data.frame(y)

# Basic box plot
ggplot(df, aes(y = y)) + 
  geom_boxplot()

# set x = "". 
# remove the values of the X axis and make the box plot thinner.
ggplot(df, aes(x = "", y = y)) + 
  geom_boxplot()

# Adding error bars (whiskers)
ggplot(df, aes(y = y)) + 
  stat_boxplot(geom = "errorbar",
               width = 0.15) + 
  geom_boxplot()

# Horizontal box plot

# Option 1: changing the argument
ggplot(df, aes(x = y)) + 
  stat_boxplot(geom = "errorbar",
               width = 0.15) + 
  geom_boxplot()

# Option 2: using coord_flip
ggplot(df, aes(y = y)) + 
  stat_boxplot(geom = "errorbar",
               width = 0.15) + 
  geom_boxplot() +
  coord_flip()

# Colors customization
ggplot(df, aes(y = y)) + 
  stat_boxplot(geom = "errorbar",
               width = 0.15,
               color = 1) +  # Error bar color
  geom_boxplot(fill = 2,           # Box color
               alpha = 0.5,        # Transparency
               color = 1,          # Border color
               outlier.colour = 2) # Outlier color

# Lines customization
ggplot(df, aes(y = y)) + 
  stat_boxplot(geom = "errorbar",
               width = 0.15,
               linetype = 2, # Line type
               lwd = 0.5) +  # Line width
  geom_boxplot(linetype = 2, # Line type
               lwd = 0.5)    # Line width
