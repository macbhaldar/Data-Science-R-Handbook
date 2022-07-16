library(MASS)
library(ggplot2)

#attach iris dataset to make it easy to work with
attach(iris)

#view structure of dataset
str(iris)

#scale each predictor variable (i.e. first 4 columns)
iris[1:4] <- scale(iris[1:4])

#find mean of each predictor variable
apply(iris[1:4], 2, mean)

#find standard deviation of each predictor variable
apply(iris[1:4], 2, sd) 

#make this example reproducible
set.seed(1)

#Use 70% of dataset as training set and remaining 30% as testing set
sample <- sample(c(TRUE, FALSE), nrow(iris), replace=TRUE, prob=c(0.7,0.3))
train <- iris[sample, ]
test <- iris[!sample, ]

#fit LDA model
model <- lda(Species~., data=train)

#view model output
model

#use LDA model to make predictions on test data
predicted <- predict(model, test)

names(predicted)

#view predicted class for first six observations in test set
head(predicted$class)

#view posterior probabilities for first six observations in test set
head(predicted$posterior)

#view linear discriminants for first six observations in test set
head(predicted$x)

#find accuracy of model
mean(predicted$class==test$Species)

#define data to plot
lda_plot <- cbind(train, predict(model)$x)

#create plot
ggplot(lda_plot, aes(LD1, LD2)) +
  geom_point(aes(color = Species))
