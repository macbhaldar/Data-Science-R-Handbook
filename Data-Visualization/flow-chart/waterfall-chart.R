library(ggalluvial)
library(waterfalls)
library(ggplot2)


group <- LETTERS[1:6]
value <- c(2000, 4000, 2000,
           -1500, -1000, -2500)
df <- data.frame(x = group, y = value) 

waterfall(df)

# Equivalent to:
waterfall(values = value, labels = group)

# Calculate the total
waterfall(df, calc_total = TRUE)

# Rectangles width
waterfall(df, rect_width = 0.4)

# Remove lines between rectangles
waterfall(df, draw_lines = FALSE)

# Lines type
waterfall(df, linetype = 1)

# Fill the rectangles with custom colors
waterfall(df,
          fill_by_sign = FALSE,
          fill_colours = 2:7)

# Total rectangle colors
waterfall(df, calc_total = TRUE,
          total_rect_color = "orange",
          total_rect_text_color = "white")

# Border color
waterfall(df, rect_border = NA)

# Change the theme
waterfall(df) +
  theme_minimal()
