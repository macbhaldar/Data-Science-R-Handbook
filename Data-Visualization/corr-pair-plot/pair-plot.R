df <- iris[1:4]

pairs(df)

# Equivalent to:
pairs(~ Sepal.Length + Sepal.Width +
        Petal.Length + Petal.Width, data = df)

# Equivalent to:
with(df, pairs(~ Sepal.Length + Sepal.Width +
                 Petal.Length + Petal.Width))

# Equivalent to:
plot(df)


pairs(df,       # Data
      pch = 19, # Pch symbol
      col = 4,  # Color
      main = "Title",    # Title
      gap = 0,           # Subplots distance
      row1attop = FALSE, # Diagonal direction
      labels = colnames(df), # Labels
      cex.labels = 0.8,  # Size of diagonal texts
      font.labels = 1)   # Font style of diagonal texts

# Color by group
species <- iris[, 5]      # Groups
l <- length(unique(species)) # Number of groups

pairs(df, col = hcl.colors(l, "Temps")[species])

# pch
pairs(df,
      pch = 22,
      bg = hcl.colors(l, "Temps")[species],
      col = hcl.colors(l, "Temps")[species])
