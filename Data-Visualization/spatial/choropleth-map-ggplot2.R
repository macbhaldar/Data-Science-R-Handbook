library(sf)
library(dplyr)
library(ggplot2)
library(giscoR)

# Year
year_ref <- 2016

# Data
nuts2 <- gisco_get_nuts(year = year_ref,
                        resolution = 20,
                        nuts_level = 2) %>%
  select(NUTS_ID, NAME_LATN)

# Base map
ggplot(nuts2) +
  geom_sf() 

# Limits and projection
# Transform the shape
nuts2_3035 <- st_transform(nuts2, 3035)

ggplot(nuts2_3035) +
  geom_sf() +
  xlim(c(2200000, 7150000)) +
  ylim(c(1380000, 5500000)) 

# Join map and data
# Filter to select data from 2016
disp_income <- giscoR::tgs00026 %>%
  filter(time == year_ref) %>%
  select(-time)

nuts2_3035_data <- nuts2_3035 %>%
  left_join(disp_income, by = c("NUTS_ID" = "geo"))

# Basic choropleth map

# Default colors
ggplot(nuts2_3035_data) +
  geom_sf(aes(fill = values)) +
  xlim(c(2200000, 7150000)) +
  ylim(c(1380000, 5500000)) 

# Lines customization
ggplot(nuts2_3035_data) +
  geom_sf(aes(fill = values), 
          color = "white",
          linetype = 1,
          lwd = 0.25) +
  xlim(c(2200000, 7150000)) +
  ylim(c(1380000, 5500000)) 

# Fill color customization
ggplot(nuts2_3035_data) +
  geom_sf(aes(fill = values),
          color = NA) +
  xlim(c(2200000, 7150000)) +
  ylim(c(1380000, 5500000)) +
  scale_fill_viridis_c(option = "B")


# Advanced choropleth map

# Get all countries and transform to the same CRS
cntries <- gisco_get_countries(year = year_ref,
                               resolution = 20) %>%
  st_transform(3035)

# Plot
choro_adv <- ggplot() +
  # First overlay with the whole world
  geom_sf(data = cntries, fill = "grey80", color = NA) +
  # Set limits
  xlim(c(2200000, 7150000)) +
  ylim(c(1380000, 5500000))

choro_adv

# Clean NAs from initial dataset
nuts2_3035_data_clean <- nuts2_3035_data %>%
  filter(!is.na(values))

# Create breaks and discretize values
br <- c(0, 10, 15, 20, 25, 30, 50) * 1000

nuts2_3035_data_clean$disp_income <- cut(nuts2_3035_data_clean$values,
                                         breaks = br,
                                         dig.lab = 5)

# Create custom labels - e.g. (0k-10k]
labs <- c(0, 10, 15, 20, 25, 30, 50)
labs_plot <- paste0("(", labs[1:6], "k-", labs[2:7], "k]")

# Palette
pal <- hcl.colors(6, "Inferno", rev = TRUE, alpha = 0.7)

# Add overlay
choro_adv +
  # Add choropleth overlay
  geom_sf(data = nuts2_3035_data_clean,
          aes(fill = disp_income), color = NA) +
  # Labs
  labs(title = "Disposable income of private households",
       subtitle = "NUTS2 regions (2016)",
       caption = "Eurostat, © EuroGeographics for the administrative boundaries",
       fill = "€") +
  # Custom palette
  scale_fill_manual(values = pal,
                    drop = FALSE,
                    na.value = "grey80",
                    label = labs_plot,
                    # Legend
                    guide = guide_legend(direction = "horizontal",
                                         nrow = 1,
                                         label.position = "bottom")) +
  # Theme
  theme_void() +
  theme(plot.caption = element_text(size = 7, face = "italic"),
        legend.position = "bottom")
