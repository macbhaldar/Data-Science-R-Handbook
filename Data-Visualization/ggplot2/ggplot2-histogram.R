set.seed(1234)
df <- data.frame(
  sex=factor(rep(c("F", "M"), each=200)),
  weight=round(c(rnorm(200, mean=55, sd=5), rnorm(200, mean=65, sd=5)))
)
head(df)

library(ggplot2)

# Basic histogram
ggplot(df, aes(x=weight)) + geom_histogram()
# Change the width of bins
ggplot(df, aes(x=weight)) + 
  geom_histogram(binwidth=1)
# Change colors
p<-ggplot(df, aes(x=weight)) + 
  geom_histogram(color="black", fill="white")
p

# Add mean line and density plot on the histogram
# Add mean line
p+ geom_vline(aes(xintercept=mean(weight)),
              color="blue", linetype="dashed", size=1)
# Histogram with density plot
ggplot(df, aes(x=weight)) + 
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666") 

# Change histogram plot line types and colors
# Change line color and fill color
ggplot(df, aes(x=weight))+
  geom_histogram(color="darkblue", fill="lightblue")
# Change line type
ggplot(df, aes(x=weight))+
  geom_histogram(color="black", fill="lightblue",
                 linetype="dashed")

# Change histogram plot colors by groups
library(plyr)
mu <- ddply(df, "sex", summarise, grp.mean=mean(weight))
head(mu)

# Change histogram plot line colors by groups
ggplot(df, aes(x=weight, color=sex)) +
  geom_histogram(fill="white")
# Overlaid histograms
ggplot(df, aes(x=weight, color=sex)) +
  geom_histogram(fill="white", alpha=0.5, position="identity")

# Interleaved histograms
ggplot(df, aes(x=weight, color=sex)) +
  geom_histogram(fill="white", position="dodge")+
  theme(legend.position="top")
# Add mean lines
p<-ggplot(df, aes(x=weight, color=sex)) +
  geom_histogram(fill="white", position="dodge")+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")+
  theme(legend.position="top")
p

# Use custom color palettes
p + scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# Use brewer color palettes
p + scale_color_brewer(palette="Dark2")
# Use grey scale
p + scale_color_grey() + theme_classic() +
  theme(legend.position="top")

# Change histogram plot fill colors by groups
ggplot(df, aes(x=weight, fill=sex, color=sex)) +
  geom_histogram(position="identity")
# Use semi-transparent fill
p<-ggplot(df, aes(x=weight, fill=sex, color=sex)) +
  geom_histogram(position="identity", alpha=0.5)
p
# Add mean lines
p+geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")

# Use custom color palettes
p + scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# use brewer color palettes
p + scale_color_brewer(palette="Dark2")+
  scale_fill_brewer(palette="Dark2")
# Use grey scale
p + scale_color_grey()+scale_fill_grey() +
  theme_classic()

Change the legend position
p + theme(legend.position="top")
p + theme(legend.position="bottom")
# Remove legend
p + theme(legend.position="none")

# Split the plot into multiple panels :
p<-ggplot(df, aes(x=weight))+
  geom_histogram(color="black", fill="white")+
  facet_grid(sex ~ .)
p
# Add mean lines
p+geom_vline(data=mu, aes(xintercept=grp.mean, color="red"),
             linetype="dashed")

Customized histogram plots
# Basic histogram
ggplot(df, aes(x=weight, fill=sex)) +
  geom_histogram(fill="white", color="black")+
  geom_vline(aes(xintercept=mean(weight)), color="blue",
             linetype="dashed")+
  labs(title="Weight histogram plot",x="Weight(kg)", y = "Count")+
  theme_classic()
# Change line colors by groups
ggplot(df, aes(x=weight, color=sex, fill=sex)) +
  geom_histogram(position="identity", alpha=0.5)+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")+
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  labs(title="Weight histogram plot",x="Weight(kg)", y = "Count")+
  theme_classic()

# Combine histogram and density plots :
# Change line colors by groups
ggplot(df, aes(x=weight, color=sex, fill=sex)) +
  geom_histogram(aes(y=..density..), position="identity", alpha=0.5)+
  geom_density(alpha=0.6)+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")+
  scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  labs(title="Weight histogram plot",x="Weight(kg)", y = "Density")+
  theme_classic()

# Change line colors manually :
p<-ggplot(df, aes(x=weight, color=sex)) +
  geom_histogram(fill="white", position="dodge")+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")
# Continuous colors
p + scale_color_brewer(palette="Paired") + 
  theme_classic()+theme(legend.position="top")
# Discrete colors
p + scale_color_brewer(palette="Dark2") +
  theme_minimal()+theme_classic()+theme(legend.position="top")
# Gradient colors
p + scale_color_brewer(palette="Accent") + 
  theme_minimal()+theme(legend.position="top")
