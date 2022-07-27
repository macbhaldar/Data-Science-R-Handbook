library(pheatmap)

# Data 
set.seed(8)
m <- matrix(rnorm(200), 10, 10)
colnames(m) <- paste("Col", 1:10)
rownames(m) <- paste("Row", 1:10)

# Heat map
pheatmap(m)

# Normalization
pheatmap(m, scale = "column")

# Values
pheatmap(m,
         display_numbers = TRUE,
         number_color = "black", 
         fontsize_number = 8)

# Number of clusters
pheatmap(m, kmeans_k = 3, cellheight = 50)

# Clustering
# Remove rows dendrogram
pheatmap(m, cluster_rows = FALSE)

# Remove columns dendrogram
pheatmap(m, cluster_cols = FALSE)

# Remove dendrograms
pheatmap(m,
         cluster_cols = FALSE,
         cluster_rows = FALSE)

# Color customization
# Border color
pheatmap(m, border_color = "black")

# Color palette
pheatmap(m, color = hcl.colors(50, "BluYl")) 

# Legend customization
# Legend breaks
pheatmap(m, legend_breaks = c(-2, 0, 2))

# Legend labels
pheatmap(m,
         legend_breaks = c(-2, 0, 2),
         legend_labels = c("Low", "Medium", "High"))

# Remove the legend
pheatmap(m, legend = FALSE)
