library(keras)
library(tfdatasets)

TRAIN_DATA_URL <- "https://storage.googleapis.com/tf-datasets/titanic/train.csv"
TEST_DATA_URL <- "https://storage.googleapis.com/tf-datasets/titanic/eval.csv"

train_file_path <- get_file("train_csv", TRAIN_DATA_URL)
test_file_path <- get_file("eval.csv", TEST_DATA_URL)

train_dataset <- make_csv_dataset(
  train_file_path, 
  field_delim = ",",
  batch_size = 5, 
  num_epochs = 1
)

test_dataset <- train_dataset <- make_csv_dataset(
  test_file_path, 
  field_delim = ",",
  batch_size = 5, 
  num_epochs = 1
)

train_dataset %>% 
  reticulate::as_iterator() %>% 
  reticulate::iter_next() %>% 
  reticulate::py_to_r()

# Data preprocessing
spec <- feature_spec(train_dataset, survived ~ .)

spec <- spec %>% 
  step_numeric_column(all_numeric())
spec <- fit(spec)

layer <- layer_dense_features(feature_columns = dense_features(spec))
train_dataset %>% 
  reticulate::as_iterator() %>% 
  reticulate::iter_next() %>% 
  layer()

spec <- feature_spec(train_dataset, survived ~ .)
spec <- spec %>% 
  step_numeric_column(all_numeric(), normalizer_fn = scaler_standard())

spec <- fit(spec)
layer <- layer_dense_features(feature_columns = dense_features(spec))
train_dataset %>% 
  reticulate::as_iterator() %>% 
  reticulate::iter_next() %>% 
  layer()

# Categorical Data
spec <- feature_spec(train_dataset, survived ~ .)
spec <- spec %>% 
  step_categorical_column_with_vocabulary_list(sex) %>% 
  step_indicator_column(sex)

spec <- fit(spec)
layer <- layer_dense_features(feature_columns = dense_features(spec))
train_dataset %>% 
  reticulate::as_iterator() %>% 
  reticulate::iter_next() %>% 
  layer()

spec <- feature_spec(train_dataset, survived ~ .)
spec <- spec %>% 
  step_categorical_column_with_vocabulary_list(all_nominal()) %>% 
  step_indicator_column(all_nominal())

spec <- fit(spec)
layer <- layer_dense_features(feature_columns = dense_features(spec))
train_dataset %>% 
  reticulate::as_iterator() %>% 
  reticulate::iter_next() %>% 
  layer()


spec <- feature_spec(train_dataset, survived ~ .) %>% 
  step_numeric_column(all_numeric(), normalizer_fn = scaler_standard()) %>% 
  step_categorical_column_with_vocabulary_list(all_nominal()) %>% 
  step_indicator_column(all_nominal())

spec <- fit(spec)
layer <- layer_dense_features(feature_columns = dense_features(spec))
train_dataset %>% 
  reticulate::as_iterator() %>% 
  reticulate::iter_next() %>% 
  layer()

# Building the model
  model <- keras_model_sequential() %>% 
  layer_dense_features(feature_columns = dense_features(spec)) %>% 
  layer_dense(units = 128, activation = "relu") %>% 
  layer_dense(units = 128, activation = "relu") %>% 
  layer_dense(units = 1, activation = "sigmoid")

model %>% compile(
  loss = "binary_crossentropy",
  optimizer = "adam",
  metrics = "accuracy"
)

# Train, evaluate and predict
model %>% 
  fit(
    train_dataset %>% dataset_use_spec(spec) %>% dataset_shuffle(500),
    epochs = 20,
    validation_data = test_dataset %>% dataset_use_spec(spec),
    verbose = 2
  )

model %>% evaluate(test_dataset %>% dataset_use_spec(spec), verbose = 0)

batch <- test_dataset %>% 
  reticulate::as_iterator() %>% 
  reticulate::iter_next() %>% 
  reticulate::py_to_r()
predict(model, batch)
