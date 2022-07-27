set.seed(5)
x <- rnorm(400)

# Histogram
hist(x, prob = TRUE)

# Box plot over an histogram
# Histogram
hist(x, prob = TRUE,
     col = "white",
     main = "")

# Add new plot
par(new = TRUE)

# Box plot
boxplot(x, horizontal = TRUE, axes = FALSE,
        col = rgb(0, 0.8, 1, alpha = 0.5))

# Box around the plots
box()
