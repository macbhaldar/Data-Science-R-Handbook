library(giscoR)
library(dplyr)
library(sf)

# CRS
epsg_code <- 3035

# Countries
EU_countries <- gisco_get_countries(region = "EU") %>%
  st_transform(epsg_code)



# Centroids for each country
symbol_pos <- st_centroid(EU_countries, of_largest_polygon = TRUE)

# Airports
airports <- gisco_get_airports(country = EU_countries$ISO3_CODE) %>%
  st_transform(epsg_code)

# Airports and centroids

# Plot
plot(st_geometry(EU_countries),
     xlim = c(2200000, 7150000), # Crop the map
     ylim = c(1380000, 5500000))

# Airports
plot(st_geometry(airports), pch = 3,
     cex = 1, col = "red", add = TRUE)

# Labels position
plot(st_geometry(symbol_pos), pch = 20,
     col = "blue", add = TRUE)


# Data wrangling

number_airports <- airports %>%
  st_drop_geometry() %>%
  group_by(CNTR_CODE) %>%
  summarise(n = n())

labels_n <-
  symbol_pos %>%
  left_join(number_airports,
            by = c("CNTR_ID" = "CNTR_CODE")) %>%
  arrange(desc(n)) 


# Basic proportional symbol map

# Rescale sizes with log
labels_n$size <- log(labels_n$n / 15)

plot(st_geometry(EU_countries),
     main = "Airports by country (2013)",
     sub = gisco_attributions(),
     col = "white", border = 1,
     xlim = c(2200000, 7150000),
     ylim = c(1380000, 5500000))

plot(st_geometry(labels_n),
     pch = 21, bg = 4,    # Symbol type and color
     col = 4,             # Symbol border color
     cex = labels_n$size, # Symbol sizes
     add = TRUE)

legend("right",
       xjust = 1,
       y.intersp = 1.3,
       bty = "n",
       legend = seq(100, 500, 100),
       col = "grey20",
       pt.bg = 4,
       pt.cex = log(seq(100, 500, 100) / 15),
       pch = 21,
       title = "Airports") 


# Choropleth bubble map
# Color palette
pal_init <- hcl.colors(5, "Temps", alpha = 0.8)
pal_ramp <- colorRampPalette(pal_init)

plot(st_geometry(EU_countries),
     col = "grey95",
     main = "Airports by Country (2013)",
     sub = gisco_attributions(),
     xlim = c(2200000, 7150000),
     ylim = c(1380000, 5500000))

plot(labels_n[, "n"],
     pch = 19, 
     cex = labels_n$size, # Symbol size
     pal = pal_ramp,      # Color palette
     add = TRUE)

legend("right",
       xjust = 1,
       x.intersp = 1.3,
       y.intersp = 2,
       legend = seq(100, 500, 100),
       bty = "n",
       col = "grey30",
       pt.bg = pal_init,
       pt.cex = log(seq(100, 500, 100) / 15),
       pch = 21,
       title = "") 
