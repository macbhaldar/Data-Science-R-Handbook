# One Class SVM

library(tidyverse)
library(skimr) # for EDA
library(corrplot) # for cool correlation graph
library(gt) # for tables
library(e1071) # for svm
library(caret) # for data split
thyroid <- read.csv("thyroid.csv", header = TRUE)

my_skim <- skim_with(numeric = sfl(p25 = NULL, p50 = NULL, p75 = NULL)) 
thyroid_skim <- my_skim(thyroid)

thyroid_skim %>%
  select(-skim_type)   %>% 
  gt() %>%
  cols_label(n_missing = "# Missing", complete_rate = "Completeness", 
             numeric.mean = "Mean", numeric.sd = "Standard Deviation",
             numeric.p0 = "Min", numeric.p100 = "Max",
             numeric.hist = "Histogram") %>%
  opt_stylize(style = 6, color = "blue", add_row_striping = TRUE) %>%
  tab_header(title = "Summary of Variables in Thyroid")

# examining correlation between variables categories
# moving the outcome to the first column to start
# will be sorted by decreasing correlation with outcome
thyroid %>%
  dplyr::select(label, everything()) %>%
  cor %>%
  {.[order(abs(.[, 1]), decreasing = TRUE), 
     order(abs(.[, 1]), decreasing = TRUE)]} %>% 
  corrplot( type = 'lower', tl.col = 'black', 
            addCoef.col = 'black', cl.ratio = 0.2, tl.srt = 45, 
            col = COL2('PuOr', 10), diag = FALSE , mar = c(0,0,2,0),
            title = " Correlations between Thyroid Disease and hormone levels")

# Relabel the classes to TRUE if it is normal data and FALSE if it is
# an anomaly.  (That is, it is false that the outlier data is normal).  
# makes it easier to compare with the output of the SVM model.  
thyroid <- thyroid %>%
  mutate(label = ifelse(label == 0, TRUE, FALSE))

# create data split for test and training
# will be split among strata
set.seed(2346)
inTrain <- createDataPartition(thyroid$label, p = 0.6, list = FALSE) 

# formatting the data as required for svm()
train_predictors <- thyroid[inTrain, 2:7]
train_labels <- thyroid[inTrain, 1]

# Creating the test set
test <- thyroid[-inTrain,]

# formatting the data as required for svm()
test_predictors <- test[,2:7]
test_labels <- test[,1]

#double checking that the test and train sets do contain ~2% disease or rather 98% normal.
mean(train_labels)
# [1] 0.9767055
mean(test_labels)
# [1] 0.9799499


# fitting SVM on training data 
two_class_svm_model <- svm(train_predictors, y = train_labels,
                           type = 'C-classification',
                           scale = TRUE,
                           kernel = "radial")

# now predicting both classes on train and test data
two_class_svm_predtrain <- predict(two_class_svm_model,train_predictors)
two_class_svm_predtest <- predict(two_class_svm_model,test_predictors)


# code below here will be provided
# seeing how well the model did
two_class_confTrain <- table(Predicted = two_class_svm_predtrain, Reference = train_labels)
two_class_confTest <- table(Predicted = two_class_svm_predtest, Reference = test_labels)

# printing out the results
print("These are the predictions on the training data:")
print(two_class_confTrain)

# Predicted FALSE TRUE
# FALSE    12    0
# TRUE      2  587

print("These are the predictions on the test data:")
print(two_class_confTest)

# Predicted FALSE TRUE
# FALSE     6    0
# TRUE      2  391


# subset the labeled data into the two classes
# the normal class should be called "train_normal" and the anomaly
# class should be called "test_outlier"

train_normal_class <- subset(thyroid[inTrain, ], label == TRUE)

train_normal_class_pred <- train_normal_class[,2:7]
train_normal_class_label <- train_normal_class[,1]


# fitting one class SVM on training data- no labels needed! 
one_class_svm_model <- svm(train_normal_class_pred, y = NULL,
                           type = 'one-classification',
                           nu = 0.10,
                           scale = TRUE,
                           kernel = "radial")

# now predicting both classes on train and test data
one_class_svm_predtrain <- predict(one_class_svm_model,train_normal_class_pred)
one_class_svm_predtest <- predict(one_class_svm_model,test_predictors)


# code below here will be provided
# seeing how well the model did
one_class_confTrain <- table(Predicted = one_class_svm_predtrain,
                             Reference = train_normal_class_label)
one_class_confTest <- table(Predicted = one_class_svm_predtest,
                            Reference = test_labels)

# printing out the results
print("These are the predictions on the normal class training data only:")
print(one_class_confTrain)

# Predicted TRUE
# FALSE   61
# TRUE   526

print("These are the predictions on the test data with both classes:")
print(one_class_confTest)


# Predicted FALSE TRUE
# FALSE     8   40
# TRUE      0  351


# This model doesn’t do quite as well, but it is pretty impressive given that it only learned on normal data. 
# It correctly predicted 359/399 data points in the test set. 
# It incorrectly classified 44 cases as abnormal when they were normal, but correctly found all 8 disease cases.
