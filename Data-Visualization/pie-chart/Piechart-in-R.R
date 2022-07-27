# Create data for the graph.
sales<- c(72, 21, 43, 63)
labels <- c("Mumbai", "Pune", "Chennai", "Bangalore")

# Plot the chart.
pie(sales, labels)

# Plot the chart with title and rainbow color pallet.
pie(sales, labels, main = "City pie chart",
    col = rainbow(length(sales)))

piepercent<- round(100 * sales / sum(sales), 1)

# Plot the chart.
pie(sales, labels = piepercent,
    main = "City pie chart", col = rainbow(length(sales)))
legend("topright", c("Mumbai", "Pune", "Chennai", "Bangalore"),
       cex = 0.5, fill = rainbow(length(sales)))

# 3D plot
# Get the library.
library(plotrix)

# Create data for the graph.
sales<- c(72, 21, 43, 63)
labels <- c("Mumbai", "Pune", "Chennai", "Bangalore")

piepercent<- round(100 * sales / sum(sales), 1)

# Plot the chart.
pie3D(sales, labels = piepercent,
      main = "City pie chart", col = rainbow(length(sales)))
legend("topright", c("Mumbai", "Pune", "Chennai", "Bangalore"),
       cex = 0.5, fill = rainbow(length(sales)))
