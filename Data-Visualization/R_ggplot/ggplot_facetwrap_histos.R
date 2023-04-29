#This script provides an example of a histogram created with ggplot2
#Creator: Daniel Kuhman
#Date Created: 2020-05-02
#Github: https://github.com/dkuhman

library('tidyverse')
library("ggplot2")

rm(list=ls())

#Load data
mydata<-read.csv('C:/Users/danielkuhman/Google Drive/R/data_viz/data/skater_stats.csv')

#Prep data for plotting
{
  mydata<-mydata[,c(2:29)]
  mydata<-mydata %>% 
    rename(
      PM = X...,
      SPG = S.
    )
  mydata$Season<-as.character(mydata$Season) #Season
  mydata$Season<-as.factor(mydata$Season)
  mydata$Player<-as.factor(mydata$Player) #Player Name
  mydata$G<-as.numeric(as.character(mydata$G)) #Goals
  mydata$A<-as.numeric(as.character(mydata$A)) #Assists
  mydata$PTS<-as.numeric(as.character(mydata$PTS)) #Points
  mydata$PM<-as.numeric(as.character(mydata$PM)) #Plus/Minus
  mydata$PIM<-as.numeric(as.character(mydata$PIM)) #Penalty Minutes
  mydata$EVG<-as.numeric(as.character(mydata$EVG)) #Even Handed Goals
  mydata$PPG<-as.numeric(as.character(mydata$PPG)) #Power Play Goals
  mydata$SHG<-as.numeric(as.character(mydata$SHG)) #Short Handed Goals
  mydata$GWG<-as.numeric(as.character(mydata$GWG)) #Game Winning Goals
  mydata$EVA<-as.numeric(as.character(mydata$EVA)) #Even Handed Assists
  mydata$PPA<-as.numeric(as.character(mydata$PPA)) #Power Player Assists
  mydata$SHA<-as.numeric(as.character(mydata$SHA)) #Short Handed Assists
  mydata$S<-as.numeric(as.character(mydata$S)) #Total Shots
  mydata$SPG<-as.numeric(as.character(mydata$SPG)) #Average Shots Per Game
  mydata$TOI<-as.numeric(gsub(",","",mydata$TOI)) #Total Time On Ice
  mydata$Pos<-as.character(mydata$Pos)
  mydata$Pos[grepl('W', mydata$Pos, fixed = TRUE)]<-'Forward'
  mydata$Pos[grepl('C', mydata$Pos, fixed = TRUE)]<-'Forward'
  mydata$Pos[grepl('F', mydata$Pos, fixed = TRUE)]<-'Forward'
  mydata$Pos[grepl('D', mydata$Pos, fixed = TRUE)]<-'Defense'
  mydata$Pos<-as.factor(mydata$Pos)
  
  mydata<-mydata %>% 
    filter(Season=='2018')
}

#Basic, Facet Wraped by Team
ggplot(mydata, aes(x=G))+
  geom_histogram(color='black',fill='#336699')+
  facet_wrap(~Tm)+
  theme_classic()+
  xlab('Goals')+
  ylab('Counts')+
  guides(colour = guide_legend(override.aes = list(size=4)))+
  theme(
    axis.title.x = element_text(color="black", face = 'bold', size=25, margin = margin(t = 30, r = 0, b = 0, l = 0)),
    axis.title.y = element_text(color="black", face = 'bold', size=25, margin = margin(t = 0, r = 30, b = 0, l = 0)),
    axis.text = element_text(color = 'black',size=10),
    axis.line = element_line(size=1)
    )

#Grouped by position, Facet Wraped by Team
ggplot(mydata, aes(x=G))+
  geom_histogram(aes(fill=Pos), color='black', alpha=0.5,
                 position = 'identity')+
  facet_wrap(~Tm)+
  theme_classic()+
  xlab('Goals')+
  ylab('Counts')+
  theme(
    axis.title.x = element_text(color="black", face = 'bold', size=25, margin = margin(t = 30, r = 0, b = 0, l = 0)),
    axis.title.y = element_text(color="black", face = 'bold', size=25, margin = margin(t = 0, r = 30, b = 0, l = 0)),
    axis.text = element_text(color = 'black',size=8),
    axis.line = element_line(size=1),
    legend.position = 'top',
    legend.title = element_blank(),
    legend.text = element_text(color='black', size = 20,  margin = margin(t = 0, r = 30, b = 0, l = 0))
  )

#Basic Grouped Histogram with Density
ggplot(mydata, aes(x=G, fill=Pos))+
  geom_histogram(aes(y=..density..),color='black', alpha=0.8,
                 position = 'identity')+
  geom_density(alpha=0.4, color='black')+
  facet_wrap(~Tm)+
  theme_classic()+
  xlab('Goals')+
  ylab('Density')+
  theme(
    axis.title.x = element_text(color="black", face = 'bold', size=25, margin = margin(t = 30, r = 0, b = 0, l = 0)),
    axis.title.y = element_text(color="black", face = 'bold', size=25, margin = margin(t = 0, r = 30, b = 0, l = 0)),
    axis.text = element_text(color = 'black',size=8),
    axis.line = element_line(size=1),
    legend.position = 'top',
    legend.title = element_blank(),
    legend.text = element_text(color='black', size = 20,  margin = margin(t = 0, r = 30, b = 0, l = 0))
  )
