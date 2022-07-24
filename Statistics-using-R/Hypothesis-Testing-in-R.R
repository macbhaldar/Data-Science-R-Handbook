# Defining sample vector
x <- rnorm(100)
y <- rnorm(100)

# One Sample T-Test
t.test(x, mu = 5)

# Two Sample T-Test
t.test(x, y)

# Directional hypothesis testing
t.test(x, mu = 2, alternative = 'greater')

# one sample test
wilcox.test(x, exact = FALSE)

# Two sample test
wilcox.test(x, y)

# Correlation Test Using mtcars dataset in R
cor.test(mtcars$mpg, mtcars$hp)

