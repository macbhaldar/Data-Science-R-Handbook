library(keras)
library(tfhub)
library(tfds)
library(tfdatasets)

# IMDB dataset
imdb <- tfds_load(
  "imdb_reviews:1.0.0", 
  split = list("train[:60%]", "train[-40%:]", "test"), 
  as_supervised = TRUE
)
summary(imdb)

first <- imdb[[1]] %>% 
  dataset_batch(1) %>% # Used to get only the first example
  reticulate::as_iterator() %>% 
  reticulate::iter_next()
str(first)

# Build the model
embedding_layer <- layer_hub(handle = "https://tfhub.dev/google/tf2-preview/gnews-swivel-20dim/1")
embedding_layer(first[[1]])

model <- keras_model_sequential() %>% 
  layer_hub(
    handle = "https://tfhub.dev/google/tf2-preview/gnews-swivel-20dim/1",
    input_shape = list(),
    dtype = tf$string,
    trainable = TRUE
  ) %>% 
  layer_dense(units = 16, activation = "relu") %>% 
  layer_dense(units = 1, activation = "sigmoid")

summary(model)

# Loss function and optimizer
model %>% 
  compile(
    optimizer = "adam",
    loss = "binary_crossentropy",
    metrics = "accuracy"
  )

# Train the model
model %>% 
  fit(
    imdb[[1]] %>% dataset_shuffle(10000) %>% dataset_batch(512),
    epochs = 20,
    validation_data = imdb[[2]] %>% dataset_batch(512),
    verbose = 2
  )

# Evaluate the model
model %>% 
  evaluate(imdb[[3]] %>% dataset_batch(512), verbose = 0)
