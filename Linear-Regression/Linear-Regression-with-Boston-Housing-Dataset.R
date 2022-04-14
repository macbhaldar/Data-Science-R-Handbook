library(readr)
library(ggplot2)
library(corrplot)
library(mlbench)
library(Amelia)
library(plotly)
library(reshape2)
library(caret)
library(caTools)
library(dplyr)

data(BostonHousing)
housing <- BostonHousing
str(housing)

head(housing)

summary(housing)

missmap(housing,col=c('yellow','black'),y.at=1,y.labels='',legend=TRUE)

corrplot(cor(select(housing,-chas)))

#visualizing the distribution of the target variable 

housing %>% 
  ggplot(aes(medv)) +
  stat_density() + 
  theme_bw()

# medv Density using plotly
ggplotly(housing %>% 
           ggplot(aes(medv)) +
           stat_density() + 
           theme_bw())

housing %>%
  select(c(crim, rm, age, rad, tax, lstat, medv,indus,nox,ptratio,zn)) %>%
  melt(id.vars = "medv") %>%
  ggplot(aes(x = value, y = medv, colour = variable)) +
  geom_point(alpha = 0.7) +
  stat_smooth(aes(colour = "black")) +
  facet_wrap(~variable, scales = "free", ncol = 2) +
  labs(x = "Variable Value", y = "Median House Price ($1000s)") +
  theme_minimal()

#set a seed 
set.seed(123)

#Split the data , `split()` assigns a booleans to a new column based on the SplitRatio specified. 

split <- sample.split(housing,SplitRatio =0.75)


train <- subset(housing,split==TRUE)
test <- subset(housing,split==FALSE)

# train <- select(train,-b)
# test <- select(test,-b)

model <- lm(medv ~ crim + rm + tax + lstat , data = train)
summary(model)

res <- residuals(model)

# Convert residuals to a DataFrame 

res <- as.data.frame(res)

ggplot(res,aes(res)) +  geom_histogram(fill='blue',alpha=0.5)

plot(model)

test$predicted.medv <- predict(model,test)

pl1 <-test %>% 
  ggplot(aes(medv,predicted.medv)) +
  geom_point(alpha=0.5) + 
  stat_smooth(aes(colour='black')) +
  xlab('Actual value of medv') +
  ylab('Predicted value of medv')+
  theme_bw()

ggplotly(pl1)

error <- test$medv-test$predicted.medv
rmse <- sqrt(mean(error)^2)

# The Root Mean Square Error (RMSE) for our Model is 0.7602882
