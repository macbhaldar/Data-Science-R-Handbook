# Data 
set.seed(1)
x <- sample(1:4, size = 50, replace = TRUE)
g <- sample(c("Group 1", "Group 2", "Group 3"),
            size = 50, replace = TRUE)

# Create a table from your data
tabl <- table(x, g)
tabl 


barplot(tabl,
        main = "Stacked bar chart",
        sub = "Subtitle",
        xlab = "X-lab",
        ylab = "Y-lab",
        axes = TRUE)

# Horizontal bar chart
barplot(tabl,
        horiz = TRUE) 

# Custom group names
barplot(tabl,
        names.arg = c("G1", "G2", "G3")) 

# Color palette
barplot(tabl, col = c("#993404", "#FB6A4A",
                      "#FED976", "#FFFFCC"))

# Border color
barplot(tabl, col = c("#993404", "#FB6A4A",
                      "#FED976", "#FFFFCC"),
        border = "brown")

# Remove the borders
barplot(tabl, col = c("#993404", "#FB6A4A",
                      "#FED976", "#FFFFCC"),
        border = NA)

# Adding a legend
barplot(tabl, col = c("#993404", "#FB6A4A",
                      "#FED976", "#FFFFCC"),
        legend.text = rownames(tabl))

# Legend customization
barplot(tabl, col = c("#993404", "#FB6A4A",
                      "#FED976", "#FFFFCC"),
        legend.text = rownames(tabl),
        args.legend = list(x = "topleft"))

# Legend outside the bar chart
# Increase the right margin
par(mar = c(5.1, 4.1, 4.1, 4))

# Stacked bar chart with legend
barplot(tabl,
        col = c("#993404", "#FB6A4A",
                "#FED976", "#FFFFCC"),
        legend.text = rownames(tabl), 
        args.legend = list(x = "topright",
                           inset = c(-0.2, 0))) 
