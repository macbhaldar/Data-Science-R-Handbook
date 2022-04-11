# Create the data for the chart.
v <- c(4, 5, 12, 18, 20, 22, 23, 24)

# Plot the bar chart.
plot(v, type = "o")

# Create the data for the chart.
v <- c(4, 5, 12, 18, 20, 22, 23, 24)

# Plot the bar chart.
plot(v, type = "o", col = "blue",
     xlab = "Month", ylab = "Article Written",
     main = "Article Written chart")

# Create the data for the chart.
v <- c(17, 25, 38, 13, 41)
t <- c(22, 19, 36, 19, 23)
m <- c(25, 14, 16, 34, 29)

# Plot the bar chart.
plot(v, type = "o", col = "red",
     xlab = "Month", ylab = "Article Written ",
     main = "Article Written chart")

lines(t, type = "o", col = "blue")
lines(m, type = "o", col = "green")

# Create the data for the chart
A <- c(17, 32, 8, 53, 1)

# Plot the bar chart
barplot(A, xlab = "X-axis", ylab = "Y-axis", main ="Bar-Chart")

# Create the data for the chart
A <- c(17, 32, 8, 53, 1)

# Plot the bar chart
barplot(A, horiz = TRUE, xlab = "X-axis",
        ylab = "Y-axis", main ="Bar-Chart")

# Create the data for the chart
A <- c(17, 2, 8, 13, 1, 22)
B <- c("Jan", "feb", "Mar", "Apr", "May", "Jun")

# Plot the bar chart
barplot(A, names.arg = B, xlab ="Month",
        ylab ="Articles", col ="blue",
        main ="Bar chart blue")

colors = c("green", "orange", "brown")
months <- c("Mar", "Apr", "May", "Jun", "Jul")
regions <- c("East", "West", "North")

# Create the matrix of the values.
Values <- matrix(c(2, 9, 3, 11, 9, 4, 8, 7, 3, 12, 5, 2, 8, 10, 11),
                 nrow = 3, ncol = 5, byrow = TRUE)

# Create the bar chart
barplot(Values, main = "Total Revenue", names.arg = months,
        xlab = "Month", ylab = "Revenue",
        col = colors, beside = TRUE)

# Add the legend to the chart
legend("topleft", regions, cex = 0.7, fill = colors)

colors = c("green", "orange", "brown")
months <- c("Mar", "Apr", "May", "Jun", "Jul")
regions <- c("East", "West", "North")

# Create the matrix of the values.
Values <- matrix(c(2, 9, 3, 11, 9, 4, 8, 7, 3, 12, 5, 2, 8, 10, 11),
                 nrow = 3, ncol = 5, byrow = TRUE)

# Create the bar chart
barplot(Values, main = "Total Revenue", names.arg = months,
        xlab = "Month", ylab = "Revenue", col = colors)

# Add the legend to the chart
legend("topleft", regions, cex = 0.7, fill = colors)
