library("readr")
library("tidyverse")

data("iris") # Loading
head(iris, n = 3)

# Create a scatter lot
plot(
  x = iris$Sepal.Length, y = iris$Sepal.Width,
  pch = 19, cex = 0.8, frame = FALSE,
  xlab = "Sepal Length",ylab = "Sepal Width"
)
# Create a box plot
boxplot(Sepal.Length ~ Species, data = iris,
        ylab = "Sepal.Length",
        frame = FALSE, col = "lightgray")

# basic scatter plot of y by x
library("lattice")
xyplot(
  Sepal.Length ~ Petal.Length, group = Species,
  data = iris, auto.key = TRUE, pch = 19, cex = 0.5
)

# Multiple panel plots by groups
xyplot(
  Sepal.Length ~ Petal.Length | Species,
  layout = c(3, 1), # panel with ncol = 3 and nrow = 1
  group = Species, data = iris,
  type = c("p", "smooth"), # Show points and smoothed line
  scales = "free" # Make panels axis scales independent
)

library(ggplot2)
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point()

# Change point size, color and shape
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point(size = 1.2, color = "steelblue", shape = 21)

# To display the different point shape
ggpubr::show_point_shapes()


# Control points color by groups
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point(aes(color = Species, shape = Species))
# Change the default color manually.
# Use the scale_color_manual() function
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point(aes(color = Species, shape = Species))+
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point(aes(color = Species))+
  geom_smooth(aes(color = Species, fill = Species))+
  facet_wrap(~Species, ncol = 3, nrow = 1)+
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))+
  scale_fill_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))

theme_set(
  theme_classic()
)

ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width))+
  geom_point()

library(ggpubr)
# Density plot with mean lines and marginal rug
ggdensity(iris, x = "Sepal.Length",
          add = "mean", rug = TRUE, # Add mean line and marginal rugs
          color = "Species", fill = "Species", # Color by groups
          palette = "jco") # use jco journal color palette

# Groups that we want to compare
my_comparisons <- list(
  c("setosa", "versicolor"), c("versicolor", "virginica"),
  c("setosa", "virginica")
)
# Create the box plot. Change colors by groups: Species
# Add jitter points and change the shape by groups
ggboxplot(
  iris, x = "Species", y = "Sepal.Length",
  color = "Species", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
  add = "jitter"
)+
  stat_compare_means(comparisons = my_comparisons, method = "t.test")

pdf("r-base-plot.pdf")
# Plot 1 --> in the first page of PDF
plot(x = iris$Sepal.Length, y = iris$Sepal.Width)
# Plot 2 ---> in the second page of the PDF
hist(iris$Sepal.Length)
dev.off()


# Create some plots
library(ggplot2)
myplot1 <- ggplot(iris, aes(Sepal.Length, Sepal.Width)) +
  geom_point()
myplot2 <- ggplot(iris, aes(Species, Sepal.Length)) +
  geom_boxplot()
# Print plots to a pdf file
pdf("ggplot.pdf")
print(myplot1) # Plot 1 --> in the first page of PDF
print(myplot2) # Plot 2 ---> in the second page of the PDF
dev.off()


ggplot(diamonds, aes(cut)) +
  geom_bar(fill = "#0073C2FF") +
  theme_pubclean()

# Compute the frequency
library(dplyr)
df <- diamonds %>%
  group_by(cut) %>%
  summarise(counts = n())
df

# Create the bar plot. Use theme_pubclean() [in ggpubr]
ggplot(df, aes(x = cut, y = counts)) +
  geom_bar(fill = "#0073C2FF", stat = "identity") +
  geom_text(aes(label = counts), vjust = -0.3) +
  theme_pubclean()


df <- df %>%
  arrange(desc(cut)) %>%
  mutate(prop = round(counts*100/sum(counts), 1),
         lab.ypos = cumsum(prop) - 0.5*prop)
head(df, 4)

ggplot(df, aes(x = "", y = prop, fill = cut)) +
  geom_bar(width = 1, stat = "identity", color = "white") +
  geom_text(aes(y = lab.ypos, label = prop), color = "white")+
  coord_polar("y", start = 0)+
  ggpubr::fill_palette("jco")+
  theme_void()

ggpie(
  df, x = "prop", label = "prop",
  lab.pos = "in", lab.font = list(color = "white"),
  fill = "cut", color = "white",
  palette = "jco"
)

ggplot(df, aes(cut, prop)) +
  geom_linerange(
    aes(x = cut, ymin = 0, ymax = prop),
    color = "lightgray", size = 1.5
  )+
  geom_point(aes(color = cut), size = 2)+
  ggpubr::color_palette("jco")+
  theme_pubclean()

ggdotchart(
  df, x = "cut", y = "prop",
  color = "cut", size = 3, # Points color and size
  add = "segment", # Add line segments
  add.params = list(size = 2),
  palette = "jco",
  ggtheme = theme_pubclean()
)


set.seed(1234)
wdata = data.frame(
  sex = factor(rep(c("F", "M"), each=200)),
  weight = c(rnorm(200, 55), rnorm(200, 58))
)
head(wdata, 4)



data(HairEyeColor)
HEC <- margin.table(HairEyeColor, 1:2)
HEC
chisq.test(HEC)

round(residuals(chisq.test(HEC)),2)

data(Duncan, package="car") 
plot(~ prestige + income + education, data=Duncan) 
pairs(~ prestige + income + education, data=Duncan)

library(car) 
scatterplotMatrix(~prestige + income + education, data=Duncan, id.n=2)

library(corrplot)
corrplot(cor(wine), tl.srt=30, method="ellipse", order="AOE")

library(effects) 
duncan.eff1 <- allEffects(duncan.mod1) 
plot(duncan.eff1)

library(sem)
union.mod <- specifyEquations(covs="x1, x2", text="
y1 = gam12*x2
y2 = beta21*y1 + gam22*x2
y3 = beta31*y1 + beta32*y2 + gam31*x1
")
union.sem <- sem(union.mod, union, N=173)
pathDiagram(union.sem,
            edge.labels="values",
            file="union-sem1",
            min.rank=c("x1", "x2"))

