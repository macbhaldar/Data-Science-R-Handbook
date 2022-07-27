library(quantmod)

# Dates
start <- "2022-01-01"
end <- "2022-07-07"

# Get the data
getSymbols("^GSPC", 
           from = start, to = end,
           src = "yahoo")

chartSeries(GSPC)

# Styling
chartSeries(GSPC,
            theme = chartTheme("white"), # Theme
            bar.type = "hlc",  # High low close 
            up.col = "green",  # Up candle color
            dn.col = "pink")   # Down candle color

# Technical indicators
chartSeries(GSPC,
            theme = chartTheme("white"),
            name = "SP500",  
            TA = list("addBBands(n = 10)",
                      "addVo()",
                      "addEMA(20)",
                      "addEMA(10, col = 2)"))

# chart_Series function
chart_Series(GSPC)

# chart_theme function
myTheme <- chart_theme()
myTheme$col$dn.col <- "pink"
myTheme$col$dn.border <- "pink"
myTheme$col$up.col <- "green"
myTheme$col$up.border <- "green"
myTheme$rylab <- TRUE
myTheme$lylab <- FALSE

chart_Series(GSPC, theme = myTheme)

# add technical indicators 
chart_Series(GSPC,
             TA = list("add_EMA(n = 20, col = 4,
                                lwd = 2)",
                       "add_EMA(n = 5, col = 2,
                                lwd = 2)"))
