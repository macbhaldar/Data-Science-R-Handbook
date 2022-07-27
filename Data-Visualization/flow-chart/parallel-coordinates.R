# install.packages("MASS")
library(MASS)

parcoord(df)

# Minimum and maximum values
parcoord(df, var.label = TRUE)

# Lines customization
# Color by group
cols <- as.numeric(groups)
parcoord(df, col = cols)

# Custom colors
cols <- c("#3399FF", "#FFC44C", "#FF661A")
cols <- cols[factor(groups)]
parcoord(df, col = cols)

# Highlighting a group
cols <- c("lightgray", "lightgray", 4)
cols <- cols[factor(groups)]
parcoord(df, col = cols)
