# setting working directory
setwd("~/R-Files/Handbook")

# reading data
titanic <- read.csv("Titanic.csv")

# viewing data
View(titanic)

# structure of the data
str(titanic)

## removing insignificant variables
titanic <- subset(titanic, select = c(2,3,5,6,7,8,10,12))

## checking if the variable are categorical or not
is.factor(titanic$Sex)
# [1] TRUE
is.factor(titanic$Embarked)
# [1] TRUE

#removing missing value by Knn Approach
library(DMwR2)
?knnImputation
titanic <- knnImputation(titanic)

#spliting data into train and test 
dim(titanic)
# [1] 891   8
train <- titanic[1:800,]
test <- titanic[801:891,]

## Model Creation
model <- glm(Survived ~.,family=binomial(link='logit'),data=train)

## Model Summary
summary(model)

## Using anova() to analyze the table of devaiance
anova(model, test="Chisq")

## Predicting Test Data
result <- predict(model,newdata=test,type='response')
result <- ifelse(result > 0.5,1,0)

## Confusion matrix and statistics
library(caret)
confusionMatrix(data=result, test$Survived)

## ROC Curve and calculating the area under the curve(AUC)
library(ROCR2)
predictions <- predict(model, newdata=test, type="response")
ROCRpred <- prediction(predictions, test$Survived)
ROCRperf <- performance(ROCRpred, measure = "tpr", x.measure = "fpr")

plot(ROCRperf, colorize = TRUE, text.adj = c(-0.2,1.7), print.cutoffs.at = seq(0,1,0.1))