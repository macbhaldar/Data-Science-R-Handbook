# Data
set.seed(1)
x <- runif(400)
y <- runif(400)

# Scatter plot
plot(x, y)

library(plotrix)

# Data
set.seed(1)
x <- runif(400)
y <- runif(400)

# Scatter plot with zoom
zoomInPlot(x, y,                # Data
           rxlim = c(0.6, 0.8), # X-axis limits
           rylim = c(0.4, 0.6)) # Y-axis limits

# Color customization
zoomInPlot(x, y,                    # Data
           pch = 19,                # Symbol
           col = 4,                 # Color
           zoomtitle = "Zoom plot", # Title
           rxlim = c(0.6, 0.8),
           rylim = c(0.4, 0.6))
