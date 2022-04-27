geom_boxplot(outlier.colour="black", outlier.shape=16,
             outlier.size=2, notch=FALSE)

ToothGrowth$dose <- as.factor(ToothGrowth$dose)
head(ToothGrowth)

# Basic box plots
library(ggplot2)
# Basic box plot
p <- ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot()
p
# Rotate the box plot
p + coord_flip()
# Notched box plot
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot(notch=TRUE)
# Change outlier, color, shape and size
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot(outlier.colour="red", outlier.shape=8,
               outlier.size=4)

# Box plot with mean points
p + stat_summary(fun.y=mean, geom="point", shape=23, size=2)

# Choose which items to display :
p + scale_x_discrete(limits=c("0.5", "2"))

# Box plot with dots
# Dots (or points) can be added to a box plot using the functions geom_dotplot() or geom_jitter() :
p + geom_dotplot(binaxis='y', stackdir='center', dotsize=1)
# Box plot with jittered points
# 0.2 : degree of jitter in x direction
p + geom_jitter(shape=16, position=position_jitter(0.2))

# Change box plot colors by groups
# Change box plot line colors
# Box plot line colors can be automatically controlled by the levels of the variable dose :
  
# Change box plot line colors by groups
p<-ggplot(ToothGrowth, aes(x=dose, y=len, color=dose)) + geom_boxplot()
p

# Use custom color palettes
p + scale_color_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# Use brewer color palettes
p + scale_color_brewer(palette="Dark2")
# Use grey scale
p + scale_color_grey() + theme_classic()

# Change box plot fill colors
# Use single color
ggplot(ToothGrowth, aes(x=dose, y=len)) +
  geom_boxplot(fill='#A4A4A4', color="black")+
  theme_classic()

# Change box plot colors by groups
p<-ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) +
  geom_boxplot()
p

# Use custom color palettes
p + scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))
# use brewer color palettes
p + scale_fill_brewer(palette="Dark2")
# Use grey scale
p + scale_fill_grey() + theme_classic()

# Change the legend position
p + theme(legend.position="top")
p + theme(legend.position="bottom")
p + theme(legend.position="right")
p + theme(legend.position="left")
p + theme(legend.position="none") # Remove legend

# Change the order of items in the legend
p + scale_x_discrete(limits=c("2", "0.5", "1"))

# Box plot with multiple groups
# Change box plot colors by groups
ggplot(ToothGrowth, aes(x=dose, y=len, fill=supp)) +
  geom_boxplot()
# Change the position
p<-ggplot(ToothGrowth, aes(x=dose, y=len, fill=supp)) +
  geom_boxplot(position=position_dodge(1))
p

# Change box plot colors and add dots :
# Add dots
p + geom_dotplot(binaxis='y', stackdir='center',
                 position=position_dodge(1))
# Change colors
p+scale_fill_manual(values=c("#999999", "#E69F00", "#56B4E9"))

# Customized box plots
# Basic box plot
ggplot(ToothGrowth, aes(x=dose, y=len)) + 
  geom_boxplot(fill="gray")+
  labs(title="Plot of length per dose",x="Dose (mg)", y = "Length")+
  theme_classic()
# Change  automatically color by groups
bp <- ggplot(ToothGrowth, aes(x=dose, y=len, fill=dose)) + 
  geom_boxplot()+
  labs(title="Plot of length  per dose",x="Dose (mg)", y = "Length")
bp + theme_classic()

# Change fill colors manually
# Continuous colors
bp + scale_fill_brewer(palette="Blues") + theme_classic()
# Discrete colors
bp + scale_fill_brewer(palette="Dark2") + theme_minimal()
# Gradient colors
bp + scale_fill_brewer(palette="RdBu") + theme_minimal()
