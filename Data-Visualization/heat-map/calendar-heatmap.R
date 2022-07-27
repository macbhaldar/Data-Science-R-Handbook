library(calendR)

# Calendar as a heat map
set.seed(2)
data <- rnorm(365)

# Calendar
calendR(year = 2021,
        special.days = data,
        gradient = TRUE,
        low.col = "#FFFFED",
        special.col = "#FF0000") 

# legend position and legend title
calendR(year = 2021,
        special.days = data,
        gradient = TRUE,
        low.col = "#FCFFDD",
        special.col = "#00AAAE",
        legend.pos = "right",
        legend.title = "Title")


# Heat map on certain days
data <- rnorm(30, 15, 10)
days <- rep(min(data) - 0.05, 365)
days[30:59] <- data       # Fill the days you want with your data
calendR(year = 2021,
        special.days = days,
        low.col = "white",
        special.col = "#FF0000",
        gradient = TRUE,
        legend.pos = "bottom")

# Calendar orientation
# Vertical calendar
set.seed(2)
data <- rnorm(365)
calendR(year = 2021,
        special.days = data,
        low.col = "#FCFFDD",
        special.col = "#00AAAE",
        gradient = TRUE,
        legend.pos = "right",
        orientation = "portrait")


# Monthly calendar as a heat map
data <- runif(31)
calendR(year = 2021,
        month = 10,
        special.days = data,
        gradient = TRUE,
        low.col = "white",
        special.col = "#FF4600")

# Adding a legend
data <- runif(31)
calendR(year = 2021,
        month = 10,
        special.days = data,
        gradient = TRUE,
        low.col = "white",
        special.col = "#FF4600",
        legend.pos = "bottom",
        legend.title = "Title")

# Heat map on certain days
data <- runif(5)
days <- rep(min(data) - 0.05, 31)
days[10:14] <- data
calendR(year = 2021,
        month = 10,
        special.days = days,
        gradient = TRUE,
        low.col = "white",
        special.col = "#FF4600",
        legend.pos = "bottom")
