set.seed(2)
x <- rnorm(2000)

# Histogram
hist(x,
     main = "Sturges")

# Too many bins
hist(x, breaks = 80,
     main = "Too many bins")

# Not enough bins
hist(x, breaks = 5,
     main = "Not enough bins")

# Scott method
hist(x, breaks = "Scott",
     main = "Scott")

# Freedman-Diaconis (FD) method
hist(x, breaks = "Freedman-Diaconis",
     main = "Freedman-Diaconis")
hist(x, breaks = "FD", # Equivalent
     main = "Freedman-Diaconis") 

# Plug in selection
library(KernSmooth)

# Optimal bandwidth
bin_width <- dpih(x)

# Number of bins
nbins <- seq(min(x) - bin_width,
             max(x) + bin_width,
             by = bin_width)

# Histogram
hist(x, breaks = nbins,
     main = "Plug-in method")
