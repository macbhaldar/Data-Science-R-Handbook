library(areaplot)

# Sample data set
df <- longley

# X-axis variable
x <- df$Year

# Variables to be stacked
y <- df[, c(1, 2, 3, 4, 5, 7)]


# Percentage stacked area chart
areaplot(x, y, prop = TRUE)

# Equivalent to:
areaplot(. ~ Year, data = df, prop = TRUE)

# Color customization

# Stacked area chart with custom colors
cols <- hcl.colors(6, palette = "viridis", alpha = 0.8)
areaplot(x, y, prop = TRUE,
         col = cols)

# Stacked area chart with custom borders
cols <- hcl.colors(6, palette = "ag_Sunset")
areaplot(x, y, prop = TRUE, col = cols,
         border = "white",
         lwd = 1,
         lty = 1)

# Adding a legend
cols <- hcl.colors(6, palette = "PinkYl")
areaplot(x, y, prop = TRUE, col = cols,
         legend = TRUE,
         args.legend = list(x = "topleft", cex = 0.65,
                            bg = "white", bty = "o"))
