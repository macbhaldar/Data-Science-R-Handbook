# polygon function
# Data
x <- c(1:7, 7:1)
y <- c(10, 8, 12, 8, 6, 10,
       7, 2, 1, 4, 3, 1, 4, 5)

# Line plot
plot(x, y, type = "l")

# Polygon
polygon(x, y, col = "#65BFFF")

# Points
points(x, y, pch = 19) 


# Shade the area between two lines
# Grid of X-axis values
x <- seq(0, 10, 0.01)

# Data
set.seed(1)
y1 <- 2 * cos(x) + 8
y2 <- 3 * sin(x) + 4

# Lines
plot(x, y1, type = "l",
     ylim = c(1, 10), ylab = "y")
lines(x, y2, type = "l", col = 2)

# Fill area between lines
polygon(c(x, rev(x)), c(y2, rev(y1)),
        col = "#6BD7AF") 



# Grid of X-axis values
x <- seq(0, 10, 0.01)

# Data
set.seed(1)
y1 <- 2 * cos(x) + 8
y2 <- 3 * sin(x) + 4

# Lines
plot(x, y1, type = "l",
     ylim = c(1, 10), ylab = "y")
lines(x, y2, type = "l", col = 2)

# Fill area between lines
polygon(c(x, rev(x)), c(y2, rev(y1)),
        col = "#6BD7AF", lty = 0)

# Redraw the lines
lines(x, y1, col = 1, lwd = 2)
lines(x, y2, col = 2, lwd = 2) 




# Grid of X-axis values
x <- seq(0, 10, 0.01)

# Data
set.seed(1)
y1 <- 2 * cos(x) + 8
y2 <- 3 * sin(x) + 4

# Lines
plot(x, y1, type = "l",
     ylim = c(1, 10), ylab = "y")
lines(x, y2, type = "l", col = 2)

# Area with shading lines
polygon(c(x, rev(x)), c(y2, rev(y1)),
        col = "#6BD7AF",
        density = 10, angle = 45) 


# Grid of X-axis values
x <- seq(0, 10, 0.01)

# Data
set.seed(1)
y1 <- 2 * cos(x) + 8
y2 <- 3 * sin(x) + 4

# Lines
plot(x, y1, type = "l",
     ylim = c(1, 10), ylab = "y")
lines(x, y2, type = "l", col = 2)

polygon(c(x, rev(x)), c(y2, rev(y1)),
        col = "#6BD7AF", border = 2,
        lwd = 2, lty = 2) 


# Shade a specific area between the lines
# Grid of X-axis values
x <- seq(0, 10, 0.01)

# Data
set.seed(1)
y1 <- 2 * cos(x) + 8
y2 <- 3 * sin(x) + 4

# Lines
plot(x, y1, type = "l",
     ylim = c(1, 10), ylab = "y")
lines(x, y2, type = "l", col = 2)

# Min and max X values
xmin <- 2
xmax <- 8

polygon(c(x[x >= xmin & x <= xmax],
          rev(x[x >= xmin & x <= xmax])),
        c(y2[x >= xmin & x <= xmax],
          rev(y1[x >= xmin & x <= xmax])),
        col = "#6BD7AF")

lines(x, y2, col = 2) 


# Shade the area between the curves with a continuous palette
# Grid of X-axis values
x <- seq(0, 10, 0.01)

# Data
set.seed(1)
y1 <- 2 * cos(x) + 8
y2 <- 3 * sin(x) + 4

# Lines
plot(x, y1, type = "l",
     ylim = c(1, 10), ylab = "y")
lines(x, y2, type = "l")

# Fill with palette
l <- length(x)
color <- hcl.colors(l, "TealGrn") # Palette
for (i in 1:l) {
  polygon(c(x[i], rev(x[i])),
          c(y2[i], rev(y1[i])),
          border = color[i], col = NA)
}

# Override the lines
lines(x, y1)
lines(x, y2) 
