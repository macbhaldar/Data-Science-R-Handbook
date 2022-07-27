# Data
x <- c(1, 2, 3, 4, 5, 4, 7, 8, 9)
y <- c(12, 16, 14, 18, 16, 13, 15, 20, 22)

# Connected scatter plot
plot(x, y, type = "b",
     xlab = "Var 1", ylab = "Var 2")

# Symbol
plot(x, y,
     type = "b", pch = 18,
     xlab = "Var 1", ylab = "Var 2")

# Custom points and color
plot(x, y, type = "b", 
     pch = 19, col = 4,
     xlab = "Var 1", ylab = "Var 2")
points(x, y, pch = 19)

# Adding text
plot(x, y, type = "b", 
     xlim = c(1, 10), ylim = c(12, 23),
     pch = 19, col = 4,
     xlab = "Var 1", ylab = "Var 2")
text(x + 0.7, y + 0.4, labels)

# Connected scatter plot with arrows
conArrows <- function(x, y, ...) {
  plot(x, y, pch = "", ...)
  invisible(sapply(1:length(x),
                   function(i) arrows(x[i], y[i],
                                      x[i + 1], y[i + 1], ...)))}

conArrows(x, y)

conArrows(x, y, angle = 20, length = 0.15, col = 4)
