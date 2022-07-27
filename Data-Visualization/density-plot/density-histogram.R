set.seed(1)
x <- rnorm(400)

# Histogram
hist(x, prob = TRUE)
hist(x, freq = FALSE) # Equivalent

# change the default fill color
hist(x,                 
     prob = TRUE,
     col = "#E1DEFC") # Color

# border color of the bars
hist(x,
     prob = TRUE,
     col = "#E1DEFC",    # Fill color
     border = "#9A68A4") # Border

# use shading lines
hist(x,
     prob = TRUE,
     col = 4,      # Color
     density = 10, # Shading lines
     angle = 20)   # Shading lines angle

# Titles and labels
hist(x,
     prob = TRUE,
     main = "Title of the histogram", # Title
     sub = "Subtitle",                # Subtitle
     xlab = "X-axis label",           # X-axis label
     ylab = "Y-axis label")           # Y-axis label 



