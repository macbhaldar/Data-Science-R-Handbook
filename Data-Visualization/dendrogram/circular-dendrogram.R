# install.packages("dendextend")
# install.packages("circlize")

library(dendextend)
library(circlize)

# Distance matrix
d <- dist(USArrests)

# Hierarchical clustering dendrogram
hc <- as.dendrogram(hclust(d))


# Circular dendrogram
circlize_dendrogram(hc,
                    labels_track_height = NA,
                    dend_track_height = 0.5) 

# facing = "inside"
circlize_dendrogram(hc,
                    labels_track_height = NA,
                    dend_track_height = 0.5,
                    facing = "inside")

# Circular dendrogram without labels
circlize_dendrogram(hc,
                    dend_track_height = 0.8,
                    labels = FALSE)


# Colors of branches
hc <- hc %>% color_branches(k = 3)

# hc <- color_branches(hc, k = 4)

circlize_dendrogram(hc,
                    labels_track_height = NA,
                    dend_track_height = 0.5)


# labels Colors
hc <- hc %>% color_branches(k = 3) %>% 
  color_labels(k = 3)

circlize_dendrogram(hc,
                    labels_track_height = NA,
                    dend_track_height = 0.5)

#  style and width of the lines
hc <- hc %>%
  color_branches(k = 3) %>%
  set("branches_lwd", 2) %>% 
  set("branches_lty", 2) %>% 
  color_labels(k = 3)

circlize_dendrogram(hc,
                    labels_track_height = NA,
                    dend_track_height = 0.5)
