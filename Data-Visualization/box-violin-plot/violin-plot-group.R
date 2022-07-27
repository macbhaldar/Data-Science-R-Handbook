library("vioplot")

df <- chickwts

vioplot(weight ~ feed, data = df)

# Equivalent to:
vioplot(df$weight ~ df$feed)

# Horizontal violin plots
vioplot(df$weight ~ df$feed,
        horizontal = TRUE)

# Violin sides
vioplot(df$weight ~ df$feed,
        side = "right") # or "left"

# Violin plot colors
vioplot(weight ~ feed, data = df,
        col = c("#bef7ff", "#a6e2ff", "#8eccff",
                "#75b7ff", "#5da1ff", "#458cff"))

# Border color
vioplot(weight ~ feed, data = df,
        col = c("#bef7ff", "#a6e2ff", "#8eccff",
                "#75b7ff", "#5da1ff", "#458cff"),
        border = NA)
