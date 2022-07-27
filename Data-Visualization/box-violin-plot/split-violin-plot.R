library("vioplot")

df <- trees

# Side by side comparison

# Split the data in two groups
big_vol <- df[df$Volume >= mean(df$Volume), ]
small_vol <- df[df$Volume < mean(df$Volume), ]

# Plot each side and join them
vioplot(big_vol,
        plotCentre = "line", # Median with a line
        side = "right",   # Right side
        col = "#5773CC")  # Color for the right side
vioplot(small_vol,
        plotCentre = "line", # Median with a line
        side = "left",     # Left side
        col = "#FFB900",   # Color for the left side
        add = TRUE)        # Add it to the previous plot
legend("topleft",
       legend = c("Big", "Small"),
       fill = c("#5773CC", "#FFB900"))

# Split the data in two groups
big_vol <- df[df$Volume >= mean(df$Volume), ]
small_vol <- df[df$Volume < mean(df$Volume), ]

# Plot each side and join them
vioplot(big_vol,
        colMed = "green", # Color of the median point
        side = "right",   # Right side
        col = "#5773CC")  # Color for the right side
vioplot(small_vol,
        colMed = "green", # Color of the median point
        side = "left",    # Left side
        col = "#FFB900",  # Color for the left side
        add = TRUE)       # Add it to the previous plot

legend("topleft",
       legend = c("Big", "Small"),
       fill = c("#5773CC", "#FFB900"))
