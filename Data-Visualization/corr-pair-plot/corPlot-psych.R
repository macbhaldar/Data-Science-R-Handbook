library(psych)

corPlot(longley[, 2:5])

corPlot(longley[, 2:5],
        min.length = 3)

# No correlation displayed
corPlot(longley[, 2:5],
        numbers = FALSE)

# Correlation text size
corPlot(longley[, 2:5],
        cex = 1.25)

# Correlation text of the same size
corPlot(longley[, 2:5],
        scale = FALSE)

# Correlation with significance levels
corPlot(longley[, 2:5],
        stars = TRUE)

# Correlation scaled to p-values
corPlot(longley[, 2:5],
        pval = TRUE)

# Remove the diagonal
corPlot(longley[, 2:5],
        diag = FALSE)

# Remove the upper panel
corPlot(longley[, 2:5],
        upper = FALSE)

# Color palette
corPlot(longley[, 2:5],
        gr = colorRampPalette(heat.colors(40)))

# transparency of the color palette
corPlot(longley[, 2:5],
        alpha = 0.25)

# gray scale
corPlot(longley[, 2:5],
        colors = FALSE)
