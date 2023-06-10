library(MASS)       # Boston dataset
library(neuralnet)  # Neuralnet
library(plyr)       # Progress bar

#-------------------------------------------------------------------------------
# Cross validating function

crossvalidate <- function(data,hidden_l=c(5))
{
  # @params
  
  # data          Boston dataset (data.frame)
  # hidden_l      a numeric vector with number of neurons for each hidden layer
  #               default to 5.
  
  # Scaling the data (min-max scaling)
  maxs <- apply(data, 2, max) 
  mins <- apply(data, 2, min)
  scaled <- as.data.frame(scale(data, center = mins, scale = maxs - mins))
  
  # Initialize cv.error vector
  cv.error <- NULL
  
  # Number of train-test splits
  k <- 10
  
  # Cross validating
  for(j in 1:k)
  {
    # Train-test split
    index <- sample(1:nrow(data),round(0.90*nrow(data)))
    train.cv <- scaled[index,]
    test.cv <- scaled[-index,]
    
    # NN fitting
    nn <- neuralnet(f,data=train.cv,hidden=hidden_l,linear.output=T)
    
    # Predicting
    pr.nn <- compute(nn,test.cv[,1:13])
    
    # Scaling back the predicted results
    pr.nn <- pr.nn$net.result*(max(data$medv)-min(data$medv))+min(data$medv)
    
    # Real results
    test.cv.r <- (test.cv$medv)*(max(data$medv)-min(data$medv))+min(data$medv)
    
    # Calculating MSE test error
    cv.error[j] <- sum((test.cv.r - pr.nn)^2)/nrow(test.cv)
  }
  
  # Return average MSE
  return(mean(cv.error))
}


#-------------------------------------------------------------------------------
# Selecting the number of neurons in the hidden layer

# Data
data_ <- Boston

# Initializing test and train error vectors
test.error <- NULL
train.error <- NULL

# Scaling for NN
maxs <- apply(data_, 2, max) 
mins <- apply(data_, 2, min)
scaled <- as.data.frame(scale(data_, center = mins, scale = maxs - mins))

n <- names(scaled)
f <- as.formula(paste("medv ~", paste(n[!n %in% "medv"], collapse = " + ")))

# Generate progress bar
pbar <- create_progress_bar('text')
pbar$init(13)

set.seed(100)
# Testing and Cross validating (may take a while to compute)
for(i in 1:13)
{
  # Fit the net and calculate training error (point estimate)
  nn <- neuralnet(f,data=scaled,hidden=c(i),linear.output=T)
  train.error[i] <- sum(((as.data.frame(nn$net.result)*(50-5)+5) - (scaled$medv*(50-5)+5))^2)/nrow(scaled)
  
  # Calculate test error through cross validation
  test.error[i] <- crossvalidate(data_,hidden_l=c(i))
  
  # Step bar
  pbar$step()
}

# Print out test and train error vectors
test.error
train.error

# Plot train error
plot(train.error,main='MSE vs hidden neurons',xlab="Hidden neurons",ylab='Train error MSE',type='l',col='red',lwd=2)
# Plot test error
plot(test.error,main='MSE vs hidden neurons',xlab="Hidden neurons",ylab='Test error MSE',type='l',col='blue',lwd=2)

# Number of neurons (index) that minimizes test/train error
which(min(test.error) == test.error)
which(min(train.error) == train.error)


# OUTPUT
# > test.error
# [1] 22.82344411 16.13144091 16.35637622 12.86887359 15.84075405 14.70836452 20.43786279
# [8] 12.94021827 15.17841040 15.73359030 11.69016703 15.68187249 16.93568278
# > train.error
# [1] 15.683925574 12.194213697  6.402039438  5.371200418  5.380425196  4.680551267  3.724397391
# [8]  3.263892267  5.063878109  3.828094951  2.893202998  3.136577085  3.097630997
#  
# > which(min(test.error) == test.error)
# [1] 11
# > which(min(train.error) == train.error)
# [1] 11