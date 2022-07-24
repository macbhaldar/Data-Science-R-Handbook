# Data
x <- -10:10
y <- -10:10
z <- sqrt(outer(x ^ 2, y ^ 2, "+"))

contour(x, y, z)
contour(z)

# Number of levels
contour(x, y, z,
        nlevels = 20)

# Contour lines
contour(x, y, z,
        labcex = 1.2, labels = 1:10,
        lwd = 2, lty = 1)

# Color palette
contour(volcano,
        col = cols)

# Overlay contour over a scatter plot
library(MASS)

x <- rnorm(500)
y <- rnorm(500)
z <- kde2d(x, y, n = 50)

plot(x, y, pch = 19)
contour(z, lwd = 2, add = TRUE,
        col = hcl.colors(10, "Spectral"))

# filled.contour function
filled.contour(volcano)

# Number of levels
filled.contour(volcano,
               nlevels = 10)

# Color palette
filled.contour(volcano,
               color.palette = terrain.colors)

# Filled contour with lines
filled.contour(volcano, plot.axes = {
  axis(1)
  axis(2)
  contour(volcano, add = TRUE, lwd = 2)
}
)
