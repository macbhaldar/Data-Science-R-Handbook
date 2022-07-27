# Basic line plots
# Generate some data
df <- data.frame(time=c("breakfeast", "Lunch", "Dinner"),
                 bill=c(10, 30, 15))
head(df)

# Create line plots and change line types
library(ggplot2)
# Basic line plot with points
ggplot(data=df, aes(x=time, y=bill, group=1)) +
  geom_line()+
  geom_point()
# Change the line type
ggplot(data=df, aes(x=time, y=bill, group=1)) +
  geom_line(linetype = "dashed")+
  geom_point()

# Line plot with multiple groups
df2 <- data.frame(sex = rep(c("Female", "Male"), each=3),
                  time=c("breakfeast", "Lunch", "Dinner"),
                  bill=c(10, 30, 15, 13, 40, 17) )
head(df2)

# Line plot with multiple groups
ggplot(data=df2, aes(x=time, y=bill, group=sex)) +
  geom_line()+
  geom_point()
# Change line types
ggplot(data=df2, aes(x=time, y=bill, group=sex)) +
  geom_line(linetype="dashed")+
  geom_point()
# Change line colors and sizes
ggplot(data=df2, aes(x=time, y=bill, group=sex)) +
  geom_line(linetype="dotted", color="red", size=2)+
  geom_point(color="blue", size=3)

# Change automatically the line types by groups
# Change line types by groups (sex)
ggplot(df2, aes(x=time, y=bill, group=sex)) +
  geom_line(aes(linetype=sex))+
  geom_point()+
  theme(legend.position="top")
# Change line types + colors
ggplot(df2, aes(x=time, y=bill, group=sex)) +
  geom_line(aes(linetype=sex, color=sex))+
  geom_point(aes(color=sex))+
  theme(legend.position="top")

# Set line types manually
ggplot(df2, aes(x=time, y=bill, group=sex)) +
  geom_line(aes(linetype=sex))+
  geom_point()+
  scale_linetype_manual(values=c("twodash", "dotted"))+
  theme(legend.position="top")
# Change line colors and sizes
ggplot(df2, aes(x=time, y=bill, group=sex)) +
  geom_line(aes(linetype=sex, color=sex, size=sex))+
  geom_point()+
  scale_linetype_manual(values=c("twodash", "dotted"))+
  scale_color_manual(values=c('#999999','#E69F00'))+
  scale_size_manual(values=c(1, 1.5))+
  theme(legend.position="top")
