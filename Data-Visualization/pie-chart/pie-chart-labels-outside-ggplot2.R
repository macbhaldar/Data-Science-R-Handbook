library(ggplot2)
library(ggrepel)
library(tidyverse)

df <- data.frame(value = c(15, 25, 32, 28),
                 group = paste0("G", 1:4))

df2 <- df %>% 
  mutate(csum = rev(cumsum(rev(value))), 
         pos = value/2 + lead(csum, 1),
         pos = if_else(is.na(pos), value/2, pos))

ggplot(df, aes(x = "" , y = value, fill = fct_inorder(group))) +
  geom_col(width = 1, color = 1) +
  coord_polar(theta = "y") +
  scale_fill_brewer(palette = "Pastel1") +
  geom_label_repel(data = df2,
                   aes(y = pos, label = paste0(value, "%")),
                   size = 4.5, nudge_x = 1, show.legend = FALSE) +
  guides(fill = guide_legend(title = "Group")) +
  theme_void()


# Pie chart with values inside and labels outside
ggplot(df, aes(x = "", y = value, fill = fct_inorder(group))) +
  geom_col(width = 1, color = 1) +
  geom_text(aes(label = value),
            position = position_stack(vjust = 0.5)) +
  coord_polar(theta = "y") +
  guides(fill = guide_legend(title = "Group")) +
  scale_y_continuous(breaks = df2$pos, labels = df$group) +
  theme(axis.ticks = element_blank(),
        axis.title = element_blank(),
        axis.text = element_text(size = 15), 
        legend.position = "none", # Removes the legend
        panel.background = element_rect(fill = "white"))
