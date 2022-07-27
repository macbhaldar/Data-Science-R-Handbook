library(ggplot2)

# Data
set.seed(14012021)
x <- rnorm(200, mean = 4)
df <- data.frame(x)

# Basic density plot in ggplot2
ggplot(df, aes(x = x)) +
  geom_density()

# color, width or type
ggplot(df, aes(x = x)) +
  geom_density(color = 4,
               lwd = 1,
               linetype = 1)

# fill the area and transparency
ggplot(df, aes(x = x)) +
  geom_density(color = 4,
               fill = 4,
               alpha = 0.25)

# Smoothing parameter selection
# Bandwidth multiplier
ggplot(df, aes(x = x)) +
  geom_density(adjust = 1.75)

# Scott bandwidth
ggplot(df, aes(x = x)) +
  geom_density(bw = "nrd")

# Unbiased cross validation method
ggplot(df, aes(x = x)) +
  geom_density(bw = "ucv")

# Biased cross validation method
ggplot(df, aes(x = x)) +
  geom_density(bw = "bcv")

# Sheather & Jones method
ggplot(df, aes(x = x)) +
  geom_density(bw = "SJ")


# Kernel selection
## "gaussian" (default), "rectangular", "triangular", "epanechnikov", 
## "biweight", "cosine" and "optcosine"

# Rectangular kernel
ggplot(df, aes(x = x)) +
  geom_density(kernel = "rectangular")

ggplot(df, aes(x = x)) +
  geom_density(kernel = "cosine")
