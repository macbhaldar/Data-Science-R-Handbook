library(fmsb)

radarchart(df)

set.seed(1)
df <- data.frame(rbind(rep(10, 8), rep(0, 8),
                       matrix(sample(0:10, 8),
                              nrow = 1)))
colnames(df) <- paste("Var", 1:8)

# Data set with several groups

set.seed(1)
df2 <- data.frame(rbind(rep(10, 8), rep(0, 8),
                        matrix(sample(0:10, 24,
                                      replace = TRUE),
                               nrow = 3)))
colnames(df2) <- paste("Var", 1:8)

radarchart(df,
           cglty = 1,       # Grid line type
           cglcol = "gray", # Grid line color
           cglwd = 1,       # Line width of the grid
           pcol = 4,        # Color of the line
           plwd = 2,        # Width of the line
           plty = 1)        # Line type of the line

# Fill the area
radarchart(df,
           cglty = 1, cglcol = "gray",
           pcol = 4, plwd = 2,
           pfcol = rgb(0, 0.4, 1, 0.25))

# Shading lines
radarchart(df,
           cglty = 1, cglcol = "gray",
           pcol = 1, plwd = 2,
           pdensity = 10,
           pangle = 40)

# Radar chart of several groups
# Lines customization
radarchart(df2,
           cglty = 1,       # Grid line type
           cglcol = "gray", # Grid line color
           pcol = 2:4,      # Color for each line
           plwd = 2,        # Width for each line
           plty = 1)        # Line type for each line  

# Fill areas
areas <- c(rgb(1, 0, 0, 0.25),
           rgb(0, 1, 0, 0.25),
           rgb(0, 0, 1, 0.25))

radarchart(df2,
           cglty = 1,       # Grid line type
           cglcol = "gray", # Grid line color
           pcol = 2:4,      # Color for each line
           plwd = 2,        # Width for each line
           plty = 1,        # Line type for each line
           pfcol = areas)   # Color of the areas  

# add a legend
areas <- c(rgb(1, 0, 0, 0.25),
           rgb(0, 1, 0, 0.25),
           rgb(0, 0, 1, 0.25))

radarchart(df2,
           cglty = 1,       # Grid line type
           cglcol = "gray", # Grid line color
           pcol = 2:4,      # Color for each line
           plwd = 2,        # Width for each line
           plty = 1,        # Line type for each line
           pfcol = areas)   # Color of the areas   

legend("topright",
       legend = paste("Group", 1:3),
       bty = "n", pch = 20, col = areas,
       text.col = "grey25", pt.cex = 2)
