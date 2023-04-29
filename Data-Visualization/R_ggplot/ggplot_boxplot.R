#This script provides an example of a boxplot created with ggplot2
#Creator: Daniel Kuhman
#Date Created: 2020-05-02
#Github: https://github.com/dkuhman

library('tidyverse')
library("ggplot2")

#Load data
mydata<-read.csv('C:/Users/danielkuhman/Google Drive/R/data_viz/skater_stats.csv')

#Prep data for plotting
{
  mydata<-mydata[,c(2:29)]
  mydata<-mydata %>% 
    rename(
      PM = X...,
      SPG = S.
    )
  mydata$Season<-as.factor(mydata$Season) #Season
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
  mydata$Pos[grepl('W', mydata$Pos, fixed = TRUE)]<-'W'
  mydata$Pos<-as.factor(mydata$Pos)
}


#Boxplot of G per POS for 2018 Season
plot_data<-mydata %>% 
  filter(Season == '2018')

ggplot(plot_data, aes(x=Pos, y=G, group=Pos))+
  geom_boxplot(aes(fill=Pos), lwd=2, color='black',
               outlier.color = 'white')+
  geom_jitter(color='black', width = 0.3, size=2, alpha=0.5)+
  theme_classic()+
  xlab('Position')+
  ylab('Goals')+
  theme(
    axis.title.x = element_text(color="black", face = 'bold', size=20, margin = margin(t = 30, r = 0, b = 0, l = 0)),
    axis.title.y = element_text(color="black", face = 'bold', size=20, margin = margin(t = 0, r = 30, b = 0, l = 0)),
    axis.text = element_text(color = 'black',size=14),
    axis.line = element_line(size=1),
    legend.position = 'none'
  )


















