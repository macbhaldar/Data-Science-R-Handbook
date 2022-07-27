library(ggwordcloud)
library(ggforce)

df <- thankyou_words_small

set.seed(1)
ggplot(df, aes(label = word)) +
  geom_text_wordcloud() +
  theme_minimal()

# Size of the text based on a variable
set.seed(1)
ggplot(df, aes(label = word, size = speakers)) +
  geom_text_wordcloud() +
  theme_minimal()

# Basic word cloud with base R syntax
set.seed(1)
ggwordcloud(words = df$word, freq = df$speakers)

# Scaling (font size)
set.seed(1)
ggplot(df, aes(label = word, size = speakers)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 20) +
  theme_minimal()

# Removing texts that not fit
set.seed(1)
ggplot(df, aes(label = word, size = speakers)) +
  geom_text_wordcloud(rm_outside = TRUE) +
  scale_size_area(max_size = 60) +
  theme_minimal()

# Text rotation
# Data
df <- thankyou_words_small
df$angle <- sample(c(0, 45, 60, 90, 120, 180), nrow(df), replace = TRUE)

ggplot(df, aes(label = word, size = speakers, angle = angle)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 20) +
  theme_minimal()


# Shape of the word cloud

# Diamond shape
# Data
df <- thankyou_words_small

set.seed(1)
ggplot(df, aes(label = word, size = speakers)) +
  geom_text_wordcloud(shape = "diamond") +
  scale_size_area(max_size = 20) +
  theme_minimal()

# Star shape
set.seed(1)
ggplot(df, aes(label = word, size = speakers)) +
  geom_text_wordcloud(shape = "star") +
  scale_size_area(max_size = 20) +
  theme_minimal()

# Using a mask
mask_png <- png::readPNG(system.file("extdata/hearth.png",
                                     package = "ggwordcloud", mustWork = TRUE))

set.seed(1)
ggplot(df, aes(label = word, size = speakers)) +
  geom_text_wordcloud(mask = mask_png) +
  scale_size_area(max_size = 20) +
  theme_minimal()


# Color of the texts
# Unique color
# Data
df <- thankyou_words_small

set.seed(1)
ggplot(df, aes(label = word, size = speakers)) +
  geom_text_wordcloud(color = "red") +
  scale_size_area(max_size = 20) +
  scale_color_discrete("red") +
  theme_minimal()

# Color based on variable
set.seed(1)
ggplot(df, aes(label = word, size = speakers, color = name)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 20) +
  theme_minimal()

# Color gradient
set.seed(1)
ggplot(df, aes(label = word, size = speakers, color = speakers)) +
  geom_text_wordcloud() +
  scale_size_area(max_size = 20) +
  theme_minimal() +
  scale_color_gradient(low = "darkred", high = "red")
