library(palmerpenguins)

x <- penguins$flipper_length_mm
g <- as.factor(penguins$species)

p <- data.frame(Flipper.length = x, species = g)
p <- na.omit(p)

# Density comparison with lines
library(car)

# Densities for each group
dens <- tapply(p$Flipper.length, p$species, density)

# Plot
plot(dens$Adelie, xlim = c(min(p$Flipper.length) - 10,
                           max(p$Flipper.length) + 25),
     main = "Density comparison")
lines(dens$Chinstrap, col = 2)
lines(dens$Gentoo, col = 3)

# Legend
legend("topright", legend = levels(p$species),
       lty = 1, col = 1:3)

# densityPlot function
densityPlot(p$Flipper.length ~ p$species,
            legend = list(title = "Species"),
            xlab = "Flipper length",
            xlim = c(160, 280))

# sm.density.compare function
library(sm)

sm.density.compare(x = p$Flipper.length,
                   group = p$species,
                   model = "equal")
