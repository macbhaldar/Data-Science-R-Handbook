library(datasets)
library(h2o)

h2o.init(nthreads = -1)
data(iris)

iris.hex <- as.h2o(iris)
h2o.ls()

h2o.describe(iris.hex)

h2o.hist(iris.hex$Sepal.Length)

iris.hex$foo <- iris.hex$Sepal.Length + 2

h2o.describe(iris.hex)

iris.hex$foo <- NULL

r_df <- as.data.frame(iris.hex)

splits <- h2o.splitFrame(data = iris.hex,
                         ratios = c(0.8),  #partition data into 80% and 20% chunks
                         seed = 198)

train <- splits[[1]]
test <- splits[[2]]

print(paste0("Number of rows in train set: ", h2o.nrow(train)))
## [1] "Number of rows in train set: 117"
print(paste0("Number of rows in test set: ", h2o.nrow(test)))
## [1] "Number of rows in test set: 33"

rf <- h2o.randomForest(x = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
                       y = c("Species"),
                       training_frame = train,
                       model_id = "our.rf",
                       seed = 1234)

print(rf)

rf_perf1 <- h2o.performance(model = rf, newdata = test)
print(rf_perf1)

predictions <- h2o.predict(rf, test)
print(predictions)
