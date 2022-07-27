library(ggplot2)
library(ggbeeswarm)

set.seed(1995)
y <- round(rnorm(200), 1)

df <- data.frame(y = y, 
                 group = sample(c("G1", "G2", "G3"), 
                                size = 200, 
                                replace = TRUE))

ggplot(df, aes(x = group, y = y)) + 
  geom_beeswarm()


# size and scaling
ggplot(df, aes(x = group, y = y)) + 
  geom_beeswarm(cex = 3)

# color by group
ggplot(df, aes(x = group, y = y, color = group)) + 
  geom_beeswarm(cex = 3)

# Change the color
ggplot(df, aes(x = group, y = y, color = group)) + 
  geom_beeswarm(cex = 3) + 
  scale_color_brewer(palette = "Set1")

# priority methods
ggplot(df, aes(x = group, y = y, color = group)) + 
  geom_beeswarm(cex = 3, 
                priority = "density")  # "descending", "density", "random", "none"

# Adding quasi-random noise
ggplot(df, aes(x = group, y = y)) + 
  geom_quasirandom()

# Color by grouping
ggplot(df, aes(x = group, y = y, color = group)) + 
  geom_quasirandom()

# Methods
ggplot(df, aes(x = group, y = y)) + 
  geom_quasirandom(method = "pseudorandom")  # "smilet", "frowney"
