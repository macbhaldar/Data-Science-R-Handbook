library(ggplot2)

df <- ToothGrowth
df$dose <- as.factor(df$dose)

# option 1
ggplot(df, aes(x = dose, y = len, fill = dose)) +
  geom_violin(alpha = 0.5) +
  geom_point(position = position_jitter(seed = 1, width = 0.2)) +
  theme(legend.position = "none")

# option 2
ggplot(df, aes(x = dose, y = len, fill = dose)) +
  geom_violin(alpha = 0.5) +
  geom_jitter(position = position_jitter(seed = 1, width = 0.2)) +
  theme(legend.position = "none")

# Adding a dot plot
ggplot(df, aes(x = dose, y = len, fill = dose)) +
  geom_violin(alpha = 0.5) +
  geom_dotplot(binaxis = "y",
               stackdir = "center",
               dotsize = 0.5) +
  theme(legend.position = "none")

ggplot(df, aes(x = dose, y = len, fill = dose)) +
  geom_violin(alpha = 0.5) +
  geom_dotplot(binaxis= "y",
               stackdir = "center",
               dotsize = 0.5,
               fill = 1) +
  theme(legend.position = "none")

# Adding a beeswarm
ggplot(df, aes(x = dose, y = len, fill = dose)) +
  geom_violin(alpha = 0.5) +
  geom_beeswarm() +
  theme(legend.position = "none")

ggplot(df, aes(x = dose, y = len, fill = dose)) +
  geom_violin(alpha = 0.5) +
  geom_quasirandom() +
  theme(legend.position = "none")
