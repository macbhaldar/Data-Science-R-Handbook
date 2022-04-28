library("plot3D")

data(iris)
head(iris)

# x, y and z coordinates
x <- sep.l <- iris$Sepal.Length
y <- pet.l <- iris$Petal.Length
z <- sep.w <- iris$Sepal.Width

# Basic scatter plot
scatter3D(x, y, z, clab = c("Sepal", "Width (cm)"))

scatter3D(x, y, z, colvar = NULL, col = "blue",
          pch = 19, cex = 0.5)
# colvar = NULL: avoids coloring by z variable
# col = "blue": changes point colors to blue
# pch = 19: changes point shapes
# cex = 0.5: changes the size of points

# Change the type of the box around the plot

# full box
scatter3D(x, y, z, bty = "f", colkey = FALSE, main ="bty= 'f'")
# back panels and grid lines are visible
scatter3D(x, y, z, bty = "b2", colkey = FALSE, main ="bty= 'b2'" )

## "f": full box
## "b": default value. Only the back panels are visible
## "b2": back panels and grid lines are visible
## "g": grey background with white grid lines
## "bl": black background
## "bl2": black background with grey lines
## "u": means that the user will specify the arguments col.axis, col.panel, lwd.panel, col.grid, lwd.grid manually
## "n": no box will be drawn. This is the same as setting box = FALSE

# Color palettes

# gg.col: ggplot2 like color
scatter3D(x, y, z, bty = "g", pch = 18, col = gg.col(100))
# ramp.col: custom palettes
scatter3D(x, y, z, bty = "g", pch = 18,
          col = ramp.col(c("blue", "yellow", "red")) )

## jet.col(n, alpha): generates the matlab-type colors. This is the default color palette used in plot3D
## jet2.col(n, alpha): similar to jet.col() but lacks the deep blue colors
## gg.col(n, alpha) and gg2.col(n, alpha) generates gg-plot-like colors
## ramp.col(col = c("grey", "black"), n, alpha): creates color schemes by interpolation
## alpha.col(col = "grey", alpha): creates transparent colors

## n: Number of colors to generate. Default value is 100
## alpha: color transparency. Value in the range 0, 1. Default value is 1
## col: Colors to interpolate


# Change the color by groups (colkey)

scatter3D(x, y, z, bty = "g", pch = 18, 
          col.var = as.integer(iris$Species), 
          col = c("#1B9E77", "#D95F02", "#7570B3"),
          pch = 18, ticktype = "detailed",
          colkey = list(at = c(2, 3, 4), side = 1, 
                        addlines = TRUE, length = 0.5, width = 0.5,
                        labels = c("setosa", "versicolor", "virginica")) )

# Change the position of the legend (Bottom colkey)
scatter3D(x, y, z, bty = "g",
          colkey = list(side = 1, length = 0.5))

# 3D viewing direction
## The arguments theta and phi can be used to define the angles for the viewing direction. theta is the azimuthal direction and phi the co-latitude.
scatter3D(x, y, z, theta = 15, phi = 20)
scatter3D(x, y, z, phi = 0, bty ="g")

# Titles and axis labels
scatter3D(x, y, z, pch = 18,  theta = 20, phi = 20,
          main = "Iris data", xlab = "Sepal.Length",
          ylab ="Petal.Length", zlab = "Sepal.Width")

# Tick marks and labels
scatter3D(x, y, z, phi = 0, bty = "g",
          pch = 20, cex = 2, ticktype = "detailed")

## ticktype: Possible values are
## "simple" draws just an arrow parallel to the axis to indicate direction of increase
## "detailed" draws normal ticks and labels
## nticks: the number of tick marks to draw on the axes. It has no effect if ticktype ="simple".

# Add points and text to an existing plot
# Create a scatter plot
scatter3D(x, y, z, phi = 0, bty = "g",
          pch = 20, cex = 2, ticktype = "detailed")
# Add another point (black color)
scatter3D(x = 7, y = 3, z = 3.5, add = TRUE, colkey = FALSE, 
          pch = 18, cex = 3, col = "black")

# Add texts to an existing plot:
# Create a scatter plot
scatter3D(x, y, z, phi = 0, bty = "g", pch = 20, cex = 0.5)
# Add text
text3D(x, y, z,  labels = rownames(iris),
       add = TRUE, colkey = FALSE, cex = 0.5)

