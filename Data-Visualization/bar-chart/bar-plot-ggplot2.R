library(ggplot2)
        
df <- data.frame(group = c("A", "B", "C"),
                 count = c(3, 5, 6))

# Only categorical data
df2 <- data.frame(cat = c("A", "A", "A", 
                          "B", "B", "B", "B", "B",
                          "C", "C", "C", "C", "C", "C"))

# Bar chart with geom_bar
ggplot(df2, aes(x = cat)) +
  geom_bar()

# geom_bar with stat “identity”
ggplot(df, aes(x = group, y = count)) +
  geom_bar(stat = "identity")

# Bar chart with geom_col
ggplot(df, aes(x = group, y = count)) +
  geom_col()

# Horizontal bar plot

# Option 1: using coord_flip
ggplot(df, aes(x = group, y = count)) +
  geom_bar(stat = "identity") +
  coord_flip()

# Option 2: changing the aes variables order
ggplot(df, aes(x = count, y = group)) +
  geom_bar(stat = "identity")

# Order of the bars of the bar graph
ggplot(df, aes(x = group, y = count)) +
  geom_bar(stat = "identity") +
  scale_x_discrete(limits = c("C", "B", "A"))

# Or changing the levels of the factor variable
ggplot(df, aes(x = factor(group, levels = c("C", "B", "A")), y = count)) +
  geom_bar(stat = "identity")

# Adding labels to the bars

# Labels inside the bars
ggplot(df, aes(x = group, y = count)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = count), vjust = 2, colour = "white")
# Note that if you data is categorical
# you can show the count for each group with ..count..
ggplot(df2, aes(x = cat)) +
  geom_bar() +
  geom_text(aes(label = ..count..), stat = "count", vjust = 2, colour = "white")

# Labels over the bars
ggplot(df, aes(x = group, y = count)) +
  geom_bar(stat = "identity") +
  geom_text(aes(label = count), vjust = -1, colour = "black") +
  ylim(c(0, 6.5)) # Increase the limits of the Y-axis if needed

# Color customization
# Same color for all bars
ggplot(df, aes(x = group, y = count)) +
  geom_bar(stat = "identity", fill = 4)

# Color by group
ggplot(df, aes(x = group, y = count, fill = group)) +
  geom_bar(stat = "identity")

# Specify a color for each bar
ggplot(df, aes(x = group, y = count, fill = group)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("#FCFED4", "#CCEDB1", "#41B7C4"))
# Or use a named vector with the group labels
ggplot(df, aes(x = group, y = count, fill = group)) +
  geom_bar(stat = "identity") +
  scale_fill_manual(values = c("A" = "#FCFED4", "B" = "#CCEDB1", "C" = "#41B7C4"))

# Border color
ggplot(df, aes(x = group, y = count)) +
  geom_bar(stat = "identity", 
           color = "lightblue",
           lwd = 2, fill = "white")

# Border color by group
ggplot(df, aes(x = group, y = count, color = group)) +
  geom_bar(stat = "identity", lwd = 2, fill = "white")

# Legend position
ggplot(df, aes(x = group, y = count, fill = group)) +
  geom_bar(stat = "identity") +
  theme(legend.position = "bottom")

# Legend title
ggplot(df, aes(x = group, y = count, fill = group)) +
  geom_bar(stat = "identity") +
  guides(fill = guide_legend(title = "Legend title")) 

# Legend labels
ggplot(df, aes(x = group, y = count, fill = group)) +
  geom_bar(stat = "identity") +
  scale_fill_hue(labels = c("Group A", "Group B", "Group C"))
