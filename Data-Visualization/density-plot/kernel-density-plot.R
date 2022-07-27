set.seed(14012021)
data <- rnorm(200, mean = 4)

# Kernel density estimation
d <- density(data)

# Kernel density plot
plot(d, lwd = 2, main = "Default kernel density plot")

# Kernel selection
# "gaussian" ,"rectangular", "triangular", "epanechnikov", 
# "biweight", "cosine" , "optcosine"

# Rectangular kernel
d <- density(data,
             kernel = "rectangular")
plot(d, lwd = 2, main = "Rectangular kernel")

# Triangular kernel
d <- density(data,
             kernel = "triangular")
plot(d, lwd = 2, main = "Triangular kernel")

# Epanechnikov kernel
d <- density(data,
             kernel = "epanechnikov")
plot(d, lwd = 2, main = "Epanechnikov kernel")

# Biweight kernel
d <- density(data,
             kernel = "biweight")
plot(d, lwd = 2, main = "Biweight kernel")

# Cosine kernel
d <- density(data,
             kernel = "cosine")
plot(d, lwd = 2, main = "Cosine kernel")

# Rule-of-thumb variation given by Scott
d <- density(data,
             bw = "nrd")
plot(d, lwd = 2, main = "nrd bandwidth")

# Unbiased cross-validation
d <- density(data,
             bw = "ucv")
plot(d, lwd = 2, main = "ucv bandwidth")

# Biased cross-validation
d <- density(data,
             bw = "bcv")
plot(d, lwd = 2, main = "bcv bandwidth")

# Methods by Sheather & Jones 
d <- density(data,
             bw = "SJ")
plot(d, lwd = 2, main = "SJ bandwidth")
