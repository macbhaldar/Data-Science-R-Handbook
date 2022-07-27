library(fmsb)
library(dplyr)

min<-c(0,0,0,0,0)
max<-c(10,10,10,10,20)
ProbStat<-c(7,0,10,8,14)
EDAV<-c(3,7,5,9,18)
Algorithm<-c(8,8,6,4,4)
ML<-c(8,10,4,2,6)
DSDF<-data.frame(max,min,ProbStat,EDAV,Algorithm,ML)
DSDFT<-t(DSDF)
DS<-data.frame(DSDFT)



#radar plot w/ variable names
colnames(DS)<-c("Math","Coding","Statistics","Reading","other")

color=c(rgb(0.8,0.2,0.2,0.5), rgb(0.2,0.8,0.2,0.5),
        rgb(0.2,0.2,0.8,0.5), rgb(0.5,0.5,0.5,0.5))


radarchart(DS, pcol=c( rgb(0.8,0.2,0.2,0.5), rgb(0.2,0.8,0.2,0.5),
                       rgb(0.2,0.2,0.8,0.5), rgb(0.5,0.5,0.5,0.5)), 
           pfcol=c(  rgb(0.8,0.2,0.2,0.5), rgb(0.2,0.8,0.2,0.5),
                     rgb(0.2,0.2,0.8,0.5), rgb(0.5,0.5,0.5,0.5) ), 
           title="varying skillsets by DSI course")


# change the order or the norminal varibales to see 
# how polygon shapes change (order is arbitrary)


DS2<-DS[c(3,5,2,4,1)]

colnames(DS2)<-c("Statistics","other","Coding","Reading","Math")



color=c(rgb(0.8,0.2,0.2,0.5), rgb(0.2,0.8,0.2,0.5),
        rgb(0.2,0.2,0.8,0.5), rgb(0.5,0.5,0.5,0.5))


radarchart(DS2, pcol=c( rgb(0.8,0.2,0.2,0.5), rgb(0.2,0.8,0.2,0.5),
                        rgb(0.2,0.2,0.8,0.5), rgb(0.5,0.5,0.5,0.5)), 
           pfcol=c(  rgb(0.8,0.2,0.2,0.5), rgb(0.2,0.8,0.2,0.5),
                     rgb(0.2,0.2,0.8,0.5), rgb(0.5,0.5,0.5,0.5)), 
           title="varying skillsets by DSI course")


# break down the 4 classes into 4 individual radar charts


DS3=DS2[1:3,]

radarchart(DS3, pcol=c( rgb(0.8,0.2,0.2,0.5)), 
           pfcol=c( rgb(0.8,0.2,0.2,0.5), 
                    title="ProbStat"))



DS4=data.frame(DS2%>%slice(1:2,4))

radarchart(DS4, pcol=c( rgb(0.2,0.8,0.2,0.5)), 
           pfcol=c( rgb(0.2,0.8,0.2,0.5), 
                    title="EDAV"))



DS5=data.frame(DS2%>%slice(1:2,5))

radarchart(DS5, pcol=c( rgb(0.2,0.2,0.8,0.5)), 
           pfcol=c( rgb(0.2,0.2,0.8,0.5), 
                    title="Algorithm"))


DS6=data.frame(DS2%>%slice(1:2,6))

radarchart(DS6, pcol=c( rgb(0.5,0.5,0.5,0.5)), 
           pfcol=c( rgb(0.5,0.5,0.5,0.5), 
                    title="ML"))
