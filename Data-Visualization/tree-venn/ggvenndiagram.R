library(ggVennDiagram)
library(ggplot2)

# List of items
x <- list(A = 1:5, B = 2:7)

# 2D Venn diagram
ggVennDiagram(x)

# 3D Venn diagram
x <- list(A = 1:5, B = 2:7, C = 5:10)
ggVennDiagram(x)

# 4D Venn diagram
x <- list(A = 1:5, B = 2:7, C = 5:10, D = 8:15)
ggVennDiagram(x)

# Changing the colors of the diagram
x <- list(A = 1:5, B = 2:7, C = 5:10)
ggVennDiagram(x) + 
  scale_fill_gradient(low = "#F4FAFE", high = "#4981BF")

#  border
x <- list(A = 1:5, B = 2:7, C = 5:10)
ggVennDiagram(x, color = "black", lwd = 0.8, lty = 1) + 
  scale_fill_gradient(low = "#F4FAFE", high = "#4981BF")

# Labels and group names

# Group names
x <- list(A = 1:5, B = 2:7, C = 5:10)
ggVennDiagram(x, category.names = c("Group 1",
                                    "Group 2",
                                    "Group 3"))

# Labels with percentages
x <- list(A = 1:5, B = 2:7, C = 5:10)
ggVennDiagram(x, 
              label = "percent")

# Labels with count
x <- list(A = 1:5, B = 2:7, C = 5:10)
ggVennDiagram(x, 
              label = "count")

# Remove the labels
x <- list(A = 1:5, B = 2:7, C = 5:10)
ggVennDiagram(x, 
              label = NULL)

# Labels transparency
x <- list(A = 1:5, B = 2:7, C = 5:10)
ggVennDiagram(x, 
              label_alpha = 0)

# Remove or customize the legend
x <- list(A = 1:5, B = 2:7, C = 5:10)

# Venn diagram with custom legend
ggVennDiagram(x) + 
  guides(fill = guide_legend(title = "Title")) +
  theme(legend.title = element_text(color = "red"),
        legend.position = "bottom")

# remove the legend of the diagram just setting its position to "none"
x <- list(A = 1:5, B = 2:7, C = 5:10)

# Venn diagram without legend
ggVennDiagram(x, color = 1, lwd = 0.7) + 
  scale_fill_gradient(low = "#F4FAFE", high = "#4981BF") +
  theme(legend.position = "none")
