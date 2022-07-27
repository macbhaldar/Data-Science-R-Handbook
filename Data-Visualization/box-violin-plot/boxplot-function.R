set.seed(7)
x <- rnorm(200)

boxplot(x)
boxplot(x, horizontal = TRUE)

# Confidence interval (notch)
boxplot(x, notch = TRUE)

# Fill color
boxplot(x, col = rgb(0, 0.5, 1, alpha = 0.5))

# Border color
boxplot(x, col = "white", 
        border = 4)

# Box line type
boxplot(x, col = "white", 
        lty = 2)

# Box customization
boxplot(x,
        boxwex = 0.5, # Box width
        boxlty = 1,   # Box line type
        boxlwd = 3,   # Box line width
        boxcol = 2,   # Box border color
        boxfill = 4)  # Box fill color

# Median line customization
boxplot(x,
        medlty = 2,  # Line type of the median
        medlwd = 2,  # Line width of the median
        medpch = 21, # pch symbol of the point
        medcex = 2,  # Size of the point
        medcol = 1,  # Color of the line
        medbg = 4)   # Color of the pch (21 to 25)

# Whiskers and staple customization
boxplot(x,
        whisklty = 2,       # Line type of the whiskers
        whisklwd = 2,       # Line width of the whiskers
        whiskcol = "red",   # Color of the whiskers
        staplelty = 3,      # Line type of the staples
        staplelwd = 2,      # Line width of the staples
        staplecol = "blue") # Color of the staples

# Outliers customization
boxplot(x,
        outlty = 0,  # Line type
        outlwd = 1,  # Line width
        outpch = 23, # Pch for the outliers
        outcex = 2,  # Size of the outliers
        outcol = 1,  # Color
        outbg = 4)   # bg color (pch 21 to 25)
