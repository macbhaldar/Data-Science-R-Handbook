library(ggplot2)

# Data
set.seed(05022021)
x <- rnorm(600)
df <- data.frame(x)

# Default histogram
ggplot(df, aes(x = x)) + 
  geom_histogram()

ggplot(df, aes(x = x)) + 
  geom_histogram(colour = 4, fill = "white", 
                 bins = 15)

ggplot(df, aes(x = x)) + 
  geom_histogram(colour = 4, fill = "white", 
                 bins = 50)

# binwidth argument
# Binwidth of 0.5
ggplot(df, aes(x = x)) + 
  geom_histogram(colour = 4, fill = "white", 
                 binwidth = 0.5)

# Binwidth of 0.15
ggplot(df, aes(x = x)) + 
  geom_histogram(colour = 4, fill = "white", 
                 binwidth = 0.15)

