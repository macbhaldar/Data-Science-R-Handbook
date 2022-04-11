input <- mtcars[, c('wt', 'mpg')]
print(head(input))

# Get the input values.
input <- mtcars[, c('wt', 'mpg')]

# Plot the chart for cars with
# weight between 1.5 to 4 and
# mileage between 10 and 25.
plot(x = input$wt, y = input$mpg,
     xlab = "Weight",
     ylab = "Milage",
     xlim = c(1.5, 4),
     ylim = c(10, 25),	
     main = "Weight vs Milage"
)

# Plot the matrices between
# 4 variables giving 12 plots.

# One variable with 3 others
# and total 4 variables.
pairs(~wt + mpg + disp + cyl, data = mtcars,
      main = "Scatterplot Matrix")

# Loading ggplot2 package
library(ggplot2)

# Creating scatterplot with fitted values.
# An additional function stst_smooth
# is used for linear regression.
ggplot(mtcars, aes(x = log(mpg), y = log(drat))) +
  geom_point(aes(color = factor(gear))) +
  stat_smooth(method = "lm",
              col = "#C42126", se = FALSE, size = 1
  )

# Loading ggplot2 package
library(ggplot2)

# Creating scatterplot with fitted values.
# An additional function stst_smooth
# is used for linear regression.
new_graph<-ggplot(mtcars, aes(x = log(mpg),
                              y = log(drat))) +
  geom_point(aes(color = factor(gear))) +
  stat_smooth(method = "lm",
              col = "#C42126",
              se = FALSE, size = 1)

# in above example lm is used for linear regression
# and se stands for standard error.
# Adding title with dynamic name
new_graph + labs(
  title = "Relation between Mile per hours and drat",
  subtitle = "Relationship break down by gear class",
  caption = "Authors own computation"
)

# 3D Scatterplot
library(scatterplot3d)
attach(mtcars)

scatterplot3d(mpg, cyl, hp,
              main = "3D Scatterplot")

