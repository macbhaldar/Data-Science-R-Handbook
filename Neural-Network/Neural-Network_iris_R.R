library(neuralnet)
library(caret)

head(iris)

NN = neuralnet(Species ~., iris, hidden = c(5,3))
plot(NN)

pred = neuralnet::compute(NN, iris[,c(1,2,3,4)])
View(pred)

pred.2 <- data.frame()
for(i in 1:150){
  pred.2 <- rbind(pred.2, which.max(pred$net.result[i,]))
}

View(pred.2)

pred[["net.result"]]

pred.2$X1L <- gsub(1, "setosa", pred.2$X1L)
pred.2$X1L <- gsub(2, "versicolor", pred.2$X1L)
pred.2$X1L <- gsub(3, "virginica", pred.2$X1L)

prediction <- as.factor(pred.2$X1L)
reference <- iris[,5]
reference

confusionMatrix(prediction, reference)
