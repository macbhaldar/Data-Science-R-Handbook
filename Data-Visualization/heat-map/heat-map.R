m <- matrix(rnorm(100), ncol = 10)
colnames(m) <- paste("Col", 1:10)
rownames(m) <- paste("Row", 1:10)

heatmap(m)

heatmap(m, scale = "column")

# Color customization
heatmap(m, col = hcl.colors(50))

# Side colors
heatmap(m,
        ColSideColors = rainbow(ncol(m)),
        RowSideColors = rainbow(nrow(m)))

# Remove row dendrogram
heatmap(m, Rowv = NA)

# Remove column dendrogram
heatmap(m, Colv = NA)

# Remove both dendrograms
heatmap(m, Rowv = NA, Colv = NA)
