library(treemapify)
library(ggplot2)

group <- paste("Group", 1:9)
subgroup <- c("A", "C", "B", "A", "A",
              "C", "C", "B", "B")
value <- c(7, 25, 50, 5, 16,
           18, 30, 12, 41)

df <- data.frame(group, subgroup, value)

ggplot(df, aes(area = value, fill = group)) +
  geom_treemap()

# Fill by the numerical variable
ggplot(df, aes(area = value, fill = value)) +
  geom_treemap()

# Adding labels to the tiles
ggplot(df, aes(area = value, fill = group, label = value)) +
  geom_treemap() +
  geom_treemap_text()

ggplot(df, aes(area = value, fill = group, label = value)) +
  geom_treemap() +
  geom_treemap_text(colour = "white",
                    place = "centre",
                    size = 15)

ggplot(df, aes(area = value, fill = group,
               label = paste(group, value, sep = "\n"))) +
  geom_treemap() +
  geom_treemap_text(colour = "white",
                    place = "centre",
                    size = 15) +
  theme(legend.position = "none")

ggplot(df, aes(area = value, fill = value, label = group)) +
  geom_treemap() +
  geom_treemap_text(colour = "white",
                    place = "centre",
                    size = 15)

ggplot(df, aes(area = value, fill = value, label = group)) +
  geom_treemap() +
  geom_treemap_text(colour = "white",
                    place = "centre",
                    size = 15,
                    grow = TRUE)

# Adding subgroup labels
ggplot(df, aes(area = value, fill = value,
               label = group, subgroup = subgroup)) +
  geom_treemap() +
  geom_treemap_subgroup_border(colour = "white", size = 5) +
  geom_treemap_subgroup_text(place = "centre", grow = TRUE,
                             alpha = 0.25, colour = "black",
                             fontface = "italic") +
  geom_treemap_text(colour = "white", place = "centre",
                    size = 15, grow = TRUE)

# Color customization
# Continuous
ggplot(df, aes(area = value, fill = value, label = group)) +
  geom_treemap() +
  geom_treemap_text(colour = c(rep("white", 2),
                               1, rep("white", 6)),
                    place = "centre", size = 15) +
  scale_fill_viridis_c()

# Discrete
ggplot(df, aes(area = value, fill = group, label = value)) +
  geom_treemap() +
  geom_treemap_text(colour = "white",
                    place = "centre",
                    size = 15) +
  scale_fill_brewer(palette = "Blues")
