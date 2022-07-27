library(HH)
library(dplyr)

# create data
data = data.frame("Not_at_all_angry"=c(0.11,0.08,0.09,0.08,0.09,0.12,0.05,0.08),
                  "Not_very_angry"=c(0.75,0.75,0.74,0.70,0.78,0.68,0.86,0.71),
                  "Fairly_angry"=c(0.13,0.14,0.16,0.17,0.11,0.18,0.06,0.19),
                  "Very_angry"=c(0.02,0.02,0.02,0.05,0.02,0.02,0.03,0.01),
                  "Region"=c("North","Midlands","East","London","South","Wales",
                             "Scotland","Northern_Ireland"),
                  "England" = c("England", "England", "England", "England", "England", 
                                "Not England", "Not England", "Not England"))

# make stacked bar chart
likert(Region ~.|England, layout=c(1,2), data, positive.order = TRUE, 
       scales=list(y=list(relation="free")),
       strip.left=strip.custom(bg="gray97"),
       strip=FALSE,
       as.percent = "noRightAxis", ReferenceZero = 2.5,
       main = 'Angry levels in different regions', 
       ylab = "Region", xlab = "Percentage",
       sub= list("Angry Level Rating",x=unit(.6, "npc")))

data_2 <- data.frame("Great"=c(4,2),"Good"=c(14,6),"Average"=c(15,16),
                     "Poor"=c(17,17),"Terrible"=c(44,48),"Gender"=c("Male","Female"))

data_2 <- data_2[,c(6,1,2,3,4,5)]

data_2

# stacked bar chart
likert(Gender ~ ., data_2, ReferenceZero = 0, as.percent = "noRightAxis", 
       main = "Satisfaction of Trump")


# Diverging stacked bar chart
likert(Gender ~ ., data_2, ReferenceZero = 3, as.percent = "noRightAxis", 
       main = "Satisfaction of Trump")


# Stacked bar chart using ggplot
library(ggplot2)
library(reshape2)
library(RColorBrewer)
library(dplyr)
library(ggthemes)
library(stringr)
library(forcats)

d <- data_2
d[,2:6] <- d[,2:6]/rowSums(d[,2:6])

mytitle <- "Satisfaction of Trump"
mylevels <- c("Great", "Good", "Average", "Poor",  "Terrible")

# Generate mid value of neutral category
numlevels <- length(d[1,])-1
numcenter <- ceiling(numlevels/2) + 1
d$midvalues <- d[,numcenter]/2
d_2<-cbind(d[,1],d[,2:ceiling(numlevels/2)], d$midvalues, d$midvalues,d[,numcenter:numlevels+1])
colnames(d_2)<-c("Sex",mylevels[1:floor(numlevels/2)],"Midlow",
                 "Midhigh",mylevels[numcenter:numlevels])

# Split into six categories
numlevels<-length(mylevels)+1
point1<-2
point2<-((numlevels)/2)+1
point3<-point2+1
point4<-numlevels+1

# Assign color to each categories
numlevels<-length(d[1,])-1
temp.rows<-length(d_2[,1])
pal<-brewer.pal((numlevels-1),"RdBu")
pal[ceiling(numlevels/2)]<-"#DFDFDF"
legend.pal<-pal
pal<-c(pal[1:(ceiling(numlevels/2)-1)], pal[ceiling(numlevels/2)], 
       pal[ceiling(numlevels/2)], pal[(ceiling(numlevels/2)+1):(numlevels-1)])

# Generate new data frame including all information
d_3<-melt(d_2,id="Sex")
d_3$col<-rep(pal,each=temp.rows)
d_3$value<-d_3$value*100
d_3$Sex<-str_wrap(d_3$Sex, width = 40)
d_3$Sex<-factor(d_3$Sex, levels = d_2$Sex[order(-(d_2[,5]+d_2[,6]+d_2[,7]))])
highs<-na.omit(d_3[(length(d_3[,1])/2)+1:length(d_3[,1]),])
lows<-na.omit(d_3[1:(length(d_3[,1])/2),])

# Plot
ggplot() + 
  geom_bar(data=highs, aes(x = Sex, y=value, fill=col), 
           position="stack", stat="identity", width = 0.5) +
  geom_bar(data=lows, aes(x = Sex, y=-value, fill=fct_inorder(col)), 
           position="stack", stat="identity", width = 0.5) +
  geom_hline(yintercept = 0, color =c("white")) +
  scale_fill_identity("Percent", labels = mylevels, 
                      breaks=legend.pal, guide="legend") + 
  theme_fivethirtyeight() + 
  coord_flip() +
  labs(title=mytitle, y="",x="") +
  theme(plot.title = element_text(size=14, hjust=0.5)) +
  theme(axis.text.y = element_text(hjust=0)) +
  theme(legend.position = "bottom")
