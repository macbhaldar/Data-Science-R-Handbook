# Required for skewness() function
library(moments)

# Defining data vector
x <- c(40, 41, 42, 43, 50)

# output to be present as PNG file
png(file = "positiveskew.png")

# Print skewness of distribution
print(skewness(x))

# Histogram of distribution
hist(x)

# Saving the file
dev.off()

# Defining normally distributed data vector
x <- rnorm(50, 10, 10)

# output to be present as PNG file
png(file = "zeroskewness.png")

# Print skewness of distribution
print(skewness(x))

# Histogram of distribution
hist(x)

# Saving the file
dev.off()

# Defining data vector
x <- c(10, 11, 21, 22, 23, 25)

# output to be present as PNG file
png(file = "negativeskew.png")

# Print skewness of distribution
print(skewness(x))

# Histogram of distribution
hist(x)

# Saving the file
dev.off()

# Required for kurtosis() function
library(moments)

# Defining data vector
x <- c(rep(61, each = 10), rep(64, each = 18),
       rep(65, each = 23), rep(67, each = 32), rep(70, each = 27),
       rep(73, each = 17))

# output to be present as PNG file
png(file = "platykurtic.png")

# Print skewness of distribution
print(kurtosis(x))

# Histogram of distribution
hist(x)

# Saving the file
dev.off()

# Required for kurtosis() function
library(moments)

# Defining data vector
x <- rnorm(100)

# output to be present as PNG file
png(file = "mesokurtic.png")

# Print skewness of distribution
print(kurtosis(x))

# Histogram of distribution
hist(x)

# Saving the file
dev.off()

# Required for kurtosis() function
library(moments)

# Defining data vector
x <- c(rep(61, each = 2), rep(64, each = 5),
       rep(65, each = 42), rep(67, each = 12), rep(70, each = 10))

# output to be present as PNG file
png(file = "leptokurtic.png")

# Print skewness of distribution
print(kurtosis(x))

# Histogram of distribution
hist(x)

# Saving the file
dev.off()

