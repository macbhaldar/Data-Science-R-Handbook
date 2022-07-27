# install.packages("devtools")
# devtools::install_github("ricardo-bion/ggradar")
library(ggradar)

set.seed(4)
df <- data.frame(matrix(runif(30), ncol = 10))
df[, 1] <- paste0("G", 1:3)
colnames(df) <- c("Group", paste("Var", 1:9))

ggradar(df) 

# Radar chart labels
ggradar(df, 
        values.radar = c(0, 0.5, 1),
        axis.labels = paste0("A", 1:9))

# Radar chart colors and line types
lcols <- c("#EEA236", "#5CB85C", "#46B8DA")
ggradar(df,
        background.circle.colour = "white",
        axis.line.colour = "gray60",
        gridline.min.colour = "gray60",
        gridline.mid.colour = "gray60",
        gridline.max.colour = "gray60",
        group.colours = lcols)

# custemize line types of each grid line
# Color for the lines
lcols <- c("#EEA236", "#5CB85C", "#46B8DA")

ggradar(df,
        background.circle.colour = "white",
        gridline.min.linetype = 1,
        gridline.mid.linetype = 1,
        gridline.max.linetype = 1,
        group.colours = lcols)

# Legend position
ggradar(df,
        legend.title = "Group",
        legend.position = "bottom")

# Remove the legend
ggradar(df,
        plot.legend = FALSE)
