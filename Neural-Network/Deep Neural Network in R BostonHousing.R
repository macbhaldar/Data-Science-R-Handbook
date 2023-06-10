# 
library(keras)
library(mlbench)
library(dplyr)
library(magrittr)
library(neuralnet)

data("BostonHousing")
data <- BostonHousing
str(data)

data %<>% mutate_if(is.factor, as.numeric)

n <- neuralnet(medv ~ crim+zn+indus+chas+nox+rm+age+dis+rad+tax+ptratio+b+lstat,
               data = data,
               hidden = c(12,7),
               linear.output = F,
               lifesign = 'full',
               rep=1)

plot(n,col.hidden = 'darkgreen',     
     col.hidden.synapse = 'darkgreen',
     show.weights = F,
     information = F,
     fill = 'lightblue')

data <- as.matrix(data)
dimnames(data) <- NULL

set.seed(123)
ind <- sample(2, nrow(data), replace = T, prob = c(.7, .3))
training <- data[ind==1,1:13]
test <- data[ind==2, 1:13]
trainingtarget <- data[ind==1, 14]
testtarget <- data[ind==2, 14]
str(trainingtarget)
str(testtarget)

m <- colMeans(training)
s <- apply(training, 2, sd)
training <- scale(training, center = m, scale = s)
test <- scale(test, center = m, scale = s)

model <- keras_model_sequential()
model %>%
  layer_dense(units = 5, activation = 'relu', input_shape = c(13)) %>%
  layer_dense(units = 1)

model %>% compile(loss = 'mse',
                  optimizer = 'rmsprop', 
                  metrics = 'mae') 

mymodel <- model %>%          
  fit(training,trainingtarget,
      epochs = 100,
      batch_size = 32,
      validation_split = 0.2)

model %>% evaluate(test, testtarget)
pred <- model %>% predict(test)
mean((testtarget-pred)^2) 

plot(testtarget, pred) 

model %>%
  layer_dense(units = 100, activation = 'relu', input_shape = c(13)) %>%
  layer_dropout(rate=0.4)  %>%
  layer_dense(units = 50, activation = 'relu')  %>%
  layer_dropout(rate=0.2)  %>%
  layer_dense(units = 1)
