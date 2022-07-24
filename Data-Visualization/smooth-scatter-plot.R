# Data
set.seed(9)
x <- rnorm(1000)
y <- rnorm(1000)

# Smooth scatter plot
smoothScatter(y ~ x)

# Equivalent to:
smoothScatter(x, y)

# number of points can be customized with nrpoints
smoothScatter(y ~ x,
              nrpoints = 1000)

# pch symbol
smoothScatter(y ~ x,
              pch = 10, col = "red")

# Bandwidth
smoothScatter(y ~ x, bandwidth = 0.4) # Big bandwidth
smoothScatter(y ~ x, bandwidth = 0.05) # Small bandwidth

# Smooth scatter color
palette <- hcl.colors(30, palette = "inferno")
smoothScatter(y ~ x,
              colramp = colorRampPalette(palette))
