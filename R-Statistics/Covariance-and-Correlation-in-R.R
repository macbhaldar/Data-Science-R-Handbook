# Data vectors
x <- c(1, 3, 5, 10)

y <- c(2, 4, 6, 20)

# Print covariance using different methods
print(cov(x, y))
print(cov(x, y, method = "pearson"))
print(cov(x, y, method = "kendall"))
print(cov(x, y, method = "spearman"))

# Data vectors
x <- rnorm(2)
y <- rnorm(2)

# Binding into square matrix
mat <- cbind(x, y)

# Defining X as the covariance matrix
X <- cov(mat)

# Print covariance matrix
print(X)

# Print correlation matrix of data
# vector
print(cor(mat))

# Using function cov2cor()
# To convert covariance matrix to
# correlation matrix
print(cov2cor(X))
