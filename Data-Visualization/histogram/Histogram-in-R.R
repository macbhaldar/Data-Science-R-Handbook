# Create the histogram.
hist(v, xlab = "No.of Articles ",
     col = "blue", border = "black")

# Create data for the graph.
v <- c(19, 23, 11, 5, 16, 21, 32, 14, 19, 27, 39)


# Create the histogram.
hist(v, xlab = "No.of Articles", col = "red",
     border = "black", xlim = c(0, 50),
     ylim = c(0, 5), breaks = 5)

# Creating data for the graph.
v <- c(19, 23, 11, 5, 16, 21, 32, 14, 19,
       27, 39, 120, 40, 70, 90)

# Creating the histogram.
m<-hist(v, xlab = "Weight", ylab ="Frequency",
        col = "darkmagenta", border = "pink",
        breaks = 5)

# Setting labels
text(m$mids, m$counts, labels = m$counts,
     adj = c(0.5, -0.5))

# Creating data for the graph.
v <- c(19, 23, 11, 5, 16, 21, 32, 14,
       19, 27, 39, 120, 40, 70, 90)

# Creating the histogram.
hist(v, xlab = "Weight", ylab ="Frequency",
     xlim = c(50, 100),
     col = "darkmagenta", border = "pink",
     breaks = c(5, 55, 60, 70, 75,
                80, 100, 140))
