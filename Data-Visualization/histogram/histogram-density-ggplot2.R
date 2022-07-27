library(ggplot2)

# Data
set.seed(5)
x <- rnorm(1000)
df <- data.frame(x)

# Histogram with kernel density
ggplot(df, aes(x = x)) + 
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white") +
  geom_density()

# Curve customization
ggplot(df, aes(x = x)) + 
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white") +
  geom_density(lwd = 1.2,
               linetype = 2,
               colour = 2)

# Density curve with shaded area
ggplot(df, aes(x = x)) + 
  geom_histogram(aes(y = ..density..),
                 colour = 1, fill = "white") +
  geom_density(lwd = 1, colour = 4,
               fill = 4, alpha = 0.25)
