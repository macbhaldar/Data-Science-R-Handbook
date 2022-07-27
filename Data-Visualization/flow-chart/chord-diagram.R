library(circlize)


set.seed(1)
m <- matrix(sample(15, 15), 5, 3)
rownames(m) <- paste0("Row", 1:5)
colnames(m) <- paste0("Col", 1:3)

# Or use a data frame
df <- data.frame(from = rep(rownames(m), ncol(m)),
                 to = rep(colnames(m), each = nrow(m)),
                 value = as.vector(m))


chordDiagram(m)
circos.clear()

# Color customization
# Grid colors
colors <- c(Col1 = "lightgrey", Col2 = "grey",
            Col3 = "darkgrey", Row1 = "#FF410D",
            Row2 = "#6EE2FF", Row3 = "#F7C530",
            Row4 = "#95CC5E", Row5 = "#D0DFE6")

chordDiagram(m, grid.col = colors)
circos.clear()

# Transparency
colors <- c(Col1 = "lightgrey", Col2 = "grey",
            Col3 = "darkgrey", Row1 = "#FF410D",
            Row2 = "#6EE2FF", Row3 = "#F7C530",
            Row4 = "#95CC5E", Row5 = "#D0DFE6")

chordDiagram(m, grid.col = colors,
             transparency = 0.2)
circos.clear()

# Link colors
colors <- c(Col1 = "red", Col2 = "green",
            Col3 = "blue", Row1 = "#FF410D",
            Row2 = "#6EE2FF", Row3 = "#F7C530",
            Row4 = "#95CC5E", Row5 = "#D0DFE6")

chordDiagram(m, grid.col = colors,
             col = hcl.colors(15))
circos.clear()

# Using a color ramp palette
colors <- c(Col1 = "red", Col2 = "green",
            Col3 = "blue", Row1 = "#FF410D",
            Row2 = "#6EE2FF", Row3 = "#F7C530",
            Row4 = "#95CC5E", Row5 = "#D0DFE6")
cols <- colorRamp2(range(m), c("#E5FFFF", "#003FFF"))

chordDiagram(m, grid.col = colors, col = cols)
circos.clear()

# Link border customization
# Link borders
cols <- hcl.colors(15, "Temps")

chordDiagram(m,
             col = cols,
             transparency = 0.1,
             link.lwd = 1,    # Line width
             link.lty = 1,    # Line type
             link.border = 1) # Border color

circos.clear()

# Border of specific rows
cols <- hcl.colors(15, "Geyser")
mb <- matrix("black", nrow = 1, ncol = ncol(m))
rownames(mb) <- rownames(m)[3] # Third row
colnames(mb) <- colnames(m)

chordDiagram(m,
             col = cols,
             transparency = 0.1,
             link.lwd = 2,     # Line width
             link.lty = 2,     # Line type
             link.border = mb) # Border color

circos.clear()

# Diagram tracks
# Grid track
chordDiagram(m, column.col = c("red", "green", "blue"),
             annotationTrack = "grid",
             annotationTrackHeight = c(0.04, 0.02))

circos.clear()

# Names and grid track
chordDiagram(m, column.col = c("red", "green", "blue"),
             annotationTrack =  c("name", "grid"))

circos.clear()

# No track
chordDiagram(m, column.col = c("red", "green", "blue"),
             annotationTrack = NULL)

circos.clear()