# Line plots
# type ="l" for lines only
scatter3D(x, y, z, phi = 0, bty = "g", type = "l", 
          ticktype = "detailed", lwd = 4)

# type ="b" for both points and lines
scatter3D(x, y, z, phi = 0, bty = "g", type = "b", 
          ticktype = "detailed", pch = 20, 
          cex = c(0.5, 1, 1.5))

# type ="h" for vertical lines
scatter3D(x, y, z, phi = 0, bty = "g",  type = "h", 
          ticktype = "detailed", pch = 19, cex = 0.5)


# Add confidence interval

# Confidence interval
CI <- list(z = matrix(nrow = length(x),
                      data = rep(0.1, 2*length(x))))
head(CI$z)

# 3D Scatter plot with CI
scatter3D(x, y, z, phi = 0, bty = "g", col = gg.col(100), 
          pch = 18, CI = CI)

# 3D fancy Scatter plot with small dots on basal plane
## A helper function scatter3D_fancy() is used:

# Add small dots on basal plane and on the depth plane
scatter3D_fancy <- function(x, y, z,..., colvar = z)
{
  panelfirst <- function(pmat) {
    XY <- trans3D(x, y, z = rep(min(z), length(z)), pmat = pmat)
    scatter2D(XY$x, XY$y, colvar = colvar, pch = ".", 
              cex = 2, add = TRUE, colkey = FALSE)
    
    XY <- trans3D(x = rep(min(x), length(x)), y, z, pmat = pmat)
    scatter2D(XY$x, XY$y, colvar = colvar, pch = ".", 
              cex = 2, add = TRUE, colkey = FALSE)
  }
  scatter3D(x, y, z, ..., colvar = colvar, panel.first=panelfirst,
            colkey = list(length = 0.5, width = 0.5, cex.clab = 0.75)) 
}

# Fancy scatter plot:
scatter3D_fancy(x, y, z, pch = 16,
                ticktype = "detailed", theta = 15, d = 2,
                main = "Iris data",  clab = c("Petal", "Width (cm)") )

# Regression plane

data(mtcars)
head(mtcars[, 1:6])

# Use the function lm() to compute a linear regression model: ax + by + cz + d = 0
# Use the argument surf in scatter3D() function to add a regression surface.
# x, y, z variables
x <- mtcars$wt
y <- mtcars$disp
z <- mtcars$mpg
# Compute the linear regression (z = ax + by + d)
fit <- lm(z ~ x + y)
# predict values on regular xy grid
grid.lines = 26
x.pred <- seq(min(x), max(x), length.out = grid.lines)
y.pred <- seq(min(y), max(y), length.out = grid.lines)
xy <- expand.grid( x = x.pred, y = y.pred)
z.pred <- matrix(predict(fit, newdata = xy), 
                 nrow = grid.lines, ncol = grid.lines)
# fitted points for droplines to surface
fitpoints <- predict(fit)
# scatter plot with regression plane
scatter3D(x, y, z, pch = 18, cex = 2, 
          theta = 20, phi = 20, ticktype = "detailed",
          xlab = "wt", ylab = "disp", zlab = "mpg",  
          surf = list(x = x.pred, y = y.pred, z = z.pred,  
                      facets = NA, fit = fitpoints), main = "mtcars")

# text3D: plot 3-dimensionnal texts (text3D()):
text3D(x, y, z, labels, ...)

data(USArrests)
with(USArrests, text3D(Murder, Assault, Rape, 
                       labels = rownames(USArrests), colvar = UrbanPop, 
                       col = gg.col(100), theta = 60, phi = 20,
                       xlab = "Murder", ylab = "Assault", zlab = "Rape", 
                       main = "USA arrests", cex = 0.6, 
                       bty = "g", ticktype = "detailed", d = 2,
                       clab = c("Urban","Pop"), adj = 0.5, font = 2))

# text3D and scatter3D
# Plot texts
with(USArrests, text3D(Murder, Assault, Rape, 
                       labels = rownames(USArrests), colvar = UrbanPop, 
                       col = gg.col(100), theta = 60, phi = 20,
                       xlab = "Murder", ylab = "Assault", zlab = "Rape", 
                       main = "USA arrests", cex = 0.6, 
                       bty = "g", ticktype = "detailed", d = 2,
                       clab = c("Urban","Pop"), adj = 0.5, font = 2))
