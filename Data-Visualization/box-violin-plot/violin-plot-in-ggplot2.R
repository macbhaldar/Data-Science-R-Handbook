library(ggplot2)

warpbreaks

ggplot(warpbreaks, aes(x = tension, y = breaks)) +
  geom_violin()

# Horizontal violin plot
ggplot(warpbreaks, aes(x = tension, y = breaks)) +
  geom_violin() +
  coord_flip()

# Avoid trimming the trails
ggplot(warpbreaks, aes(x = tension, y = breaks)) +
  geom_violin(trim = FALSE)

# Adding quantiles
ggplot(warpbreaks, aes(x = tension, y = breaks)) +
  geom_violin(trim = FALSE,
              draw_quantiles = c(0.25, 0.5, 0.75))

# Adding box plots
ggplot(warpbreaks, aes(x = tension, y = breaks)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = 0.07)

# Bandwidth customization
ggplot(warpbreaks, aes(x = tension, y = breaks)) +
  geom_violin(trim = FALSE, bw = 10) +
  geom_boxplot(width = 0.07)

# Fill color by group
ggplot(warpbreaks, aes(x = tension, y = breaks, fill = tension)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = 0.07)

# Fill color by subgroup
ggplot(warpbreaks, aes(x = tension, y = breaks, fill = wool)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = 0.07, position = position_dodge(width = 0.9))

# Color scale
ggplot(warpbreaks, aes(x = tension, y = breaks, fill = tension)) +
  geom_violin(trim = FALSE) + +
  geom_boxplot(width = 0.07)
scale_fill_brewer()

# Custom colors
ggplot(warpbreaks, aes(x = tension, y = breaks, fill = tension)) +
  geom_violin(trim = FALSE) + 
  geom_boxplot(width = 0.07) +
  scale_fill_manual(values = c("#BCE4D8", "#49A4B9", "#2C5985"))

# Fill transparency
ggplot(warpbreaks, aes(x = tension, y = breaks, fill = tension)) +
  geom_violin(trim = FALSE,
              alpha = 0.5) +
  geom_boxplot(width = 0.07)

# Border color
ggplot(warpbreaks, aes(x = tension, y = breaks, fill = tension)) +
  geom_violin(trim = FALSE,
              color = "blue") +
  geom_boxplot(width = 0.07)

# Border color by group
ggplot(warpbreaks, aes(x = tension, y = breaks, color = tension)) +
  geom_violin(trim = FALSE) +
  geom_boxplot(width = 0.07)

# Custom border colors
ggplot(warpbreaks, aes(x = tension, y = breaks, color = tension)) +
  geom_violin(trim = FALSE) + 
  geom_boxplot(width = 0.07) +
  scale_color_manual(values = c("#F4D166", "#EC6E1C", "#B71D3E"))

# Legend title
ggplot(warpbreaks, aes(x = tension, y = breaks, fill = tension)) +
  geom_violin(trim = FALSE) + 
  geom_boxplot(width = 0.07) +
  guides(fill = guide_legend(title = "Title"))

# Key labels
ggplot(warpbreaks, aes(x = tension, y = breaks, fill = tension)) +
  geom_violin(trim = FALSE) + 
  geom_boxplot(width = 0.07) +
  scale_fill_hue(labels = c("G1", "G2", "G3"))

# Remove legend
ggplot(warpbreaks, aes(x = tension, y = breaks, fill = tension)) +
  geom_violin(trim = FALSE) + 
  geom_boxplot(width = 0.07) + 
  theme(legend.position = "none")
