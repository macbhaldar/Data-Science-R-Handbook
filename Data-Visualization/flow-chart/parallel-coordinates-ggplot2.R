library(GGally)

iris

ggparcoord(data = iris)

# Selecting columns
ggparcoord(data = iris,
           columns = 1:4)

# Transparency of the lines
ggparcoord(data = iris, 
           columns = 1:4,
           alphaLines = 0.2)

# Color by group
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species")

# Color customization
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species") +
  scale_color_brewer(palette = "Set2")

# Adding points
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           showPoints = TRUE) +
  scale_color_brewer(palette = "Set2")

# Spline interpolation
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           splineFactor = TRUE) +
  scale_color_brewer(palette = "Set2") 

# Adding box plots
ggparcoord(data = iris,
           columns = 1:4,
           alphaLines = 0.2,
           showPoints = TRUE,
           boxplot = TRUE)

# add a box from the maximum to the minimun for each variable
ggparcoord(data = iris,
           columns = 1:4,
           alphaLines = 0.2,
           showPoints = TRUE,
           boxplot = TRUE,
           shadeBox = 4)

# Scaling methods
# “robust” scale
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           scale = "robust") +
  scale_color_brewer(palette = "Set2")

# “uniminmax” scale
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           scale = "uniminmax") +
  scale_color_brewer(palette = "Set2") 

# “globalminmax” scale (no scaling)
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           scale = "globalminmax") +
  scale_color_brewer(palette = "Set2") 

# “center” scale
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           scale = "center") +
  scale_color_brewer(palette = "Set2")

# “centerObs” scale
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           scale = "centerObs") +
  scale_color_brewer(palette = "Set2")

# Ordering methods

# “anyClass” order 
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           order = "anyClass") +
  scale_color_brewer(palette = "Set2")

# “allClass” order
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           order = "allClass") +
  scale_color_brewer(palette = "Set2")

# “skewness” order
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           order = "skewness") +
  scale_color_brewer(palette = "Set2")

# “Outlying” order 
ggparcoord(data = iris,
           columns = 1:4,
           groupColumn = "Species",
           order = "Outlying") +
  scale_color_brewer(palette = "Set2")

# install.packages('scagnostics')

# Parallel coordinates for each group
ggparcoord(data = iris,
           columns = 1:4,
           alphaLines = 0.2,
           boxplot = TRUE,
           groupColumn = "Species",
           order = "Outlying") +
  scale_color_brewer(palette = "Set2") + facet_wrap(~ Species)
