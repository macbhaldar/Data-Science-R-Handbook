dat <- as.data.frame(EuStockMarkets[, 1:2])

dat <- as.data.frame(EuStockMarkets[, 1:2])

# First column
y <- dat[, 1]

# Area chart
plot(y, type = "l")

polygon(c(1, seq(y), length(y)), c(0, y, 0),
        col = rgb(0.53, 0.79, 0.88, alpha = 0.5))

# Almost equivalent to:
# install.packages("areaplot")
library(areaplot)

areaplot(y, col = rgb(0.53, 0.79, 0.88, alpha = 0.5))

# Area chart of several variables
dat <- as.data.frame(EuStockMarkets[, 1:2])

# Second variable (because it is higher)
y1 <- dat$SMI

# Plot
plot(y1, type = "l", ylim = c(0, max(dat)))

polygon(c(1, seq(y1), length(y1)), c(0, y1, 0),
        col = "#E0F2F1")

# First variable
y2 <- dat$DAX

# Adding the line
lines(y2, type = "l")
polygon(c(1, seq(y2), length(y2)), c(0, y2, 0),
        col = "#4DB6AC")
