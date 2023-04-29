library(ggplot2)
library(maptools)
library(rgeos)
library(ggmap)
library(scales)
library(RColorBrewer)

set.seed(8000)


shp <- readShapeSpatial('shapefile/outlines.shp')
plot(shp)

shp_mah <- readShapeSpatial('shapefile/India/IND_adm1.shp')
plot(shp_mah)



# If you want to Look into the shapefile attributes and content names remove # and run the code, otherwise skip the code
names(shp)
print(shp$ST_NM)

# Craete a csv file with attribute name ST_NM and then read the csv
imr=read.csv('IMR_R.csv')

#Fortify shape into a dataframe
shp.f <- fortify(shp, region = "ST_NM")

# Merge shapefile with csv file
merge.shp.coef<-merge(shp.f,imr, by="id", all.x=TRUE)
final.plot<-merge.shp.coef[order(merge.shp.coef$order), ]

# Creating and save the map (to save the map remove #)
ggplot()+geom_polygon(data = final.plot,aes(x = long, y = lat, group = group, fill = count),color = "black", size = 0.25) + coord_map()

#ggsave("India_IMR_2013_BLUE.png",dpi = 300, width = 20, height = 20, units = "cm")

# Creating a map with different color
ggplot() +
  geom_polygon(data = final.plot,
               aes(x = long, y = lat, group = group, fill = count), 
               color = "black", size = 0.25) + 
  coord_map()+
  scale_fill_distiller(name="IMR", palette = "YlGn")+
  labs(title="IMR of Different States of India")+
  xlab('Longitude')+
  ylab('Latitude')

#ggsave("India_IMR_2013_YlGn.png",dpi = 300, width = 20, height = 20, units = "cm")

# Creating a map with gradient fill
ggplot() +
  geom_polygon(data = final.plot,
               aes(x = long, y = lat, group = group, fill = count), 
               color = "black", size = 0.25) + 
  coord_map()+
  scale_fill_gradient(name="IMR", limits=c(0,100), low = 'white', high = 'red')+
  labs(title="IMR of Different States of India")+
  xlab('Longitude')+
  ylab('Latitude')

#ggsave("India_IMR_2013_NO_ST_NAME.png",dpi = 300, width = 20, height = 20, units = "cm")

# Creating map with states name
## Aggregating the location for mapping
cnames <- aggregate(cbind(long, lat) ~ id, data=final.plot, FUN=function(x) mean(range(x)))

## plotting the location in the map
ggplot() +
  geom_polygon(data = final.plot,
               aes(x = long, y = lat, group = group, fill = count), 
               color = "black", size = 0.25) + 
  coord_map()+
  scale_fill_gradient(name="IMR", limits=c(0,100), low = 'white', high = 'red')+
  labs(title="IMR of Different States of India")+
  xlab('Longitude')+
  ylab('Latitude')+
  geom_text(data=cnames, aes(long, lat, label = id), size=3, fontface="bold")

# ggsave("India_IMR_2013.png",dpi = 300, width = 20, height = 20, units = "cm")