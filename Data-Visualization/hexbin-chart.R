library(hexbin)

# Data
set.seed(1)
x <- rnorm(5000)
y <- rnorm(5000)

hex <- hexbin(x, y)
plot(hex)

# Number of bins
hex <- hexbin(x, y, xbins = 20)
plot(hex)

# Color customization

# Border color
hex <- hexbin(x, y)
plot(hex, border = 4)

# Color palette
hex <- hexbin(x, y)
plot(hex, colramp = colorRampPalette(hcl.colors(12)))

# Legend
# Legend width
hex <- hexbin(x, y)
plot(hex, legend = 0.9)

# Text size of the legend
hex <- hexbin(x, y)
plot(hex, lcex = 0.9)

# Remove the legend
hex <- hexbin(x, y)
plot(hex, legend = FALSE,
     colramp = colorRampPalette(hcl.colors(12, "GnBu")))
