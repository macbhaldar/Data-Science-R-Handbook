library(ggplot2)

df <- ToothGrowth
df$dose <- as.factor(df$dose)

# Mean as a point
ggplot(df, aes(x = dose, y = len)) +
  geom_violin() + 
  stat_summary(fun = "mean",
               geom = "point",
               color = "red")

# Mean as a line
ggplot(df, aes(x = dose, y = len)) +
  geom_violin() + 
  stat_summary(fun = "mean",
               geom = "crossbar", 
               width = 0.5,
               colour = "red")

# Mean as a crossbar
ggplot(df, aes(x = dose, y = len)) +
  geom_violin() + 
  stat_summary(fun.data = "mean_cl_boot", geom = "crossbar",
               colour = "red", width = 0.2)

# Mean as a pointrange
ggplot(df, aes(x = dose, y = len)) +
  geom_violin() + 
  stat_summary(fun.data = "mean_cl_boot", geom = "pointrange",
               colour = "red")

# Mean and median
ggplot(df, aes(x = dose, y = len)) +
  geom_violin() + 
  stat_summary(fun = "mean",
               geom = "point",
               color = "red") +
  stat_summary(fun = "median",
               geom = "point",
               color = "blue")

# Mean and median (with legend)
ggplot(df, aes(x = dose, y = len)) +
  geom_violin() + 
  stat_summary(fun = "mean",
               geom = "point",
               aes(color = "Mean")) +
  stat_summary(fun = "median",
               geom = "point",
               aes(color = "Median")) +
  scale_colour_manual(values = c("red", "blue"), # Colors
                      name = "") # Remove the legend title
