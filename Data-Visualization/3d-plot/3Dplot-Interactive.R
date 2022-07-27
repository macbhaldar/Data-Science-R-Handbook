# Create his3D using plot3D
hist3D_fancy(iris$Sepal.Length, iris$Petal.Width, colvar=as.numeric(iris$Species))
# Make the rgl version
library("plot3Drgl")
plotrgl()

library("car")
library("rgl")
library("mgcv")
data(iris)
head(iris)

sep.l <- iris$Sepal.Length
sep.w <- iris$Sepal.Width
pet.l <- iris$Petal.Length

# Basic 3D scatter plots
# 3D plot with the regression plane
scatter3d(x = sep.l, y = pet.l, z = sep.w)

# Change point colors and remove the regression surface:
scatter3d(x = sep.l, y = pet.l, z = sep.w,
          point.col = "blue", surface=FALSE)

# Plot the points by groups
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species)

# Remove the surfaces (grid=FALSE)
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
            grid = FALSE)

# display of the surface(s) can be changed using the argument fit. Possible values for fit are "linear", "quadratic", "smooth" and "additive"
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          grid = FALSE, fit = "smooth")

# Remove surfaces. The argument surface = FALSE is used.
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          grid = FALSE, surface = FALSE)

# Add concentration ellipsoids
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, ellipsoid = TRUE)

# Remove the grids from the ellipsoids:
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, grid = FALSE, ellipsoid = TRUE)

# Change point colors by groups
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, grid = FALSE, ellipsoid = TRUE,
          surface.col = c("#999999", "#E69F00", "#56B4E9"))

# use color palettes from the RColorBrewer package:
library("RColorBrewer")
colors <- brewer.pal(n=3, name="Dark2")
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, grid = FALSE, ellipsoid = TRUE,
          surface.col = colors)

# Change axis labels:
## The arguments xlab, ylab and zlab are used:
scatter3d(x = sep.l, y = pet.l, z = sep.w,
            point.col = "blue", surface=FALSE,
            xlab = "Sepal Length (cm)", ylab = "Petal Length (cm)",
            zlab = "Sepal Width (cm)")

# Remove axis scales (axis.scales = FALSE)
scatter3d(x = sep.l, y = pet.l, z = sep.w,
          point.col = "blue", surface=FALSE, 
          axis.scales = FALSE)

# Change axis colors
## By default, different colors are used for the 3 axes. The argument axis.col is used to specify colors for the 3 axes:
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
            surface=FALSE, grid = FALSE, ellipsoid = TRUE,
            axis.col = c("black", "black", "black"))

# Add text labels for the points
scatter3d(x = sep.l, y = pet.l, z = sep.w, 
          surface=FALSE, labels = rownames(iris), id.n=nrow(iris))
