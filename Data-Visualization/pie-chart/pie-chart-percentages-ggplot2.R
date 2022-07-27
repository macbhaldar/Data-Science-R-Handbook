library(dplyr)
library(ggplot2)

set.seed(11022021)

# Variables
ans <- sample(c("Yes", "No", "N/A"),
              size = 100, replace = TRUE,
              prob = c(0.4, 0.35, 0.25))
gen <- sample(c("Male", "Female"),
              size = 100, replace = TRUE)

# Change the levels of the variable
# so "Yes" appears first in the legend
ans <- factor(ans, levels = c("Yes", "No", "N/A"))

# Data frame
data <- data.frame(answer = ans,
                   gender = gen)


# Data transformation
df <- data %>% 
  group_by(answer) %>% # Variable to be transformed
  count() %>% 
  ungroup() %>% 
  mutate(perc = `n` / sum(`n`)) %>% 
  arrange(perc) %>%
  mutate(labels = scales::percent(perc))

# Pie chart with percentages
ggplot(df, aes(x = "", y = perc, fill = answer)) +
  geom_col() +
  coord_polar(theta = "y")

# Adding the percentage labels of the pie chart
ggplot(df, aes(x = "", y = perc, fill = answer)) +
  geom_col() +
  geom_text(aes(label = labels),
            position = position_stack(vjust = 0.5)) +
  coord_polar(theta = "y")

ggplot(df, aes(x = "", y = perc, fill = answer)) +
  geom_col() +
  geom_label(aes(label = labels),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE) +
  coord_polar(theta = "y")

# Further customization
ggplot(df, aes(x = "", y = perc, fill = answer)) +
  geom_col(color = "black") +
  geom_label(aes(label = labels), color = c(1, "white", "white"),
             position = position_stack(vjust = 0.5),
             show.legend = FALSE) +
  guides(fill = guide_legend(title = "Answer")) +
  scale_fill_viridis_d() +
  coord_polar(theta = "y") + 
  theme_void()
