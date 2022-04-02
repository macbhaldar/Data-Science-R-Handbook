## Data Acquisition
library(MASS)
data(Boston)
head(Boston)
View(Boston)

## Description of Data
?Boston

## Divide Dataset into two subsets
### Split the data into training and testing sets
set.seed(2)
library(caTools)

split<-sample.split(Boston$mdev, SplitRatio = 0.7)
split

training_data<-subset(Boston,)
testing_data<-subset(Boston,)

## Exploratory Analysis
plot(Boston)

### Scatterplot matrix
attach(Boston)
library(lattice)
splom(~Boston[c(1:7,14)], groups=NULL, data=Boston, axis.line.tck=0, axis.text.alpha=0)

### Regression fit line (rm and medv)
plot(rm,medv)
abline(lm(medv~rm), col="red")

## Correlation Analysis
cr<-cor(Boston)
library(corrplot)
corrplot(cr,type="lower")

plot(Boston$crim, Boston$medv, cex=0.5, xlab="Crime Rate", ylab="Price")

## Variance Inflation Factor (VIF)
install.packages("car")
library(car)
model<-lm(medv~., data = training_data)
vif(model)

## Corrgram
cr<-cor(Boston)
library(corrplot)
corrplot(cr, method="number")

summary(model)

model<-lm(medv~crim+zn+chas+nox+rm+dis+ptratio+black+lstat, data=training_data)

summary(model)

predic<-predict(model,test)
predic

## Model Validation
### green line represent actual price and blue line represent predictive model generated for data
plot(testing_data$medv, type='l', lty=1.8, col="green")
lines(predic, type="l", col="blue")

predic<-predict(model,sample_data)
predic

