library(ggplot2)

# Data
set.seed(8)
y <- rnorm(200)
df <- data.frame(y)

# Basic box plot
ggplot(df, aes(x = "", y = y)) + 
  geom_boxplot() +
  geom_jitter()

# removing the outliers of the box plot
ggplot(df, aes(x = "", y = y)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter()

# flip the axes
ggplot(df, aes(x = "", y = y)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter() +
  coord_flip()

# Customization of the jittered points

# width
ggplot(df, aes(x = "", y = y)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(width = 0.2)

# colour
ggplot(df, aes(x = "", y = y)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(colour = 2)

# shape and size
ggplot(df, aes(x = "", y = y)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(shape = 17, size = 2)

# Jitter by group
set.seed(8)
y <- rnorm(200)
group <- sample(LETTERS[1:3], size = 200,
                replace = TRUE)
df <- data.frame(y, group)

# Box plot by group with jitter
ggplot(df, aes(x = group, y = y)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter()

# Jitter by group with custom color
ggplot(df, aes(x = group, y = y)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(colour = 2)

# Jitter by group with color by group
ggplot(df, aes(x = group, y = y, colour = group)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter()

# Jitter by group with custom shape
ggplot(df, aes(x = group, y = y,
               colour = group,
               shape = group)) + 
  geom_boxplot(outlier.shape = NA) +
  geom_jitter()
