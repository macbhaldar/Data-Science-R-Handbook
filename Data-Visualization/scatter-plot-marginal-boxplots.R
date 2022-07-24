library(car)

# Data
set.seed(14022021)
x <- rnorm(300)
y <- 3 * x + rnorm(300) 

scatterplot(x, y,            # Data
            pch = 19,        # Symbol of the points
            col = 1,         # Color of the points
            smooth = FALSE,  # Remove smooth estimate
            regLine = FALSE) # Remove linear estimate

# box plot for the X-axis 
scatterplot(x, y,            # Data
            boxplots = "x",  # Box plot on the X-axis
            pch = 19,        # Symbol of the points
            col = 1,         # Color of the points
            smooth = FALSE,  # Remove smooth estimate
            regLine = FALSE) # Remove linear estimate

# box plot for the Y-axis 
scatterplot(x, y,            # Data
            boxplots = "y",  # Box plot on the Y-axis
            pch = 19,        # Symbol of the points
            col = 1,         # Color of the points
            smooth = FALSE,  # Remove smooth estimate
            regLine = FALSE) # Remove linear estimate


# Using the layout function
layout(matrix(c(2, 0, 1, 3),
              nrow = 2, ncol = 2,
              byrow = TRUE),
       widths = c(3, 1),
       heights  = c(1, 3), respect = TRUE)

# Top and right margin of the main plot
par(mar = c(5.1, 4.1, 0, 0))
plot(x, y, pch = 19, col = 1, cex = 0.8)

# Left margin of the top box plot
par(mar = c(0, 4.1, 0, 0), bty = "n")
boxplot(y, axes = FALSE, horizontal = TRUE,
        col = "white")

# Bottom margin of the right box plot
par(mar = c(5.1, 0, 0, 0), bty = "n")
boxplot(x, axes = FALSE, col = "white")
