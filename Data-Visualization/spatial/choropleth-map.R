library(sf)
library(dplyr)
library(giscoR)

year_ref <- 2013

nuts2_IT <- gisco_get_nuts(
  year = year_ref,
  resolution = 20, 
  nuts_level = 2,
  country = "Italy") %>%
  select(NUTS_ID, NAME_LATN)

plot(st_geometry(nuts2_IT))

# Projection
nuts2_IT_32632 <- st_transform(nuts2_IT, 32632)
plot(st_geometry(nuts2_IT_32632))

# Join map and data
# Filter to select data from 2013
disp_income <- giscoR::tgs00026 %>%
  filter(time == year_ref) %>%
  select(-time)

nuts2_IT_32632_data <- nuts2_IT_32632 %>%
  left_join(disp_income, by = c("NUTS_ID" = "geo"))


# Basic choropleth map
plot(nuts2_IT_32632_data[, "values"],
     breaks = "jenks",
     main = "Choropleth map")

plot(nuts2_IT_32632_data[, "values"],
     breaks = "jenks",
     nbreaks = 10,
     pal = hcl.colors(10),
     main = "Choropleth map") 


# Advanced choropleth map
# Get all countries and transform to the EU CRS
cntries <- gisco_get_countries(
  year = year_ref,
  resolution = 20) %>%
  st_transform(3035)

# Plot
plot(st_geometry(cntries),
     col = "grey80", border = NA,
     xlim = c(4600000, 4700000),
     ylim = c(1500000, 2600000))

# Clean NAs from  initial dataset
nuts2_IT_32632_data_clean <- nuts2_IT_32632_data %>%
  filter(!is.na(values))

# Create breaks and discretize values
br <- c(10, 12, 14, 16, 18, 20) * 1000

nuts2_IT_32632_data_clean$disp_income <-
  cut(nuts2_IT_32632_data_clean$values,
      breaks = br, dig.lab = 5)

# Create custom labels - e.g. (0k-10k]
labs <- c(10, 12, 14, 16, 18, 20)
labs_plot <- paste0("(", labs[1:5], "k-", labs[2:6], "k]")

# Palette
pal <- hcl.colors(6, "Spectral", rev = TRUE, alpha = 0.75)

# Base plot
plot(st_geometry(cntries),
     col = "grey80",
     border = NA,
     xlim = c(4600000, 4700000),
     ylim = c(1500000, 2600000),
     main = "Disposable income of private households")
mtext("Italy NUTS2 regions (2013)", side = 3, adj = 0)

# Overlay
plot(st_transform(nuts2_IT_32632_data_clean[, "disp_income"],
                  crs = 3035), # Transform to the European CRS
     border = NA,
     pal = pal,
     categorical = TRUE,
     add = TRUE)

# Legend
legend(x = "topright",
       title = "€/household",
       cex = 0.9,
       bty = "n",
       inset = 0.02,
       y.intersp = 1.5,
       legend = labs_plot,
       fill = pal)
