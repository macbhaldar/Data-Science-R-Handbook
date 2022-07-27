library(vcdExtra) # dataset
library(dplyr) # manipulation
library(ggplot2) # plotting
library(viridis) # color palette

## format data
orderedclasses <- c("Farm", "LoM", "UpM", "LoNM", "UpNM")
mydata <- Yamaguchi87
mydata$Son <- factor(mydata$Son, levels = orderedclasses)
mydata$Father <- factor(mydata$Father,
                        levels = orderedclasses)
japan <- mydata %>% filter(Country == "Japan")
uk <- mydata %>% filter(Country == "UK")
us <- mydata %>% filter(Country == "US")

### convert to % of country and class total
mydata_new <- mydata %>% group_by(Country, Father) %>% 
  mutate(Total = sum(Freq)) %>% ungroup()

### make custom theme
theme_heat <- theme_classic() +
  theme(axis.line = element_blank(),
        axis.ticks = element_blank())

### basic plot
plot <- ggplot(mydata_new, aes(x = Father, y = Son)) +
  geom_tile(aes(fill = Freq/Total), color = "white") +
  coord_fixed() + facet_wrap(~Country) + theme_heat

### plot with text overlay and viridis color palette
plot + geom_text(aes(label = round(Freq/Total, 1)), 
                 color = "white") +
  scale_fill_viridis() +
  ## formatting
  ggtitle("Like Father, Like Son",
          subtitle = "Heatmaps of occupational categories for fathers and sons, by country") +
  labs(caption = "Source: vcdExtra::Yamaguchi87") +
  theme(plot.title = element_text(face = "bold")) +
  theme(plot.subtitle = element_text(face = "bold", color = "grey35")) +
  theme(plot.caption = element_text(color = "grey68"))




library(ggplot2) # plotting 
library(GDAdata) # data (SpeedSki)

ggplot(SpeedSki, aes(Year, Speed)) + 
  geom_bin2d()

g1 <- ggplot(SpeedSki, aes(Year, Speed)) + 
  scale_fill_viridis()

### show plot
g1 + geom_bin2d(binwidth = c(5, 5))
g1 + geom_hex(binwidth = c(5, 5))
g1 + geom_hex(binwidth = c(5, 5), alpha = .4) + 
  geom_point(size = 2, alpha = 0.8)
ggplot(SpeedSki, aes(Year, Speed)) + 
  scale_fill_gradient(low = "#cccccc", high = "#09005F") + 
  geom_hex(bins = 10)




library(pgmm) # data
library(tidyverse) # processing/graphing
library(viridis) # color palette

data(wine)

### convert to column, value
wine_new <- wine %>%
  rownames_to_column() %>%
  gather(colname, value, -rowname)

ggplot(wine_new, aes(x = rowname, y = colname, fill = value)) +
  geom_tile() + scale_fill_viridis() +
  ggtitle("Italian Wine Dataframe")
