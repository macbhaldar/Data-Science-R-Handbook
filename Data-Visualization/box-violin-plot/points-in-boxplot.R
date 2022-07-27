set.seed(3)
df <- data.frame(x = rexp(100), 
                 group = sample(paste("Group", 1:3),
                                size = 100,
                                replace = TRUE))

# Vertical box plot with points
boxplot(df$x, col = "white")
stripchart(df$x,              # Data
           method = "jitter", # Random noise
           pch = 19,          # Pch symbols
           col = 4,           # Color of the symbol
           vertical = TRUE,   # Vertical mode
           add = TRUE)        # Add it over

# Horizontal box plot with points
boxplot(df$x, col = "white", horizontal = TRUE)
stripchart(df$x,              # Data
           method = "jitter", # Random noise
           pch = 19,          # Pch symbol
           col = 4,           # Color of the symbol
           add = TRUE)        # Add it over

# Box plot by group with points
# Vertical box plot by group with points
boxplot(x ~ group, data = df, col = "white")
stripchart(x ~ group,
           data = df,
           method = "jitter",
           pch = 19,
           col = 2:4,
           vertical = TRUE,
           add = TRUE)

# Horizontal box plot by group with points
boxplot(x ~ group, data = df, col = "white",
        horizontal = TRUE)
stripchart(x ~ group,
           data = df,
           method = "jitter",
           pch = 19,
           col = 2:4,
           add = TRUE)

