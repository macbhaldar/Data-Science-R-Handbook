# Data
set.seed(34)
x <- runif(300)
y <- 5 * x ^ 2 + rnorm(length(x), sd = 2)
group <- ifelse(x < 0.4, "Group 1",
                ifelse(x > 0.8, "Group 2",
                       "Group 3"))

# Some noise after defining the groups
x <- x + runif(length(x), -0.2, 0.2)

# Scatter plot
plot(x, y,
     pch = 19,
     col = factor(group))

# Legend
legend("topleft",
       legend = levels(factor(group)),
       pch = 19,
       col = factor(levels(factor(group))))



# Change the default colors
# Color selection
colors <- c("#FDAE61", # Orange
            "#D9EF8B", # Light green
            "#66BD63") # Darker green

# Scatter plot
plot(x, y,
     pch = 19,
     col = colors[factor(group)])

# Legend
legend("topleft",
       legend = c("Group 1", "Group 2", "Group 3"),
       pch = 19,
       col = colors)




# Reorder the colors of the groups
# Color selection
colors <- c("#FDAE61", # Orange
            "#D9EF8B", # Light green
            "#66BD63") # Darker green

# Reorder the factor levels
reordered_groups <- factor(group, levels = c("Group 2",
                                             "Group 1",
                                             "Group 3"))
# Scatter plot
plot(x, y,
     pch = 19,
     col = colors[reordered_groups])

# Legend
legend("topleft",
       legend = c("Group 1", "Group 2", "Group 3"),
       pch = 19,
       col = colors[factor(levels(reordered_groups))])
