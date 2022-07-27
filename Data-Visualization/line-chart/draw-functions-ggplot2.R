library(ggplot2)

ggplot() +
  xlim(c(0, 5)) +
  geom_function(fun = cos)

# Line customization
ggplot() +
  xlim(c(0, 5)) +
  geom_function(fun = cos,
                colour = "red",
                lwd = 1,
                linetype = 1)

# stat_function
ggplot() +
  xlim(c(0, 5)) +
  stat_function(fun = cos,
                geom = "point")

# Additional arguments
ggplot() +
  xlim(c(0, 50)) +
  geom_function(fun = besselJ,
                args = list(nu = 2))

# Number of points
ggplot() +
  xlim(c(0, 50)) +
  geom_function(fun = besselJ,
                n = 400,
                args = list(nu = 2))

# Overlay over existing plot
set.seed(1)
df <- data.frame(x = rnorm(200))

ggplot(df, aes(x = x)) +
  geom_density() +
  geom_function(fun = dnorm, colour = "red")

# Adding several functions
ggplot() +
  xlim(c(0, 50)) +
  geom_function(fun = besselJ, n = 400,
                aes(color = "BJ 0"),
                args = list(nu = 0)) +
  geom_function(fun = besselJ, n = 400,
                aes(color = "BJ 2"),
                args = list(nu = 2)) +
  guides(colour = guide_legend(title = ""))
