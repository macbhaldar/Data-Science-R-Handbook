# Brownian motion
set.seed(1)

# Grid
t <- seq(0, 1, by = 0.001)
p <- length(t) - 1

# 10 paths
n <- 10
I <- matrix(rnorm(n * p, 0, 1 / sqrt(p)), n, p)

# Matrix
B <- apply(I, 1, cumsum)


# matplot function
matplot(B, type = "l")

# Equivalent to:
matplot(as.data.frame(B), type = "l")

# Equivalent to:
matplot(matrix(t), rbind(rep(0, n), B), type = "l")


# Colors
cols <- hcl.colors(10, "Temps")

matplot(B, type = "l",
        col = cols, # Colors
        lwd = 2,    # Line width
        lty = 1)    # Line type 


# matlines function
matplot(B, type = "l",
        col = "lightgray",
        lty = 1)

# Highlight the first three columns
# with a different color
matlines(B[, 1:3], type = "l",
         col = 2, lwd = 2,
         lty = 1)
