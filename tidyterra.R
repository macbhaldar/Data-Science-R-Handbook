data("volcano")
image(volcano, col = terrain.colors(256, rev = TRUE))

# Libraries
library(terra)
library(ggplot2)
library(tidyterra)
library(maptiles)
library(sf)

# location of Maungawhau

box <- c(
  174.7611552780,
  -36.8799200525,
  174.7682380109,
  -36.8719519780
)
class(box) <- "bbox"
box <- st_as_sfc(box)
st_crs(box) <- 4326

box <- box %>%
  # To crs for NZGD49
  st_transform(27200)

tile <- get_tiles(box, crop = TRUE, zoom = 16)


ggtile <- ggplot() +
  geom_spatraster_rgb(data = tile)

ggtile

volcano_rast <- rast(volcano)

terra::plot(volcano_rast)

# Wait, it is flipped!
volcano_rast_ok <- rast(volcano[seq(nrow(volcano), 1, -1), ])

# Much better!
terra::plot(volcano_rast_ok)

volcano_rast_ok
#> class       : SpatRaster 
#> dimensions  : 87, 61, 1  (nrow, ncol, nlyr)
#> resolution  : 1, 1  (x, y)
#> extent      : 0, 61, 0, 87  (xmin, xmax, ymin, ymax)
#> coord. ref. :  
#> source      : memory 
#> name        : lyr.1 
#> min value   :    94 
#> max value   :   195
#> 

# Extra length for proper handling extent
xrange <- range(seq(from = 2667400, length.out = 62, by = 10))
yrange <- range(seq(from = 6478700, length.out = 88, by = 10))

template <- rast(
  crs = "EPSG:27200",
  xmin = xrange[1],
  xmax = xrange[2],
  ymin = yrange[1],
  ymax = yrange[2],
  resolution = 10
)
template
#> class       : SpatRaster 
#> dimensions  : 87, 61, 1  (nrow, ncol, nlyr)
#> resolution  : 10, 10  (x, y)
#> extent      : 2667400, 2668010, 6478700, 6479570  (xmin, xmax, ymin, ymax)
#> coord. ref. : NZGD49 / New Zealand Map Grid (EPSG:27200)
#> 

# Use tidyterra for pull the values of one raster
# and create a new layer

volcano2 <- template %>%
  mutate(elevation = pull(volcano_rast_ok, lyr.1)) %>%
  select(elevation)

volcano2
#> class       : SpatRaster 
#> dimensions  : 87, 61, 1  (nrow, ncol, nlyr)
#> resolution  : 10, 10  (x, y)
#> extent      : 2667400, 2668010, 6478700, 6479570  (xmin, xmax, ymin, ymax)
#> coord. ref. : NZGD49 / New Zealand Map Grid (EPSG:27200) 
#> source      : memory 
#> name        : elevation 
#> min value   :        94 
#> max value   :       195

terra::plot(volcano2)

# And plot it
ggtile +
  geom_spatraster(data = volcano2) +
  scale_fill_terrain_c(alpha = 0.75)

# Load out Easter Egg

volcano2_easter <- rast(system.file("extdata/volcano2.tif", package = "tidyterra"))

volcano2_easter
#> class       : SpatRaster 
#> dimensions  : 87, 61, 1  (nrow, ncol, nlyr)
#> resolution  : 10, 10  (x, y)
#> extent      : 2667400, 2668010, 6478700, 6479570  (xmin, xmax, ymin, ymax)
#> coord. ref. : NZGD49 / New Zealand Map Grid (EPSG:27200) 
#> source      : volcano2.tif 
#> name        : elevation 
#> min value   :  81.07246 
#> max value   :  187.2323
terra::plot(volcano2_easter)

# Only altitudes of more than 130m

volcano_filter <- volcano2_easter %>% filter(elevation > 130)


ggtile +
  geom_spatraster(data = volcano_filter) +
  scale_fill_viridis_c(na.value = NA, alpha = 0.7) +
  labs(fill = "Elevation (m)")

# Contour lines

ggtile +
  geom_spatraster_contour(data = volcano2_easter, binwidth = 10)

# Contour lines + contour polygons

ggtile +
  geom_spatraster_contour_filled(
    data = volcano2_easter,
    breaks = seq(80, 200, 10),
    alpha = 0.5
  ) +
  geom_spatraster_contour(
    data = volcano2_easter, binwidth = 2.5,
    alpha = 0.7, size = .2, color = "black"
  ) +
  coord_sf(expand = FALSE)

