library(plotrix)

data <- c(19, 21, 54, 12, 36, 12)

pie3D(data) 

# Radius (width)
pie3D(data,
      radius = 0.75)

# Height
pie3D(data,
      height = 0.2)

# Angle
pie3D(data,
      theta = 1.5)

# color of the pie slices
pie3D(data,
      col = hcl.colors(length(data), "Spectral"))

# order color
pie3D(data,
      col = hcl.colors(length(data), "Spectral"),
      border = "white")

# shade of the border of the pie
pie3D(data,
      col = hcl.colors(length(data), "Spectral"),
      shade = 0.5)

# pie3D labels
pie3D(data,
      col = hcl.colors(length(data), "Spectral"),
      labels = data)

# percentages labels
data <- c(19, 21, 54, 12, 36, 12)
lab <- paste0(round(data/sum(data) * 100, 2), "%")
pie3D(data,
      col = hcl.colors(length(data), "Spectral"),
      labels = lab)

# color and size of the labels
pie3D(data,
      col = hcl.colors(length(data), "Spectral"),
      labels = data,
      labelcol = "red",
      labelcex = 0.75)

# Explode pie
pie3D(data, mar = rep(1.75, 4),
      col = hcl.colors(length(data), "Spectral"),
      labels = data,
      explode = 0.2)
