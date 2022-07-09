# Time series is a series of data points in which each data point is associated with a timestamp

# Get the data points in form of a R vector.
rainfall <- c(29,11,42,57,65.4,98.5,485.5,498.6,344.2,185,82.8,21)

# Convert it to a time series object.
rainfall.timeseries <- ts(rainfall,start = c(2020,1),frequency = 12)

# Print the timeseries data.
print(rainfall.timeseries)

# Plot a graph of the time series.
plot(rainfall.timeseries)


# Multiple Time Series
rainfall1 <- c(29,11,42,57,65.4,98.5,485.5,498.6,344.2,185,82.8,21)
rainfall2 <- c(21,10,32,52,74.4,108.1,445.5,598.6,375.1,149,78.5,1)

# Convert them to a matrix.
combined.rainfall <-  matrix(c(rainfall1,rainfall2),nrow = 12)

# Convert it to a time series object.
rainfall.timeseries <- ts(combined.rainfall,start = c(2020,1),frequency = 12)

# Print the timeseries data.
print(rainfall.timeseries)

# Plot a graph of the time series.
plot(rainfall.timeseries, main = "Multiple Time Series")
