# create data frame
df <- data.frame(y=c(6, 8, 12, 14, 14, 15, 17, 22, 24, 23),
                 x1=c(2, 5, 4, 3, 4, 6, 7, 5, 8, 9),
                 x2=c(14, 12, 12, 13, 7, 8, 7, 4, 6, 5))

# view data frame
df

library(caret)

# specify the cross-validation method
ctrl <- trainControl(method = "cv", number = 5)

# fit a regression model and use k-fold CV to evaluate performance
model <- train(y ~ x1 + x2, data = df, method = "lm", trControl = ctrl)

# view summary of k-fold CV               
print(model)

# view final model
model$finalModel

# view predictions for each fold
model$resample
