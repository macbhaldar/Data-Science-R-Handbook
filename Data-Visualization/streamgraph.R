set.seed(1)
m <- 500
n <- 30
x <- seq(m)
y <- matrix(0, nrow = m, ncol = n)
colnames(y) <- seq(n)
for(i in seq(ncol(y))) {
  mu <- runif(1, min = 0.25 * m, max = 0.75 * m)
  SD <- runif(1, min = 5, max = 20)
  TMP <- rnorm(1000, mean = mu, sd = SD)
  HIST <- hist(TMP, breaks = c(0, x), plot = FALSE)
  fit <- smooth.spline(HIST$counts ~ HIST$mids)
  y[, i] <- fit$y
}
y <- replace(y, y < 0.01, 0)


# Stream visualization plot
library(sinkr)

# Streamgraph
set.seed(1)
plotStream(x, y,
           xlim = c(100, 400),
           ylim = c(-125, 125))

# Wiggle
plotStream(x, y,
           xlim = c(100, 400),
           ylim = c(-125, 125),
           frac.rand = 0.2,
           spar = 0.5)

# Color palette
cols <- hcl.colors(30, "BluYl")
set.seed(1)
plotStream(x, y,
           xlim = c(100, 400),
           ylim = c(-125, 125),
           col = cols)

# Border customization
plotStream(x, y, xlim = c(100, 400),
           ylim = c(-125, 125),
           col = hcl.colors(30, "Blues 3"),
           border = "white", lwd = 1, lty = 1)

# Order methods
# “max” order method
plotStream(x, y, xlim = c(100, 400),
           ylim = c(-125, 125),
           col = hcl.colors(30, "Blues 3"),
           order.method = "max")

# “first” order method
plotStream(x, y, xlim = c(100, 400),
           ylim = c(-125, 125),
           col = hcl.colors(30, "Blues 3"),
           order.method = "first")
