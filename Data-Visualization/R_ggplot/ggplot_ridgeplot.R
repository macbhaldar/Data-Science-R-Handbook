#This script looks at avocado prices in the U.S. per week in 2019 to create a ridgeplot
#Creator: Daniel Kuhman
#Date Created: 2020-05-05
#Github: https://github.com/dkuhman

#install.packages('ggjoy')
library('tidyverse')
library("ggplot2")
library('ggjoy')

rm(list=ls())

#Load data
mydata<-read.csv('C:/Users/danielkuhman/Google Drive/R/data_viz/data/avocado_report.csv')

#Prep Data
mydata$Number.of.Stores<-as.numeric(gsub(",","",mydata$Number.of.Stores)) #Total Time On Ice
mydata$Date<-as.Date(as.character(mydata$Date),format = '%m/%d/%Y')
mydata$Date<-as.character(mydata$Date)
#Remove per pound prices
mydata<-mydata %>% 
  filter(Unit=='each')
#Add counts per week
mydata<-mydata %>%
  group_by(Date) %>% 
  mutate(week_numb = row_number()) %>% 
  ungroup()
#Get the average price for each week
mydata_price<-aggregate(x = mydata$Weighted.Avg.Price,
                         by = list(mydata$Date), 
                         FUN = mean) 
#Alter month 
mydata_price$month<-substr(mydata_price$Group.1,6,7)
mydata_price$month[mydata_price$month=='01']<-'Jan'
mydata_price$month[mydata_price$month=='02']<-'Feb'
mydata_price$month[mydata_price$month=='03']<-'Mar'
mydata_price$month[mydata_price$month=='04']<-'Apr'
mydata_price$month[mydata_price$month=='05']<-'May'
mydata_price$month[mydata_price$month=='06']<-'Jun'
mydata_price$month[mydata_price$month=='07']<-'Jul'
mydata_price$month[mydata_price$month=='08']<-'Aug'
mydata_price$month[mydata_price$month=='09']<-'Sep'
mydata_price$month[mydata_price$month=='10']<-'Oct'
mydata_price$month[mydata_price$month=='11']<-'Nov'
mydata_price$month[mydata_price$month=='12']<-'Dec'
#Add week number to price data frame
mydata_price<-mydata_price %>%
  group_by(month) %>% 
  mutate(week_numb = row_number()) %>% 
  ungroup()
#Re-order factor levels
mydata_price$month<-factor(mydata_price$month,
                           levels = c("Jan", "Feb", "Mar",
                                      "Apr", "May", "Jun",
                                      "Jul", "Aug", "Sep",
                                      "Oct", "Nov", "Dec"))

#Plot
ggplot(mydata_price,aes(y=month,x=x))+
  geom_joy(scale=2, aes(fill=month), alpha=0.5, lwd=1)+
  theme_classic()+
  guides(fill=FALSE,color=FALSE)+
  labs(y="Month",
       x="Average Price per Avacado ($)")+
  theme(
    axis.title.x = element_text(size=25, color='black', face='bold',
                              margin = margin(t=30,r=0,b=0,l=0)),
    axis.title.y = element_text(size=25, color='black', face='bold',
                                margin = margin(t=0,r=30,b=0,l=0)),
    axis.text = element_text(size=18, color='black')
  )






