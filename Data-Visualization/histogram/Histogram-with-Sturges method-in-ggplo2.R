library(ggplot2)

# Data
set.seed(3)
x <- rnorm(450)
df <- data.frame(x)

# Default histogram ggplot2
ggplot(df, aes(x = x)) + 
  geom_histogram()

# Default histogram base R
hist(x)

# Sturges method
# Calculating the Sturges bins
breaks <- pretty(range(x),
                 n = nclass.Sturges(x),
                 min.n = 1)
df$breaks <- breaks

# Histogram with Sturges method
ggplot(df, aes(x = x)) + 
  geom_histogram(color = 1, fill = "white",
                 breaks = breaks) +
  ggtitle("Sturges method")
