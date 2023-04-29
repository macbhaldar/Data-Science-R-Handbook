#This script provides an example of a heat mapped correlation matrix created with ggplot2
#Creator: Daniel Kuhman
#Date Created: 2020-05-02
#Github: https://github.com/dkuhman

library('tidyverse')
library("ggplot2")
library("reshape2")
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
}


#Prep Plot Data Frame
plot_data<-mydata %>% 
  select(GP, G, A, PTS, S, TOI, PIM) %>% 
  drop_na()
cormat<-round(cor(plot_data),2)
cormat[upper.tri(cormat)] <- NA
melted<-melt(cormat)

#Basic Plot
ggplot(melted, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile(color='white', lwd=1.5)+
  scale_fill_gradient2(na.value = 'white', low = 'red', high = 'green', mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Correlation") +
  theme_classic()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y =  element_blank(),
    axis.text = element_text(color = 'black',size=20, face='bold'),
    axis.line = element_line(size=1),
    legend.title = element_text(size=18, color='black',face='bold'),
    legend.text = element_text(size=14, color='black')
  )

#Plot with correlations added as text
ggplot(melted, aes(x=Var1, y=Var2, fill=value)) + 
  geom_tile(color='white', lwd=1.5)+
  geom_text(aes(Var1, Var2, label = value), color = "black", size = 5) +
  scale_fill_gradient2(na.value = 'white', low = 'red', high = 'green', mid = "white", 
                       midpoint = 0, limit = c(-1,1), space = "Lab", 
                       name="Correlation") +
  theme_classic()+
  theme(
    axis.title.x = element_blank(),
    axis.title.y =  element_blank(),
    axis.text = element_text(color = 'black',size=20, face='bold'),
    axis.line = element_line(size=1),
    legend.title = element_text(size=18, color='black',face='bold'),
    legend.text = element_text(size=14, color='black')
  )











