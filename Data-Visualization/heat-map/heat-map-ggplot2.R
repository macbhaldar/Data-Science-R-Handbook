library(reshape)
library(ggplot2)

set.seed(8)
m <- matrix(round(rnorm(200), 2), 10, 10)
colnames(m) <- paste("Col", 1:10)
rownames(m) <- paste("Row", 1:10)

# Transform the matrix in long format
df <- melt(m)
colnames(df) <- c("x", "y", "value")

# Heat map with geom_tile

ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile()

# Square tiles
ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile() +
  coord_fixed()

# Border customization
ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile(color = "white",
            lwd = 1.5,
            linetype = 1) +
  coord_fixed()

# Adding the values
ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile(color = "black") +
  geom_text(aes(label = value), color = "white", size = 4) +
  coord_fixed()

# Color palette

# scale_fill_gradient
ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradient(low = "white", high = "red") +
  coord_fixed()

# scale_fill_gradient2
ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradient2(low = "#075AFF",
                       mid = "#FFFFCC",
                       high = "#FF0000") +
  coord_fixed()

# scale_fill_gradientn
ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile(color = "black") +
  scale_fill_gradientn(colors = hcl.colors(20, "RdYlGn")) +
  coord_fixed()

# Legend customization
# Width and height
ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile(color = "black") +
  coord_fixed() +
  guides(fill = guide_colourbar(barwidth = 0.5,
                                barheight = 20))

# Change the title
ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile(color = "black") +
  coord_fixed() +
  guides(fill = guide_colourbar(title = "Title"))

# Remove the labels and the ticks
ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile(color = "black") +
  coord_fixed() +
  guides(fill = guide_colourbar(label = FALSE,
                                ticks = FALSE))

# Remove the legend
ggplot(df, aes(x = x, y = y, fill = value)) +
  geom_tile(color = "black") +
  coord_fixed() +
  theme(legend.position = "none")
