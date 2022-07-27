df <- USArrests[1:20, ]

# Option 1
# Distance matrix
d <- dist(df)
hc <- hclust(d)
plot(hc)


# Option 2
# Distance matrix
d <- dist(df)
hc <- hclust(d)
plot(as.dendrogram(hc))

# The previous line is similar to:
plot(hc, hang = -1)


# Clustering methods

# ward.D
hc <- hclust(d, method = "ward.D")
plot(as.dendrogram(hc), main = "ward.D")

# ward.D2
hc <- hclust(d, method = "ward.D2")
plot(as.dendrogram(hc), main = "ward.D2")

# single
hc <- hclust(d, method = "single")
plot(as.dendrogram(hc), main = "single")

# average
hc <- hclust(d, method = "average")
plot(as.dendrogram(hc), main = "average")

# mcquitty
hc <- hclust(d, method = "mcquitty")
plot(as.dendrogram(hc), main = "mcquitty")

# median
hc <- hclust(d, method = "median")
plot(as.dendrogram(hc), main = "median")

# centroid
hc <- hclust(d, method = "centroid")
plot(as.dendrogram(hc), main = "centroid")


# Adding rectangles around hierarchical clusters

# Setting the number of clusters
hc <- hclust(d)
plot(as.dendrogram(hc))
rect.hclust(hc, k = 3)

# adding only the first and the third clusters rectangles
hc <- hclust(d)
plot(as.dendrogram(hc))
rect.hclust(hc, k = 3,
            which = c(1, 3))

# Clusters based on height
hc <- hclust(d)
plot(as.dendrogram(hc))
rect.hclust(hc, h = 150)

# Color of the rectangles
hc <- hclust(d)
plot(as.dendrogram(hc))
rect.hclust(hc, k = 2,
            border = 3:4)
