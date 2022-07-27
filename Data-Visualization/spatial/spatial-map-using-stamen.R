library(dplyr)
library(ggmap)

# Dataset available at "https://data.cityofnewyork.us/Public-Safety/NYPD-Motor-Vehicle-Collisions-Crashes/h9gi-nx95/data". 

raw_df <- read.csv("data/Motor_Vehicle_Collisions_-_Crashes.csv",
           header = TRUE, sep = ",")

# Selecting specific columns and rows 

reasons <- c("Driver Inattention/Distraction", "Failure to Yield Right-of-Way",
             "Following Too Closely", "Fatigued/Drowsy", "Backing Unsafely")

df <- raw_df %>% select(CRASH.DATE, BOROUGH, LATITUDE, LONGITUDE, NUMBER.OF.PERSONS.INJURED, CONTRIBUTING.FACTOR.VEHICLE.1) %>%
  na_if("") %>%  # recode empty strings "" by NAs
  na.omit %>% # remove NAs
  filter(NUMBER.OF.PERSONS.INJURED != 0) %>%
  filter(CONTRIBUTING.FACTOR.VEHICLE.1 %in% reasons)

df$TIME <- as.character(df$CRASH.TIME)
df$TIME <- as.numeric(unlist(strsplit(df$TIME, ":"))[seq(1, 2 * nrow(df), 2)])

#creating label based on the hour of day
breaks <- c(0, 6, 12, 18, 24)
labels <- c("Nght", "Morng", "Noon", "Evng")
df$TIME_LABEL <- cut(x=df$TIME, breaks = breaks, labels = labels, include.lowest=TRUE)


library(forcats)
# Summary of dataset
# accident count by borough
ggplot(data=df, aes((fct_rev(fct_infreq(BOROUGH))))) + 
  geom_bar( color="blue", fill="LIGHTBLUE") +
  ggtitle("Number of Accidents in different BOROUGH", ) + theme(plot.title = element_text(hjust = 0.5)) + 
  xlab("Borough") +ylab("Accidents Count") + 
  coord_flip() +
  theme(legend.position = "top")


# accidents by contributing factors
ggplot(data=df, aes((fct_rev(fct_infreq(CONTRIBUTING.FACTOR.VEHICLE.1))))) + 
  geom_bar( color="black", fill="tomato") +
  ggtitle("Number of Accidents due to different Factors", ) + theme(plot.title = element_text(hjust = 0.5)) + 
  xlab("Contributing Factor") +ylab("Accidents Count") + 
  coord_flip() +
  theme(legend.position = "top")


# Number of accidents across different Boroughs for different time slots and contributing factors
ggplot(df, aes(fill=CONTRIBUTING.FACTOR.VEHICLE.1, y=NUMBER.OF.PERSONS.INJURED, x=TIME_LABEL)) + 
  geom_bar(position="stack", stat="identity") +
  facet_wrap(~BOROUGH)+
  ggtitle("Number of Accidents due to different Factors across differnt time and Boroughs", )


#Step 1
#plotting map of New York
#Constraining the plot to a bounding box of latitude and longitude coordinates corresponding to NYC. 
min_lat <- 40.5774
max_lat <- 40.9176
min_long <- -74.15
max_long <- -73.7004

ggplot(df, aes(x=LONGITUDE, y=LATITUDE)) +
  geom_point(size=0.06, color="seagreen") +
  scale_x_continuous(limits=c(min_long, max_long)) +
  scale_y_continuous(limits=c(min_lat, max_lat)) +
  ggtitle("Map of New York City", ) + theme(plot.title = element_text(hjust = 0.5))


#Step 2
#Plotting all accidents
qmplot(x = LONGITUDE, y = LATITUDE, data = df, maptype = "watercolor",darken = .2,
       geom = c("point","density2d"), size = NUMBER.OF.PERSONS.INJURED, color = I("darkred"),
       alpha = I(.6), legend = NA) +
  scale_x_continuous(limits=c(min_long, max_long)) +
  scale_y_continuous(limits=c(min_lat, max_lat)) 


#Step 3
#Plotting by borough and contributing factor with size proportional to number of persons injured
gdf <- df %>%
  group_by(BOROUGH, CONTRIBUTING.FACTOR.VEHICLE.1) %>% 
  summarize(NUMBER.OF.PERSONS.INJURED = sum(NUMBER.OF.PERSONS.INJURED),
            HOUR_OF_DAY = names(which(table(TIME) == max(table(TIME)))[1]),
            LATITUDE = mean(LATITUDE), LONGITUDE = mean(LONGITUDE))

#Step 3a
#Plotting with size proportional to number of persons injured
qmplot(x = LONGITUDE, y = LATITUDE, data = gdf, maptype = "toner",darken=0.2,
       geom = c("point"), size = NUMBER.OF.PERSONS.INJURED, color = I("red")) 

#Step 3b
#Plotting with size proportional to number of persons injured and color proportional to hour of the day
qmplot(x = LONGITUDE, y = LATITUDE, data = gdf, maptype = "toner",darken = .2,
       geom = "point", size = NUMBER.OF.PERSONS.INJURED, color = HOUR_OF_DAY) 
