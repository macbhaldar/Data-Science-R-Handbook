library(ggstream)
library(ggplot2)

blockbusters

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream()

# Adding labels to the areas
ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream() +
  geom_stream_label(aes(label = genre))

# Stream graphs types

# Ridge
ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(type = "ridge")

# Proportional
ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(type = "proportional")

# Change the fill colors
cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream() +
  scale_fill_manual(values = cols)

# Change the color of the borders
cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(color = 1, lwd = 0.25) +
  scale_fill_manual(values = cols)

# Change the theme
cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(color = 1, lwd = 0.25) +
  scale_fill_manual(values = cols) +
  theme_minimal()

# Advanced arguments

# Bandwidth
cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(color = 1, lwd = 0.25,
              bw = 1) +
  scale_fill_manual(values = cols) +
  theme_minimal()

# Grid
cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(color = 1, lwd = 0.25,
              n_grid = 100) +
  scale_fill_manual(values = cols) +
  theme_minimal()

# Extra span and true range
cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(extra_span = 0.2) +
  geom_stream(extra_span = 0.2, true_range = "none",
              alpha = 0.3) +
  scale_fill_manual(values = cols) +
  theme_minimal()

# Legend customization

# Change the title
cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(extra_span = 0.2) +
  geom_stream(extra_span = 0.2, true_range = "none",
              alpha = 0.3) +
  scale_fill_manual(values = cols) +
  theme_minimal() +
  guides(fill = guide_legend(title = "Title"))

# Change the labels
cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(color = 1, lwd = 0.25) +
  scale_fill_manual(values = cols, labels = LETTERS[1:5]) +
  theme_minimal()

# Remove the legend
cols <- c("#FFB400", "#FFC740", "#C20008", "#FF020D", "#13AFEF")

ggplot(blockbusters, aes(x = year, y = box_office, fill = genre)) +
  geom_stream(color = 1, lwd = 0.25) +
  scale_fill_manual(values = cols) +
  theme_minimal() +
  theme(legend.position = "none")
