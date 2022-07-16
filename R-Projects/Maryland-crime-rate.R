# Regression modeling to explore crime statistics 
# collected by the State of Maryland to see 
# if there is a linear trend in violent crime 
# across the state between 1975 and 2016.

library(tidyverse)
library(lubridate)

# Read in the crime data
crime_raw <- read_csv("data/Violent_Crime_by_County_1975_to_2016.csv")

# Select and mutate columns the needed columns
crime_use <- crime_raw %>% 
  select(JURISDICTION, YEAR, POPULATION, crime_rate = `VIOLENT CRIME RATE PER 100,000 PEOPLE`) %>%
  mutate(YEAR_2 = year(mdy_hms(YEAR)))

# Peek at the data
head(crime_use)

# Plot the data as lines and linear trend lines
ggplot(crime_use, aes(x = YEAR_2, y = crime_rate, group = JURISDICTION)) + 
  geom_line() + 
  geom_smooth(method = "lm", se = FALSE, size = 0.5)

# Mutate data to create another year column, YEAR_3
crime_use <- crime_use %>%
  mutate(YEAR_3 = YEAR_2 - min(YEAR_2))
head(crime_use)

# LmerTest

library(lmerTest)

# Build a lmer and save it as lmer_crime
lmer_crime <- lmer(crime_rate ~ YEAR_3 + (YEAR_3|JURISDICTION), crime_use)

# Print the model output
lmer_crime

# Examine the model outputs using summary
summary(lmer_crime)

# This is for readability 
noquote("**** Fixed-effects ****")

# Use fixef() to view fixed-effects
fixef(lmer_crime)

# This is for readability 
noquote("**** Random-effects ****")

# Use ranef() to view random-effects
ranef(lmer_crime)

# Format model coefficients
# Add the fixed-effect to the random-effect and save as county_slopes
county_slopes <- fixef(lmer_crime)["YEAR_3"] + ranef(lmer_crime)$JURISDICTION["YEAR_3"]

# Add a new column with county names
county_slopes <-
  county_slopes %>% 
  rownames_to_column("county")

# Map data
library(usmap)

# load and filter map data
county_map <- us_map(regions = "counties", include = "MD")

# Matching county names
# See which counties are not in both datasets
county_slopes %>% anti_join(county_map, by = "county")
county_map %>% anti_join(county_slopes, by = "county")

# Rename crime_names county
county_slopes  <- county_slopes  %>% 
  mutate(county = ifelse(county == "Baltimore City", "Baltimore city", county))

# Merging data frames
# Merge the map and slope data frames
both_data <- 
  full_join(county_map, county_slopes)

# Peek at the data
head(both_data)

# Mapping trends
# Set the notebook's plot settings
options(repr.plot.width=10, repr.plot.height=5)

# Plot the results 
crime_map <- 
  ggplot(both_data, aes(long, lat, group = county, fill = YEAR_3)) +
  geom_polygon() + 
  scale_fill_continuous(name = expression(atop("Change in crime rate","(Number year"^-1*")")),
                        low = "skyblue", high = "gold")

# Look at the map
crime_map

# Plot options
options(repr.plot.width=10, repr.plot.height=5)

# Polish figure
crime_map_final <- crime_map + 
  theme_minimal() +
  xlab("") +
  ylab("") +
  theme(axis.line=element_blank(), 
        axis.text=element_blank(), 
        panel.grid.major=element_blank(), 
        panel.grid.minor=element_blank(), 
        panel.border=element_blank(), 
        panel.background=element_blank())

# Look at the map
print(crime_map_final)

# Compare populations and crime rates
# Build a lmer with both year and population
lmer_pop <- lmer(crime_rate ~ YEAR_3 + POPULATION + (YEAR_3|JURISDICTION), data=crime_use)


# Inspect the results
summary(lmer_pop)
ranef(lmer_pop)
