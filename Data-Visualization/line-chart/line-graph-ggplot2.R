library(ggplot2)

# Data
set.seed(1)
x <- 1:20
y <- x ^ 2 + runif(20, 0, 100)
df <- data.frame(x = x, y = y)

ggplot(df, aes(x = x, y = y)) +
  geom_line()

# Adding points
ggplot(df, aes(x = x, y = y)) +
  geom_line() +
  geom_point()

# Line as an arrow
ggplot(df, aes(x = x, y = y)) +
  geom_line(arrow = arrow())

# First horizontal
ggplot(df, aes(x = x, y = y)) +
  geom_step()

# First vertical
ggplot(df, aes(x = x, y = y)) +
  geom_step(direction = "vh")

# Step half-way between values
ggplot(df, aes(x = x, y = y)) +
  geom_step(direction = "mid")

# Line colors and styles
ggplot(df, aes(x = x, y = y)) +
  geom_line(color = 4,    # Color of the line
            lwd = 1,      # Width of the line
            linetype = 1) # Line type

# line type can be set with numbers (0 to 6), with texts or with string patterns
ggplot(df, aes(x = x, y = y)) +
  geom_line(color = 4,
            lwd = 1,  
            linetype = "dashed")
