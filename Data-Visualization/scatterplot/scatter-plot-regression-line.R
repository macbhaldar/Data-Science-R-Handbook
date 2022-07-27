# Data. Model: Y = X ^ 2
set.seed(54)
x <- seq(0, 10, by = 0.05)
y <- x ^ 2 + rnorm(length(x), sd = 20)

# Scatter plot and underlying model
plot(x, y, pch = 16)
lines(x, x ^ 2, col = 2, lwd = 3)

# Text
text(2, 70, expression(Y == X ^ 2)) 

# Scatter plot with linear regression
plot(x, y, pch = 16)
abline(lm(y ~ x), col = 4, lwd = 3)

# Text
coef <- round(coef(lm(y ~ x)), 2)
text(2, 70,  paste("Y = ", coef[1], "+", coef[2], "x"))


# Scatter plot with LOWESS regression curve
plot(x, y, pch = 16)
lines(lowess(x, y), col = 3, lwd = 3)
