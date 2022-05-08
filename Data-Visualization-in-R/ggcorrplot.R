library(ggcorrplot)

# Compute a correlation matrix
data(mtcars)
corr <- round(cor(mtcars), 1)
head(corr[, 1:6]
     
# Compute a matrix of correlation p-values
p.mat <- cor_pmat(mtcars)
head(p.mat[, 1:4])

# Visualize the correlation matrix

# method = "square"
ggcorrplot(corr)


# method = "circle"
ggcorrplot(corr, method = "circle")

# Reordering the correlation matrix

# using hierarchical clustering
ggcorrplot(corr, hc.order = TRUE, outline.col = "white")

# Types of correlogram layout

# Get the lower triangle
ggcorrplot(corr, hc.order = TRUE, type = "lower",
           outline.col = "white")

# Get the upeper triangle
ggcorrplot(corr, hc.order = TRUE, type = "upper",
           outline.col = "white")

# Change colors and theme
# Argument colors
ggcorrplot(corr, hc.order = TRUE, type = "lower",
           outline.col = "white",
           ggtheme = ggplot2::theme_gray,
           colors = c("#6D9EC1", "white", "#E46726"))

# Add correlation coefficients
# argument lab = TRUE
ggcorrplot(corr, hc.order = TRUE, type = "lower",
           lab = TRUE)
