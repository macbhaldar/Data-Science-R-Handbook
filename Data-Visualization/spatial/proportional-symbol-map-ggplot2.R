library(giscoR)
library(dplyr)
library(sf)
library(ggplot2)

epsg_code <- 3035

# European countries
EU_countries <- gisco_get_countries(region = "EU") %>%
  st_transform(epsg_code)

# Countries centroids
symbol_pos <- st_centroid(EU_countries, of_largest_polygon = TRUE)

# Countries airports
airports <- gisco_get_airports(country = EU_countries$ISO3_CODE) %>%
  st_transform(epsg_code)


# Plot
ggplot(EU_countries) +
  geom_sf() +
  xlim(c(2200000, 7150000)) +
  ylim(c(1380000, 5500000)) +
  # Airports
  geom_sf(data = airports,
          pch = 3,
          cex = 1,
          color = "red") +
  # Labels position (centroids)
  geom_sf(data = symbol_pos, color = "blue")


# Data Wrangling

number_airport <- airports %>%
  st_drop_geometry() %>%
  group_by(CNTR_CODE) %>%
  summarise(n = n())

labels_n <-
  symbol_pos %>%
  left_join(number_airport,
            by = c("CNTR_ID" = "CNTR_CODE")) %>%
  arrange(desc(n))

# Basic proportional symbol map
ggplot() +
  geom_sf(data = EU_countries, fill = "grey40") +
  geom_sf(data = labels_n,
          pch = 21,
          aes(size = n),
          fill = alpha("red", 0.7),
          col = "grey20") +
  xlim(c(2200000, 7150000)) +
  ylim(c(1380000, 5500000)) +
  labs(size = "No. airports") +
  scale_size(range = c(1, 9))

# Advanced proportional symbol map
# Bubble choropleth map
ggplot() +
  geom_sf(data = EU_countries, fill = "grey95") +
  geom_sf(
    data = labels_n,
    pch = 21,
    aes(size = n, fill = n),
    col = "grey20") +
  xlim(c(2200000, 7150000)) +
  ylim(c(1380000, 5500000)) +
  scale_size(
    range = c(1, 9),
    guide = guide_legend(
      direction = "horizontal",
      nrow = 1,
      label.position = "bottom")) +
  scale_fill_gradientn(colours = hcl.colors(5, "RdBu",
                                            rev = TRUE,
                                            alpha = 0.9)) +
  guides(fill = guide_legend(title = "")) +
  labs(title = "Airports by Country (2013)",
       sub = "European Union",
       caption = gisco_attributions(),
       size = "") +
  theme_void() +
  theme(legend.position = "bottom")
