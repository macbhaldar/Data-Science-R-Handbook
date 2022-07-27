library(ggplot2)

# Data 
set.seed(6)
df <- data.frame(group = LETTERS[1:20],
                 value = rnorm(20))

ggplot(df, aes(x = group, y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE) + # Remove the legend
  xlab("Group") +
  ylab("Value")

# Reorder the value
ggplot(df, aes(x = reorder(group, value), y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE) +
  xlab("Group") +
  ylab("Value")

# Vertical diverging bar chart
ggplot(df, aes(x = reorder(group, value), y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE) +
  xlab("Group") +
  ylab("Value") +
  coord_flip()

# Flipping the names of the categorical variable
ggplot(df, aes(x = group, y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE) +
  xlab("Group") +
  ylab("Value") +
  theme(axis.text.x = element_text(angle = 90,
                                   hjust = 1,
                                   vjust = 0.5))

# Adding text for each bar (vertical text)
ggplot(df, aes(x = reorder(group, value), y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE) +
  geom_text(aes(label = round(value, 1),
                angle = 90,
                hjust = ifelse(value < 0, 1.25, -0.25),
                vjust = 0.5),
            size = 3) +
  xlab("Group") +
  ylab("Value") + 
  scale_y_continuous(limits = c(min(df$value) - 0.2,
                                max(df$value) + 0.2))

# Adding text for each bar (horizontal text)
ggplot(df, aes(x = reorder(group, value), y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE) +
  geom_text(aes(label = round(value, 1),
                hjust = 0.5,
                vjust = ifelse(value < 0, 1.5, -1)),
            size = 2.5) +
  xlab("Group") +
  ylab("Value") +
  scale_y_continuous(limits = c(min(df$value) - 0.2,
                                max(df$value) + 0.2))

# Adding text for each bar (vertical plot)
ggplot(df, aes(x = reorder(group, value), y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE) +
  geom_text(aes(label = round(value, 1),
                hjust = ifelse(value < 0, 1.5, -1),
                vjust = 0.5),
            size = 3) +
  xlab("Group") +
  ylab("Value") +
  coord_flip() + 
  scale_y_continuous(breaks= seq(-2, 2, by = 1),
                     limits = c(min(df$value) - 0.5,
                                max(df$value) + 0.5))

# Color customization

# Overriding the default bars color
ggplot(df, aes(x = reorder(group, value), y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE,
           fill = 4,          # Background color
           color = "white") + # Border color
  xlab("Group") +
  ylab("Value")

# Color based on value
color <- ifelse(df$value < 0, "pink", "lightblue")

ggplot(df, aes(x = reorder(group, value), y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE,
           fill = color,      # Background color
           color = "white") + # Border color
  xlab("Group") +
  ylab("Value")

# Gradient color
ggplot(df, aes(x = reorder(group, value), y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE,
           aes(fill = value),  # Background color
           color = "gray30") + # Border color
  xlab("Group") +
  ylab("Value") +
  scale_fill_gradient2(low = "#F4A460",
                       mid = "aliceblue",
                       high = "#6495ED")

# Advanced diverging bar plot in ggplot2

# Example 1: axis limits, color and theme
color <- ifelse(df$value < 0, "pink", "lightblue")

ggplot(df, aes(x = reorder(group, value), y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE,
           fill = color,      # Background color
           color = "white") + # Border color
  xlab("Group") +
  ylab("Value") +
  scale_y_continuous(breaks= seq(-2, 2, by = 1),
                     limits = c(min(df$value) - 0.2,
                                max(df$value) + 0.2)) +
  coord_flip() +
  theme_minimal()

# Example 2: names for each bar, vertical grid and vertical line
color <- ifelse(df$value < 0, "pink", "lightblue")

ggplot(df, aes(x = reorder(group, value), y = value)) +
  geom_bar(stat = "identity",
           show.legend = FALSE,
           fill = color,     
           color = "white") +
  geom_hline(yintercept = 0, color = 1, lwd = 0.2) +
  geom_text(aes(label = group, # Text with groups
                hjust = ifelse(value < 0, 1.5, -1),
                vjust = 0.5), size = 2.5) +
  xlab("Group") +
  ylab("Value") +
  scale_y_continuous(breaks = seq(-2, 2, by = 1),
                     limits = c(-2.5, 2.5)) +
  coord_flip() +
  theme_minimal() +
  theme(axis.text.y = element_blank(),  # Remove Y-axis texts
        axis.ticks.y = element_blank(), # Remove Y-axis ticks
        panel.grid.major.y = element_blank()) # Remove horizontal grid
