# x, y coordinates
set.seed(1234)
x  <- sort(rnorm(10)) 
y  <- runif(10)
# Variable for coloring points
col.v <- sqrt(x^2 + y^2)

scatter2D(x, y, colvar = col.v, pch = 16, bty ="n",
          type ="b")

# type: plot types. Allowed values are:
## "b" to draw both points and line
## "h" for vertical line
## "l" for line only
## "p" for points only
# bty: box type

# 2D scatter plot with confidence interval:
# Confidence interval for x variable only
CI <- list()
CI$x <- matrix(nrow = length(x), data = c(rep(0.25, 2*length(x))))
scatter2D(x, y, colvar = col.v, pch = 16, bty ="n", cex = 1.5, 
          CI = CI, type = "b")

# Confidence interval for both x and y variables
CI$y <- matrix (nrow = length(y), data = c(rep(0.05, 2*length(y))))
CI$col <- "black"
scatter2D(x, y, colvar = col.v, pch = 16,  bty ="n", cex = 1.5,
          CI = CI, type ="b")

CI$y[c(2,4,8,10), ] <- NA  # Some points have no CI
CI$x[c(2,4,8,10), ] <- NA  # Some points have no CI
CI$alen <- 0.02            # increase arrow head
scatter2D(x, y, colvar = col.v, pch = 16,  bty ="n", cex = 1.5,
          CI = CI, type ="b")

# text2D
# Only text
with(USArrests, text2D(x = Murder, y = Assault + 5, colvar = Rape, 
                       xlab = "Murder", ylab = "Assault", clab = "Rape", 
                       main = "USA arrests", labels = rownames(USArrests), cex = 0.6, 
                       adj = 0.5, font = 2))

# text with point
with(USArrests, text2D(x = Murder, y = Assault + 5, colvar = Rape, 
                       xlab = "Murder", ylab = "Assault", clab = "Rape", 
                       main = "USA arrests", labels = rownames(USArrests), cex = 0.6, 
                       adj = 0.5, font = 2))
with(USArrests, scatter2D(x = Murder, y = Assault, colvar = Rape, 
                          pch = 16, add = TRUE, colkey = FALSE))

# 3D Arrows
x0 <- c(0, 0, 0, 0)
y0 <- c(0, 0, 0, 0)
z0 <- c(0, 0, 0, 0)
x1 <- c(0.89, -0.46, 0.99, 0.96)
y1 <- c(0.36,  0.88, 0.02, 0.06)
z1 <- c(-0.28, 0.09, 0.05, 0.24)
cols <- c("#1B9E77", "#D95F02", "#7570B3", "#E7298A")

arrows3D(x0, y0, z0, x1, y1, z1, colvar = x1^2, col = cols,
         lwd = 2, d = 3, clab = c("Quality", "score"), 
         main = "Arrows 3D", bty ="g", ticktype = "detailed")
# Add starting point of arrow
points3D(x0, y0, z0, add = TRUE, col="darkred", 
         colkey = FALSE, pch = 19, cex = 1)
# Add labels to the arrows
text3D(x1, y1, z1, c("Sepal.L", "Sepal.W", "Petal.L", "Petal.W"),
       colvar = x1^2, col = cols, add=TRUE, colkey = FALSE)

# 2D arrows:
arrows2D(x0, y0,  x1, y1,  colvar = x1^2, col = cols,
           lwd = 2, clab = c("Quality", "score"), 
           bty ="n", xlim = c(-1, 1), ylim = c(-1, 1))
# Add vertical and horizontal lines at c(0,0)
abline(h =0, v = 0, lty = 2)
# Add starting point of arrow
points2D(x0, y0, add = TRUE, col="darkred", 
         colkey = FALSE, pch = 19, cex = 1)
# Add labels to the arrows
text2D(x1, y1, c("Sepal.L", "Sepal.W", "Petal.L", "Petal.W"),
       colvar = x1^2, col = cols, add=TRUE, colkey = FALSE)

# 2D rectangle:
rect2D(x0 = runif(3), y0 = runif(3), 
         x1 = runif(3), y1 = runif(3), colvar = 1:3, 
         alpha = 0.4, lwd = 2, main = "rect2D")
