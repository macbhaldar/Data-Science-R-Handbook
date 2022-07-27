library(ggplot2)

# Data 
set.seed(1)

age <- factor(sample(c("Child", "Adult", "Retired"),
                     size = 50, replace = TRUE),
              levels = c("Child", "Adult", "Retired"))
hours <- sample(1:4, size = 50, replace = TRUE)
city <- sample(c("A", "B", "C"),
               size = 50, replace = TRUE)

df <- data.frame(x = age, y = hours, group = city)

# stat = “count”
ggplot(df, aes(x = x, fill = group)) + 
  geom_bar()

# stat = “identity”
ggplot(df, aes(x = x, y = y, fill = group)) + 
  geom_bar(stat = "identity")

# Predefined palette
ggplot(df, aes(x = x, y = y, fill = group)) + 
  geom_bar(stat = "identity") +
  scale_fill_brewer()

# Custom colors
ggplot(df, aes(x = x, y = y, fill = group)) + 
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("#DADAEB", "#9E9AC8", "#6A51A3"))

# Border color (stat = “identity”)
ggplot(df, aes(x = x, y = y, fill = group)) + 
  geom_bar(stat = "identity", color = "black") +
  scale_fill_manual(values = c("#DADAEB", "#9E9AC8", "#6A51A3"))

# Border color (stat = “count”)
ggplot(df, aes(x = x, fill = group)) + 
  geom_bar(color = "black") +
  scale_fill_manual(values = c("#DADAEB", "#9E9AC8", "#6A51A3"))

# Legend title
ggplot(df, aes(x = x, y = y, fill = group)) + 
  geom_bar(stat = "identity") +
  guides(fill = guide_legend(title = "Title"))

# Legend key labels
ggplot(df, aes(x = x, y = y, fill = group)) + 
  geom_bar(stat = "identity") +
  scale_fill_discrete(labels = c("G1", "G2", "G3"))

# Remove the legend
ggplot(df, aes(x = x, y = y, fill = group)) + 
  geom_bar(stat = "identity") +
  theme(legend.position = "none")
