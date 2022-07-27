library(ggplot2)
library(dplyr)

set.seed(11022021)

# Variables
ans <- sample(c("Yes", "No", "N/A"),
              size = 100, replace = TRUE,
              prob = c(0.4, 0.35, 0.25))
gen <- sample(c("Male", "Female"),
              size = 100, replace = TRUE)

# Change the levels of the variable so "Yes" appears first in the legend
ans <- factor(ans, levels = c("Yes", "No", "N/A"))

# Data frame
data <- data.frame(answer = ans, gender = gen)

# Data transformation
df <- data %>% group_by(answer) %>% count() %>% ungroup() %>% 
  mutate(perc = `n` / sum(`n`)) %>% arrange(perc) %>% 
  mutate(labels = scales::percent(perc))

ggplot(df, aes(x = "", y = perc, fill = answer)) +
  geom_col(color = "black") +
  geom_text(aes(label = labels), color = c("white", "red", "black"),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE) +
  guides(fill = guide_legend(title = "Answer")) +
  scale_fill_brewer() +  # brewer, discrete, grey, hue, ordinal, viridis_d
  coord_polar(theta = "y") + 
  theme_void()
