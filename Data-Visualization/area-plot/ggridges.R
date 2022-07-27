library(ggplot2)
library(ggridges)

df <- diamonds[1:100, c("color", "depth")]

ggplot(df, aes(x=depth, y=color)) + 
  geom_density_ridges()

ggplot(df, aes(x=depth, y=color)) + 
  geom_density_ridges2()


# cut the trailing tails
ggplot(df, aes(x=depth, y=color)) + 
  geom_density_ridges(rel_min_height = 0.005)

# Scale
ggplot(df, aes(x=depth, y=color)) + 
  geom_density_ridges(scale = 3)

# alternative stats
ggplot(df, aes(x=depth, y=color)) + 
  geom_density_ridges(stat = "binline",
                      bins = 20, draw_baseline = FALSE)

# color customization
# fill color and transperancy
ggplot(df, aes(x=depth, y=color)) + 
  geom_density_ridges(fill = "lightblue", alpha = 0.5)

# border color
ggplot(df, aes(x=depth, y=color)) + 
  geom_density_ridges(fill = "white", color = 4, linetype = 1, lwd = 0.5)

# color based on group
ggplot(df, aes(x=depth, y=color, fill = color)) + 
  geom_density_ridges()

# cyclical color scale
ggplot(df, aes(x=depth, y=color, fill = color, color = color)) + 
  geom_density_ridges() + 
  scale_fill_cyclical(name = "Cycle", guide = "legend",
                      values = c("#99e6ff", "#4ca6ff")) + 
  scale_color_cyclical(name = "Cycle", guide ="legend",
                       values = c(1, 4))

# Gradient
ggplot(df, aes(x=depth, y=color, fill = stat(x))) + 
  geom_density_ridges_gradient() + 
  scale_fill_viridis_c(name = "Depth", option ="C")

# theme
ggplot(df, aes(x=depth, y=color, fill = stat(x))) + 
  geom_density_ridges_gradient() + 
  scale_fill_viridis_c(name = "Depth", option ="C") + 
  coord_cartesian(clip = "off") + 
  theme_minimal()

# Adding quantile and probabilities
ggplot(df, aes(x=depth, y=color)) + 
  geom_density_ridges(quantile_lines = TRUE)

# Number of quantiles
ggplot(df, aes(x=depth, y=color)) + 
  geom_density_ridges(quantile_lines = TRUE, alpha = 0.75, 
                      quantiles = 2)

# Specify the quantiles
ggplot(df, aes(x=depth, y=color)) + 
  geom_density_ridges(quantile_lines = TRUE, alpha = 0.75,
                      quantiles = c(0.05, 0.5, 0.95))

# color by quantile
ggplot(df, aes(x=depth, y=color, fill = stat(quantile))) + 
  stat_density_ridges(quantile_lines = FALSE, 
                      calc_ecdf = TRUE,
                      geom = "density_ridges_gradient") + 
  scale_fill_brewer(name = "")

# highlight the tails of the distribution
ggplot(df, aes(x=depth, y=color, fill = stat(quantile))) + 
  stat_density_ridges(quantile_lines = TRUE, 
                      calc_ecdf = TRUE,
                      geom = "density_ridges_gradient", 
                      quantiles = c(0.05, 0.95)) + 
  scale_fill_manual(name = "prob.", values = c("#e2fff2", "white", "#b0e0e6"), 
                    labels = c("(0, 5%)", "(5%, 95%)", "(95%, 1%)"))

# mapping the tail probabilities onto color
ggplot(df, aes(depth, y = color, 
               fill = 0.5 - abs(0.5 - stat(ecdf)))) + 
  stat_density_ridges(geom = "density_ridges_gradient", calc_ecdf = TRUE) +  
  scale_fill_gradient(low = "white", high = "#87ceff", 
                      name = "Tail prob.")
