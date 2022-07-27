set.seed(3)
x <- rnorm(200)

# Histogram
hist(x, prob = TRUE)

# Histogram with normal curve

# X-axis grid
x2 <- seq(min(x), max(x), length = 40)

# Normal curve
fun <- dnorm(x2, mean = mean(x), sd = sd(x))

# Histogram
hist(x, prob = TRUE, col = "white",
     ylim = c(0, max(fun)),
     main = "Histogram with normal curve")
lines(x2, fun, col = 2, lwd = 2)


# Histogram with density line
hist(x, prob = TRUE, ylim = c(0, max(fun)),
     main = "Histogram with density curve")
lines(density(x), col = 4, lwd = 2)
