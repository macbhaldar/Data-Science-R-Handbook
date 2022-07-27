library(ggplot2)

# Data
set.seed(1)
df <- data.frame(x = rnorm(2000), y = rnorm(2000))

ggplot(df, aes(x = x, y = y)) +
  geom_hex()

# Few bins
ggplot(df, aes(x = x, y = y)) +
  geom_hex(bins = 15)

# Too many bins
ggplot(df, aes(x = x, y = y)) +
  geom_hex(bins = 60)

# Border color
ggplot(df, aes(x = x, y = y)) +
  geom_hex(color = "white")

# Fill and transparency
ggplot(df, aes(x = x, y = y)) +
  geom_hex(color = 1, fill = 4, alpha = 0.4)

# Color palette
ggplot(df, aes(x = x, y = y)) +
  geom_hex() +
  scale_fill_viridis_c()

# Legend customization
# Width and height
ggplot(df, aes(x = x, y = y)) +
  geom_hex() +
  guides(fill = guide_colourbar(barwidth = 0.7,
                                barheight = 15))

# Change the title
ggplot(df, aes(x = x, y = y)) +
  geom_hex() +
  guides(fill = guide_colourbar(title = "Count"))

# Remove the labels and the ticks
ggplot(df, aes(x = x, y = y)) +
  geom_hex() +
  guides(fill = guide_colourbar(label = FALSE,
                                ticks = FALSE))

# Remove the legend
ggplot(df, aes(x = x, y = y)) +
  geom_hex() +
  theme(legend.position = "none")
