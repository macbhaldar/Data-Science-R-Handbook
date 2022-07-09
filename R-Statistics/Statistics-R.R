# R program to import data into R

# Import the data using read.csv()
myData = read.csv("CardioGoodFitness.csv",
                  stringsAsFactors=F)
# Print the first 6 rows
print(head(myData))

# Descriptive Analysis

# Compute the mean value
mean = mean(myData$Age)
print(mean)

# Compute the median value
median = median(myData$Age)
print(median)

# Compute the mode value
mode = function(){
  return(sort(-table(myData$Age))[1])
}
mode()

library(modest)

# Compute the mode value using modest library
mode = mfv(myData$Age)
print(mode)

# R program to get average of a list

# Taking a list of elements
list = c(2, 4, 4, 4, 5, 5, 7, 9)

# Calculating average using mean()
print(mean(list))

# Calculating average using mean()
print(mean(list))

# Calculating variance using var()
print(var(list))

# Calculating variance using var()
print(var(list))

# Calculating standard deviation using sd()
print(sd(list))
