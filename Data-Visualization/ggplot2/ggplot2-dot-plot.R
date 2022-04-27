# Convert the variable dose from a numeric to a factor variable
ToothGrowth$dose <- as.factor(ToothGrowth$dose)
head(ToothGrowth)

# Basic dot plots
library(ggplot2)
# Basic dot plot
p<-ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_dotplot(binaxis='y', stackdir='center')
p
# Change dotsize and stack ratio
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_dotplot(binaxis='y', stackdir='center',
               stackratio=1.5, dotsize=1.2)
# Rotate the dot plot
p + coord_flip()

# Add mean and median points
# dot plot with mean points
p + stat_summary(fun.y=mean, geom="point", shape=18,
                 size=3, color="red")
# dot plot with median points
p + stat_summary(fun.y=median, geom="point", shape=18,
                 size=3, color="red")

# Dot plot with box plot and violin plot
# Add basic box plot
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot()+
  geom_dotplot(binaxis='y', stackdir='center')
# Add notched box plot
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot(notch = TRUE)+
  geom_dotplot(binaxis='y', stackdir='center')
# Add violin plot
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_violin(trim = FALSE)+
  geom_dotplot(binaxis='y', stackdir='center')

# Add mean and standard deviation
p <- ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_dotplot(binaxis='y', stackdir='center')
p + stat_summary(fun.data="mean_sdl", fun.args = list(mult=1), 
                 geom="crossbar", width=0.5)
p + stat_summary(fun.data=mean_sdl, fun.args = list(mult=1), 
                 geom="pointrange", color="red")

# Function to produce summary statistics (mean and +/- sd)
data_summary <- function(x) {
  m <- mean(x)
  ymin <- m-sd(x)
  ymax <- m+sd(x)
  return(c(y=m,ymin=ymin,ymax=ymax))
}

# Use a custom summary function :
p + stat_summary(fun.data=data_summary, color="blue")

# Change dot plot colors by groups
# Use single fill color
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_dotplot(binaxis='y', stackdir='center', fill="#FFAAD4")
# Change dot plot colors by groups
p<-ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) +
  geom_dotplot(binaxis='y', stackdir='center')
p

# Use custom color palettes
p + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# Use brewer color palettes
p + scale_fill_brewer(palette="Dark2")
# Use grey scale
p + scale_fill_grey() + theme_classic()

# Change the legend position
p + theme(legend.position="top")
p + theme(legend.position="bottom")
p + theme(legend.position="none") # Remove legend

# Dot plot with multiple groups
# Change dot plot colors by groups
ggplot(ToothGrowth, aes(x=dose, y=len, fill=supp)) +
  geom_dotplot(binaxis='y', stackdir='center')
# Change the position : interval between dot plot of the same group
p<-ggplot(ToothGrowth, aes(x=dose, y=len, fill=supp)) +
  geom_dotplot(binaxis='y', stackdir='center', 
               position=position_dodge(0.8))
p

# Change dot plot colors and add box plots :

# Change colors
p+scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# Add box plots
ggplot(ToothGrowth, aes(x=dose, y=len, fill=supp)) +
  geom_boxplot(fill="white")+
  geom_dotplot(binaxis='y', stackdir='center')
# Change the position
ggplot(ToothGrowth, aes(x=dose, y=len, fill=supp)) +
  geom_boxplot(position=position_dodge(0.8))+
  geom_dotplot(binaxis='y', stackdir='center', 
               position=position_dodge(0.8))

# Customized dot plots
# Basic dot plot
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot()+
  geom_dotplot(binaxis='y', stackdir='center')+
  labs(title="Plot of length  by dose",x="Dose (mg)", y = "Length")+
  theme_classic()
# Change color by groups
dp <-ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) + 
  geom_dotplot(binaxis='y', stackdir='center')+
  labs(title="Plot of length  by dose",x="Dose (mg)", y = "Length")
dp + theme_classic()

# Change fill colors manually
# Continuous colors
dp + scale_fill_brewer(palette="Blues") + theme_classic()
# Discrete colors
dp + scale_fill_brewer(palette="Dark2") + theme_minimal()
# Gradient colors
dp + scale_fill_brewer(palette="RdBu") + theme_minimal()
