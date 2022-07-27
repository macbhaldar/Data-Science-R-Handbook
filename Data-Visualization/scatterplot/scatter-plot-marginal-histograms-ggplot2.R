library(ggplot2)
library(ggExtra)

# Save the scatter plot in a variable
p <- ggplot(cars, aes(x = speed, y = dist)) +
  geom_point()

# Plot the scatter plot with marginal histograms
ggMarginal(p, type = "histogram")


# Horizontal marginal histogram
ggMarginal(p, type = "histogram", 
           margins = "x")

# Vertical marginal histogram
ggMarginal(p, type = "histogram", 
           margins = "y")

# Relative size
ggMarginal(p, type = "histogram", 
           size = 3)

# Bin width customization
ggMarginal(p, type = "histogram", 
           binwidth = 4)

# Density lines
ggMarginal(p, type = "densigram")

# Fill color
ggMarginal(p, type = "histogram", 
           fill = 4)

# Border color
ggMarginal(p, type = "histogram", 
           fill = "white",
           col = 4)

# Arguments for each histogram
ggMarginal(p, type = "histogram", 
           xparams = list(fill = 4),
           yparams = list(fill = 3))

# Histograms by group
cars$group <- c(rep("A", 25), rep("B", 25))

p <- ggplot(cars, aes(x = speed, y = dist, color = group)) +
  geom_point()

ggMarginal(p, type = "histogram", 
           groupColour = TRUE,
           groupFill = TRUE)
