# Convert the variable dose from a numeric to a factor variable
ToothGrowth$dose <- as.factor(ToothGrowth$dose)
head(ToothGrowth)

# Basic violin plots
library(ggplot2)
# Basic violin plot
p <- ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_violin()
p
# Rotate the violin plot
p + coord_flip()
# Set trim argument to FALSE
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_violin(trim=FALSE)

# Choose which items to display :
p + scale_x_discrete(limits=c("0.5", "2"))

# Add summary statistics on a violin plot
# function : stat_summary()
# Add mean and median points
# violin plot with mean points
p + stat_summary(fun.y=mean, geom="point", shape=23, size=2)
# violin plot with median points
p + stat_summary(fun.y=median, geom="point", size=2, color="red")

# Add median and quartile
# function : geom_boxplot
p + geom_boxplot(width=0.1)

# Add mean and standard deviation
p <- ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_violin(trim=FALSE)
p + stat_summary(fun.data="mean_sdl", mult=1, 
                 geom="crossbar", width=0.2 )
p + stat_summary(fun.data=mean_sdl, mult=1, 
                 geom="pointrange", color="red")

# Violin plot with dots
# violin plot with dot plot
p + geom_dotplot(binaxis='y', stackdir='center', dotsize=1)
# violin plot with jittered points
# 0.2 : degree of jitter in x direction
p + geom_jitter(shape=16, position=position_jitter(0.2))

# Change violin plot colors by groups
# Change violin plot line colors
# Change violin plot line colors by groups
p<-ggplot(ToothGrowth, aes(x=dose, y=len, color=dose)) +
  geom_violin(trim=FALSE)
p

# Use custom color palettes
p + scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# Use brewer color palettes
p + scale_color_brewer(palette="Dark2")
# Use grey scale
p + scale_color_grey() + theme_classic()

# Change violin plot fill colors
# Use single color
ggplot(ToothGrowth, aes(x=dose, y=len)) +
  geom_violin(trim=FALSE, fill='#A4A4A4', color="darkred")+
  geom_boxplot(width=0.1) + theme_minimal()
# Change violin plot colors by groups
p<-ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) +
  geom_violin(trim=FALSE)
p

# Use custom color palettes
p+scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# Use brewer color palettes
p+scale_fill_brewer(palette="Dark2")
# Use grey scale
p + scale_fill_grey() + theme_classic()

# Change the legend position
p + theme(legend.position="top")
p + theme(legend.position="bottom")
p + theme(legend.position="none") # Remove legend

# Violin plot with multiple groups
# Change violin plot colors by groups
ggplot(ToothGrowth, aes(x=dose, y=len, fill=supp)) +
  geom_violin()
# Change the position
p<-ggplot(ToothGrowth, aes(x=dose, y=len, fill=supp)) +
  geom_violin(position=position_dodge(1))
p

# Change violin plot colors and add dots :

# Add dots
p + geom_dotplot(binaxis='y', stackdir='center',
                 position=position_dodge(1))
# Change colors
p + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

# Customized violin plots
# Basic violin plot
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_violin(trim=FALSE, fill="gray")+
  labs(title="Plot of length  by dose",x="Dose (mg)", y = "Length")+
  geom_boxplot(width=0.1)+
  theme_classic()
# Change color by groups
dp <- ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) + 
  geom_violin(trim=FALSE)+
  geom_boxplot(width=0.1, fill="white")+
  labs(title="Plot of length  by dose",x="Dose (mg)", y = "Length")
dp + theme_classic()

# Change fill colors manually :

# Continusous colors
dp + scale_fill_brewer(palette="Blues") + theme_classic()
# Discrete colors
dp + scale_fill_brewer(palette="Dark2") + theme_minimal()
# Gradient colors
dp + scale_fill_brewer(palette="RdBu") + theme_minimal()

