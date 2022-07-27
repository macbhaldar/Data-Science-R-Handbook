library(lessR)

# Categorical data
cat_var <- factor(c(rep("Group 1", 10),
                    rep("Group 2", 15),
                    rep("Group 3", 30),
                    rep("Group 4", 20)))

# Create a table from the data
cat <- table(cat_var)

# Pie
pie(cat,
    col = hcl.colors(length(cat), "BluYl")) 


# Piechart
cols <-  hcl.colors(length(levels(cat_var)), "Fall")
PieChart(cat_var, data = cat, hole = 0,
         fill = cols,
         labels_cex = 0.6) 
