library("car")
library("rgl")

data(iris)
head(iris)
sep.l <- iris$Sepal.Length
sep.w <- iris$Sepal.Width
pet.l <- iris$Petal.Length

scatter3d(formula, data)
scatter3d(x, y, z)

library(car)

scatter3d(x = sep.l, y = pet.l, z = sep.w)

scatter3d(x = sep.l, y = pet.l, z = sep.w,
          point.col = "blue", surface=FALSE)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          grid = FALSE)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          grid = FALSE, fit = "smooth")

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          grid = FALSE, surface = FALSE)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, ellipsoid = TRUE)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, grid = FALSE, ellipsoid = TRUE)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, grid = FALSE, ellipsoid = TRUE,
          surface.col = c("#999999", "#E69F00", "#56B4E9"))

library("RColorBrewer")
colors <- brewer.pal(n=3, name="Dark2")
scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, grid = FALSE, ellipsoid = TRUE,
          surface.col = colors)

scatter3d(x = sep.l, y = pet.l, z = sep.w,
          point.col = "blue", surface=FALSE,
          xlab = "Sepal Length (cm)", ylab = "Petal Length (cm)",
          zlab = "Sepal Width (cm)")

scatter3d(x = sep.l, y = pet.l, z = sep.w,
          point.col = "blue", surface=FALSE,
          axis.scales = FALSE)

scatter3d(x = sep.l, y = pet.l, z = sep.w, groups = iris$Species,
          surface=FALSE, grid = FALSE, ellipsoid = TRUE,
          axis.col = c("black", "black", "black"))

scatter3d(x = sep.l, y = pet.l, z = sep.w,
          surface=FALSE, labels = rownames(iris), id.n=nrow(iris))

rgl.snapshot(filename = "plot.png")

rgl.postscript("plot.pdf",fmt="pdf")