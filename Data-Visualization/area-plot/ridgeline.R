# install.packages("remotes")
# remotes::install_github("R-CoderDotCom/ridgeline@main")

library(ridgeline)

ridgeline(chickwts$weight, chickwts$feed)

# ridgeline bandwidth selection
ridgeline(chickwts$weight, chickwts$feed,
          bw = 100)

# ridgeline color palette
ridgeline(chickwts$weight, chickwts$feed,
          palette = hcl.colors(6, palette = "viridis",
                               alpha = 0.85)) 

# Border
ridgeline(chickwts$weight, chickwts$feed,
          palette = hcl.colors(6, palette = "viridis",
                               alpha = 0.85),
          border = hcl.colors(6, palette = "viridis",
                              alpha = 0.85))

# Custom labels
ridgeline(chickwts$weight, chickwts$feed,
          labels = LETTERS[1:6])

# Displaying the mode
ridgeline(chickwts$weight, chickwts$feed,
          mode = TRUE)
