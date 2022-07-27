# install.packages("waffle", repos = "https://cinc.rud.is")
library(waffle)

x <- c(30, 25, 20, 5)
waffle(x, rows = 8)


# Use a named vector to change the legend names
x <- c(G1 = 30, G2 = 25, G3 = 20, G4 = 5)
waffle(x, rows = 8)


# Color customization
x <- c(G1 = 30, G2 = 25, G3 = 20, G4 = 5)
waffle(x, rows = 8,
       colors = c("#FFEDA0", "#FEB24C", "#FC4E2A", "#BD0026")) 


# Legend position
x <- c(G1 = 30,  G2 = 25, G3 = 20, G4 = 5)
waffle(x, rows = 8,
       legend_pos = "bottom")


# Combining square pie charts
w1 <- waffle(c(A = 0, B = 40), rows = 5)
w2 <- waffle(c(A = 10, B = 30), rows = 5)
iron(w1, w2)

w1 <- waffle(c(A = 0, B = 40), rows = 5, keep = FALSE)
w2 <- waffle(c(A = 10, B = 30), rows = 5, keep = FALSE)
iron(w1, w2)


# Using geom_waffle
df <- data.frame(group = LETTERS[1:3],
                 value = c(25, 20, 35))

ggplot(df, aes(fill = group, values = value)) +
  geom_waffle(n_rows = 8, size = 0.33, colour = "white") +
  scale_fill_manual(name = NULL,
                    values = c("#BA182A", "#FF8288", "#FFDBDD"),
                    labels = c("A", "B", "C")) + coord_equal() + theme_void()

geom_