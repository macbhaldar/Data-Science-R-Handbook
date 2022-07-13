library(tidyverse)
library(fpp3)
library(bbplot)
library(plotly)

food <- read_csv("data/ukraine-russia-food.csv")

g20 <- c("Argentina", "Australia", "Brazil", "Canada", "China", "France", 
         "Germany", "India", "Indonesia", "Italy", "Japan", "South Korea", 
         "Mexico", "Saudi Arabia", "South Africa", "Turkey", "United Kingdom",
         "United States")

# Comparing the G20 Countries' Imported Crops for Domestic Supply(%) from Russia or Ukraine 
p <- 
  food %>% 
  select(Entity, 
         Year, 
         `Barley imports from Ukraine + Russia (% supply)`,
         `Maize imports from Ukraine + Russia (% supply)`,
         `Sunflower oil imports from Ukraine + Russia (% supply)`,
         `Wheat imports from Ukraine + Russia (% supply)`) %>% 
  rename(Barley=`Barley imports from Ukraine + Russia (% supply)`,
         Maize=`Maize imports from Ukraine + Russia (% supply)`,
         `Sunflower oil`=`Sunflower oil imports from Ukraine + Russia (% supply)`,
         Wheat=`Wheat imports from Ukraine + Russia (% supply)`) %>% 
  mutate(across(where(is.numeric), ~replace_na(.,0))) %>% 
  filter(Entity %in% g20) %>% 
  pivot_longer(cols = -c(Entity,Year),names_to = "Crops",values_to = "n") %>% 
  group_by(Entity,Crops) %>% 
  summarise(total=sum(n),
            # tooltip text showing the last year's values for plotly chart
            percent=paste0(round(last(n),2),"%\nin 2019")) %>% 
  arrange(desc(total),.by_group = TRUE) %>% #ranking stacked fill descending
  ggplot(aes(Entity, total, group=Entity, fill= Crops, text=percent)) +
  geom_bar(stat = "identity", position = "fill")+
  bbc_style()+
  scale_y_continuous(labels = scales::percent)+
  coord_flip()+
  theme(legend.position = "top", 
        legend.justification = "center",
        panel.grid.major.y = element_blank(),
        title = element_text(size=5))



# Plotly Graph
ggplotly(p,tooltip = "text") %>% 
  # adjusting legend position to top and center 
  layout(legend = list(orientation = "h",
                       y =1.1,
                       x=0.25,
                       title=""),
         margin=list(r=50) #gives space to the hover information
  )

wheat_future <- read_csv("data/us_wheat_futures.csv")

wheat_ts <- 
  wheat_future %>%
  mutate(Date= parse_date(str_remove(Date,"\\,"),"%b %d %Y")) %>% 
  as_tsibble() %>% 
  fill_gaps() %>% #fills the gaps with NAs to provide regular time series
  fill(Price,.direction = "down") #replaces the NAs with the previous value

set.seed(123)  

# NNAR modeling
fit_wheat <- 
  wheat_ts %>% 
  model(NNETAR(Price))

# Model residuals diagnostics
fit_wheat %>% 
  gg_tsresiduals()

# Projection of prices of the US wheat futures 

fit_wheat %>% 
  generate(times = 100, h = 52) %>%
  autoplot(.sim) +
  autolayer(wheat_ts, Price) +
  scale_x_yearweek(date_breaks="104 week")+
  labs(title="1-Year Projection of US Wheat Futures (ZWU2) Prices",
       xlab="",
       ylab="")+
  bbc_style()+
  theme(legend.position = "none",
        axis.text.x=element_text(size=15),
        plot.title = element_text(size=20,hjust=0.5))
