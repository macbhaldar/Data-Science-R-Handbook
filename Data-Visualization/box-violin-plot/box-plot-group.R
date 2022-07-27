set.seed(136)
data <- data.frame(x = rnorm(300),
                   group = sample(LETTERS[1:3],
                                  size = 300,
                                  replace = TRUE))

# Box plot for multiple groups
# option 1
boxplot(data$x ~ data$group)

# Equivalent to:
boxplot(data[, 1] ~ data[, 2])

# Equivalent to:
x <- data$x
y <- data$group
boxplot(x ~ y)

# option 2
boxplot(x ~ group, data = data)

# Box plot color by group
boxplot(x ~ group, data = data,
        col = c("#FFE0B2", "#FFA726", "#F57C00")) 
