library(ggplot2)

df <- as.data.frame(EuStockMarkets[, 1:3])

# Area chart
ggplot(df, aes(x = seq_along(SMI), y = SMI)) + 
  geom_area()

# Fill the area
ggplot(df, aes(x = seq_along(SMI), y = SMI)) + 
  geom_area(fill = 4)

# Transparency of the area
ggplot(df, aes(x = seq_along(SMI), y = SMI)) + 
  geom_area(fill = 4,
            alpha = 0.5)

# Line customization
ggplot(df, aes(x = seq_along(SMI), y = SMI)) + 
  geom_area(fill = 4,
            alpha = 0.5,
            color = 1,    # Line color
            lwd = 0.5,    # Line width
            linetype = 1) # Line type

# Area chart of several lines
ggplot(df) + 
  geom_area(aes(x = seq_along(SMI), y = SMI),
            fill = 4, alpha = 0.85) +
  geom_area(aes(x = seq_along(DAX), y = DAX),
            fill = 3, alpha = 0.85)
