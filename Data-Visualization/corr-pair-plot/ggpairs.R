library(GGally)

ggpairs(iris)

# Column selection
ggpairs(iris,          # Data frame
        columns = 1:4) # Columns

# Color by group
ggpairs(iris,                 # Data frame
        columns = 1:4,        # Columns
        aes(color = Species,  # Color by group (cat. variable)
            alpha = 0.5))     # Transparency

# Font size
ggpairs(iris, columns = 1:4, aes(color = Species, alpha = 0.5),
        upper = list(continuous = wrap("cor", size = 2.5)))

# Upper, lower and diagonal panels

# Continuous variables
# Upper panel
ggpairs(iris, columns = 1:4, aes(color = Species, alpha = 0.5),
        upper = list(continuous = "points"))

# Lower panel
ggpairs(iris, columns = 1:4, aes(color = Species, alpha = 0.5),
        lower = list(continuous = "smooth"))

# Diagonal
ggpairs(iris, columns = 1:4, aes(color = Species, alpha = 0.5),
        diag = list(continuous = "blankDiag"))

# Categorical variables
# Upper
ggpairs(iris[3:5], aes(color = Species, alpha = 0.5),
        upper = list(combo = "facetdensity"))

# Lower
ggpairs(iris[3:5], aes(color = Species, alpha = 0.5),
        lower = list(combo = "count"))
