set.seed(1)
x <- rexp(400)

# Histogram
hist(x)

# Fill color
hist(x,       # Data
     col = 4) # Color

# Border color
hist(x,
     col = "white", # Fill color
     border = 4)    # Border

# Shading lines
hist(x,
     col = 4,      # Color
     density = 10, # Shading lines
     angle = 20)   # Shading lines angle

# Titles and labels
hist(x,
     main = "Title of the histogram", # Title
     sub = "Subtitle",                # Subtitle
     xlab = "X-axis label",           # X-axis label
     ylab = "Y-axis label")           # Y-axis label
