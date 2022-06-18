library(keras)

mnist <- dataset_mnist()

c(train_images, train_labels) %<-% mnist$train
c(test_images, test_labels) %<-% mnist$test

train_labels <- train_labels[1:1000]
test_labels <- test_labels[1:1000]

train_images <- train_images[1:1000, , ] %>%
  array_reshape(c(1000, 28 * 28))
train_images <- train_images / 255

test_images <- test_images[1:1000, , ] %>%
  array_reshape(c(1000, 28 * 28))
test_images <- test_images / 255

# Returns a short sequential model
create_model <- function() {
  model <- keras_model_sequential() %>%
    layer_dense(units = 512, activation = "relu", input_shape = 784) %>%
    layer_dropout(0.2) %>%
    layer_dense(units = 10, activation = "softmax")
  model %>% compile(
    optimizer = "adam",
    loss = "sparse_categorical_crossentropy",
    metrics = list("accuracy")
  )
  model
}

model <- create_model()
summary(model)

# Save Model format
model <- create_model()
model %>% fit(train_images, train_labels, epochs = 5, verbose = 2)

model %>% save_model_tf("model")

list.files("model")

new_model <- load_model_tf("model")
summary(new_model)

# HDF5 FORMAT
model <- create_model()
model %>% fit(train_images, train_labels, epochs = 5, verbose = 2)

model %>% save_model_hdf5("my_model.h5")

new_model <- load_model_hdf5("my_model.h5")
summary(new_model)

# Train the model and pass it the callback_model_checkpoint:
checkpoint_path <- "checkpoints/cp.ckpt"

# Create checkpoint callback
cp_callback <- callback_model_checkpoint(
  filepath = checkpoint_path,
  save_weights_only = TRUE,
  verbose = 0
)

model <- create_model()

model %>% fit(
  train_images,
  train_labels,
  epochs = 10, 
  validation_data = list(test_images, test_labels),
  callbacks = list(cp_callback),  # pass callback to training
  verbose = 2
)

list.files(dirname(checkpoint_path))

fresh_model <- create_model()
fresh_model %>% evaluate(test_images, test_labels, verbose = 0)

fresh_model %>% load_model_weights_tf(filepath = checkpoint_path)
fresh_model %>% evaluate(test_images, test_labels, verbose = 0)
