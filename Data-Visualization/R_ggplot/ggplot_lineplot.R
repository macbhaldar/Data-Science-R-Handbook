#This script provides an example of a line plot created with ggplot2
#Creator: Daniel Kuhman
#Date Created: 2020-05-08
#Github: https://github.com/dkuhman

library('tidyverse')
library("ggplot2")

#Load data
mydata<-read.csv('C:/Users/danielkuhman/Google Drive/R/data_viz/data/bham_weather_2019.csv')

#Prep Data
mydata<-mydata %>% 
  select(date,temp_high3)

mydata$temp_high3<-as.numeric(as.character(mydata$temp_high3))
mydata$date<-as.character(mydata$date)
mydata$Month<-substr(mydata$date,2,4)
mydata$Day<-substr(mydata$date,6,7)

mydata$Month<-as.factor(mydata$Month)
mydata$Day<-as.numeric(mydata$Day)

mydata<-mydata %>% 
  filter(Month=='Sep')

ggplot(mydata, aes(x=Day, y=temp_high3))+
  geom_line(color='#003399', lwd=1.5)+
  geom_point(color='black', size=3)+
  theme_classic()+
  xlab('Day')+
  ylab('High Temperature at 12pm (deg. F)')+
  theme(
    axis.title.x = element_text(color="black", face = 'bold', size=20, margin = margin(t = 30, r = 0, b = 0, l = 0)),
    axis.title.y = element_text(color="black", face = 'bold', size=20, margin = margin(t = 0, r = 30, b = 0, l = 0)),
    axis.text = element_text(color = 'black',size=14),
    axis.line = element_line(size=1),
    legend.position = 'none'
  )
