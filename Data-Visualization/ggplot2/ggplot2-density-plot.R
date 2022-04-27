set.seed(1234)
df <- data.frame(
  sex=factor(rep(c("F", "M"), each=200)),
  weight=round(c(rnorm(200, mean=55, sd=5),
                 rnorm(200, mean=65, sd=5)))
)
head(df)

library(ggplot2)

# Basic density
p <- ggplot(df, aes(x=weight)) + 
  geom_density()
p
# Add mean line
p+ geom_vline(aes(xintercept=mean(weight)),
              color="blue", linetype="dashed", size=1)

# Change line color and fill color
ggplot(df, aes(x=weight))+
  geom_density(color="darkblue", fill="lightblue")

# Change line type
ggplot(df, aes(x=weight))+
  geom_density(linetype="dashed")

# Change density plot colors by groups
# Calculate the mean of each group :
mu <- ddply(df, "sex", summarise, grp.mean=mean(weight))
head(mu)

# Change density plot line colors by groups
ggplot(df, aes(x=weight, color=sex)) +
  geom_density()
# Add mean lines
p<-ggplot(df, aes(x=weight, color=sex)) +
  geom_density()+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")
p

# Use custom color palettes
p + scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# Use brewer color palettes
p + scale_color_brewer(palette="Dark2")
# Use grey scale
p + scale_color_grey() + theme_classic()

# Change density plot fill colors by groups
ggplot(df, aes(x=weight, fill=sex)) +
  geom_density()
# Use semi-transparent fill
p<-ggplot(df, aes(x=weight, fill=sex)) +
  geom_density(alpha=0.4)
p
# Add mean lines
p+geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")

# Use custom color palettes
p+scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# use brewer color palettes
p+scale_fill_brewer(palette="Dark2")
# Use grey scale
p + scale_fill_grey() + theme_classic()

# Change the legend position
p + theme(legend.position="top")
p + theme(legend.position="bottom")
p + theme(legend.position="none") # Remove legend

# Histogram with density plot
ggplot(df, aes(x=weight)) + 
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666") 
# Color by groups
ggplot(df, aes(x=weight, color=sex, fill=sex)) + 
  geom_histogram(aes(y=..density..), alpha=0.5, 
                 position="identity")+
  geom_density(alpha=.2) 

# # Histogram with density plot
ggplot(df, aes(x=weight)) + 
  geom_histogram(aes(y=..density..), colour="black", fill="white")+
  geom_density(alpha=.2, fill="#FF6666") 
# Color by groups
ggplot(df, aes(x=weight, color=sex, fill=sex)) + 
  geom_histogram(aes(y=..density..), alpha=0.5, 
                 position="identity")+
  geom_density(alpha=.2) 

# Customized density plots
# Basic density
ggplot(df, aes(x=weight, fill=sex)) +
  geom_density(fill="gray")+
  geom_vline(aes(xintercept=mean(weight)), color="blue",
             linetype="dashed")+
  labs(title="Weight density curve",x="Weight(kg)", y = "Density")+
  theme_classic()
# Change line colors by groups
p<- ggplot(df, aes(x=weight, color=sex)) +
  geom_density()+
  geom_vline(data=mu, aes(xintercept=grp.mean, color=sex),
             linetype="dashed")+
  labs(title="Weight density curve",x="Weight(kg)", y = "Density")

p + scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))+
  theme_classic()


# Change line colors manually :

# Continuous colors
p + scale_color_brewer(palette="Paired") + theme_classic()
# Discrete colors
p + scale_color_brewer(palette="Dark2") + theme_minimal()
# Gradient colors
p + scale_color_brewer(palette="Accent") + theme_minimal()
