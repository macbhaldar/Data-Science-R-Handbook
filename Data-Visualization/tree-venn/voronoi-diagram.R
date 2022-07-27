library(deldir)

# Data
set.seed(1)
x <- runif(50)
y <- runif(50)

# Calculate Voronoi Tesselation and tiles
tesselation <- deldir(x, y)
tiles <- tile.list(tesselation)

plot(tiles, pch = 19)

# Add numbers
plot(tiles, pch = 19,
     number = TRUE)

# remove the points
tesselation <- deldir(x, y)
tiles <- tile.list(tesselation)
plot(tiles,
     showpoints = FALSE)

# closed with a rectangle
tesselation <- deldir(x, y)
tiles <- tile.list(tesselation)
plot(tiles,
     close = TRUE)

# Fill and border colors
tesselation <- deldir(x, y)
tiles <- tile.list(tesselation)
plot(tiles, pch = 19,
     fillcol = hcl.colors(50, "Purple-Yellow"))

# border of the tiles
tesselation <- deldir(x, y)
tiles <- tile.list(tesselation)
plot(tiles, pch = 19,
     border = "white",
     fillcol = hcl.colors(50, "Sunset"))


# Clip shape
tesselation <- deldir(x, y)
tiles <- tile.list(tesselation)

# Circle
s <- seq(0, 2 * pi, length.out = 3000)
circle <- list(x = 0.5 * (1 + cos(s)),
               y = 0.5 * (1 + sin(s)))

plot(tiles, pch = 19,
     col.pts = "white",
     border = "white",
     fillcol = hcl.colors(50, "viridis"),
     clipp = circle)
