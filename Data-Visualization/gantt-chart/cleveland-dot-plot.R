set.seed(1)
sold <- sample(400:450, 12)
month <- month.name
quarter <- c(rep(1, 3), rep(2, 3),
             rep(3, 3), rep(4, 3))

# Basic dot chart
dotchart(sold)

# Customization
dotchart(sold,
         pch = 19,             # Symbol
         col = hcl.colors(12), # Colors
         pt.cex = 1.5,         # Symbol size
         frame.plot = TRUE)    # Plot frame

# Labeling the observations
dotchart(sold,
         pch = 19,
         col = 4,
         pt.cex = 1.5,
         labels = month)

# Dot chart by group
# Specifying groups
dotchart(sold,
         pch = 19, pt.cex = 1.5,
         labels = month,
         groups = rev(quarter))

# Matrix as input
m <- matrix(sold, ncol = 4)
colnames(m) <- c("G1", "G2", "G3", "G4")
rownames(m) <- LETTERS[3:1]
dotchart(m, pch = 19, pt.cex = 1.5)

# Color by group
cols <- c(rep("#56B4E9", 3), rep("#009E73", 3),
          rep("#0072B2", 3), rep("#D55E00", 3))
dotchart(sold,
         pch = 19, pt.cex = 1.5,
         labels = month,
         groups = rev(quarter),
         color = cols)

dotchart(sold,
         pch = 19, pt.cex = 1.5,
         labels = month,
         groups = rev(quarter),
         color = cols,
         gdata = rev(tapply(sold, quarter, mean)),
         gpch = 12,
         gcolor = 1)

# Summary for each group
cols <- c(rep("red", 3), rep("blue", 3),
          rep("green", 3), rep("orange", 3))
dotchart(sold,
         pch = 19, pt.cex = 1.5,
         labels = month,
         groups = rev(quarter),
         color = cols,
         gdata = rev(tapply(sold, quarter, mean)))

# Order the values
cols <- c(rep("#56B4E9", 3), rep("#009E73", 3),
          rep("#0072B2", 3), rep("#D55E00", 3))
dotchart(sort(sold),
         labels = month[order(sold)],
         pch = 19, pt.cex = 1.5,
         groups = rev(quarter),
         color = cols)
