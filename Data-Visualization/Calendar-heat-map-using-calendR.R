# install.packages(calendR)
library(calendR)

# Data 1
set.seed(2)
data <- rnorm(365)

# Calendar
calendR(year = 2021,
        special.days = data,
        gradient = TRUE,
        low.col = "#FFFFED",
        special.col = "#FF0000") 

calendR(year = 2021,
        special.days = data,
        gradient = TRUE,
        low.col = "#FCFFDD",
        special.col = "#00AAAE",
        legend.pos = "right",
        legend.title = "Title")

# Vertical calendar
calendR(year = 2021,
        special.days = data,
        low.col = "#FCFFDD",
        special.col = "#00AAAE",
        gradient = TRUE,
        legend.pos = "right",
        orientation = "portrait")

# Data 2
data <- rnorm(30, 15, 10)

# Create a vector where all the values are a bit
# lower than the lowest value of your data
days <- rep(min(data) - 0.05, 365)

# Fill the days you want with your data
days[30:59] <- data

calendR(year = 2021,
        special.days = days,
        low.col = "white",
        special.col = "#FF0000",
        gradient = TRUE,
        legend.pos = "bottom")
