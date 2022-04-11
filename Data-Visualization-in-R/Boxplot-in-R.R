input <- mtcars[, c('mpg', 'cyl')]
print(head(input))

# Plot the chart.
boxplot(mpg ~ cyl, data = mtcars,
        xlab = "Number of Cylinders",
        ylab = "Miles Per Gallon",
        main = "Mileage Data")

set.seed(20000)									
data <- data.frame( A = rpois(900, 3),
                    B = rnorm(900),
                    C = runif(900)
                    
                    
)

# Applying boxplot function
boxplot(data)

# Plot the chart.
boxplot(mpg ~ cyl, data = mtcars,
        xlab = "Number of Cylinders",
        ylab = "Miles Per Gallon",
        main = "Mileage Data",
        notch = TRUE,
        varwidth = TRUE,
        col = c("green", "red", "blue"),
        names = c("High", "Medium", "Low")
)