# Add points
with(USArrests, scatter3D(Murder, Assault, Rape - 1, 
                          colvar = UrbanPop, col = gg.col(100), 
                          type = "h", pch = ".", add = TRUE))

# Zoom near origin: choose suitable ranges
plotdev(xlim = c(0, 10), ylim = c(40, 150), 
        zlim = c(7, 25))


# 3D Histogram

data(VADeaths)
#  hist3D and ribbon3D with greyish background, rotated, rescaled,...
hist3D(z = VADeaths, scale = FALSE, expand = 0.01, bty = "g", phi = 20,
       col = "#0072B2", border = "black", shade = 0.2, ltheta = 90,
       space = 0.3, ticktype = "detailed", d = 2)

hist3D (x = 1:5, y = 1:4, z = VADeaths,
        bty = "g", phi = 20,  theta = -60,
        xlab = "", ylab = "", zlab = "", main = "VADeaths",
        col = "#0072B2", border = "black", shade = 0.8,
        ticktype = "detailed", space = 0.15, d = 2, cex.axis = 1e-9)
# Use text3D to label x axis
text3D(x = 1:5, y = rep(0.5, 5), z = rep(3, 5),
       labels = rownames(VADeaths),
       add = TRUE, adj = 0)
# Use text3D to label y axis
text3D(x = rep(1, 4),   y = 1:4, z = rep(0, 4),
       labels  = colnames(VADeaths),
       add = TRUE, adj = 1)

# fancy 3D histograms
hist3D_fancy<- function(x, y, break.func = c("Sturges", "scott", "FD"), breaks = NULL,
                        colvar = NULL, col="white", clab=NULL, phi = 5, theta = 25, ...){
  
# Compute the number of classes for a histogram
  break.func <- break.func [1]
  if(is.null(breaks)){
    x.breaks <- switch(break.func,
                       Sturges = nclass.Sturges(x),
                       scott = nclass.scott(x),
                       FD = nclass.FD(x))
    y.breaks <- switch(break.func,
                       Sturges = nclass.Sturges(y),
                       scott = nclass.scott(y),
                       FD = nclass.FD(y))
  } else x.breaks <- y.breaks <- breaks
  
  # Cut x and y variables in bins for counting
  x.bin <- seq(min(x), max(x), length.out = x.breaks)
  y.bin <- seq(min(y), max(y), length.out = y.breaks)
  xy <- table(cut(x, x.bin), cut(y, y.bin))
  z <- xy
  
  xmid <- 0.5*(x.bin[-1] + x.bin[-length(x.bin)])
  ymid <- 0.5*(y.bin[-1] + y.bin[-length(y.bin)])
  
  oldmar <- par("mar")
  par (mar = par("mar") + c(0, 0, 0, 2))
  hist3D(x = xmid, y = ymid, z = xy, ...,
         zlim = c(-max(z)/2, max(z)), zlab = "counts", bty= "g", 
         phi = phi, theta = theta,
         shade = 0.2, col = col, border = "black",
         d = 1, ticktype = "detailed")
  
  scatter3D(x, y,
            z = rep(-max(z)/2, length.out = length(x)),
            colvar = colvar, col = gg.col(100),
            add = TRUE, pch = 18, clab = clab,
            colkey = list(length = 0.5, width = 0.5,
                          dist = 0.05, cex.axis = 0.8, cex.clab = 0.8)
  )
  par(mar = oldmar)
}

hist3D_fancy(quakes$long, quakes$lat, colvar=quakes$depth,
             breaks =30)

hist3D_fancy(iris$Sepal.Length, iris$Petal.Width, 
             colvar=as.numeric(iris$Species))

# 3D rectangle: the R code below creates a rectangle with a transparent fill color (alpha = 0.5)
rect3D(x0 = 0, y0 = 0.5, z0 = 0, x1 = 1, z1 = 5, 
       ylim = c(0, 1), bty = "g", facets = TRUE, 
       border = "red", col ="#7570B3", alpha=0.5,
       lwd = 2, phi = 20)

