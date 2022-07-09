# Chi-Square test is a statistical method to determine if two categorical variables have a significant correlation between them

library("MASS")
print(str(Cars93))

# For our model we will consider the variables "AirBags" and "Type".
# Here we aim to find out any significant correlation between the types of car sold and the type of Air bags it has.
# If correlation is observed we can estimate which types of cars can sell better with what types of air bags.

# Create a data frame from the main data set.
car.data <- data.frame(Cars93$AirBags, Cars93$Type)

# Create a table with the needed variables.
car.data = table(Cars93$AirBags, Cars93$Type) 
print(car.data)

# Perform the Chi-Square test.
print(chisq.test(car.data))

# p-value of less than 0.05 which indicates a string correlation



dat <- iris
dat$size <- ifelse(dat$Sepal.Length < median(dat$Sepal.Length),
                   "small", "big")

table(dat$Species, dat$size)

library(ggplot2)

ggplot(dat) +
  aes(x = Species, fill = size) +
  geom_bar()

ggplot(dat) +
  aes(x = Species, fill = size) +
  geom_bar(position = "fill")

ggplot(dat) +
  aes(x = Species, fill = size) +
  geom_bar(position = "dodge")

test <- chisq.test(table(dat$Species, dat$size))
test

test$statistic # test statistic

test$p.value # p-value

# second method:
summary(table(dat$Species, dat$size))

# third method:
library(vcd)

assocstats(table(dat$Species, dat$size))

library(summarytools)
library(dplyr)

# fourth method:
dat %$%
  ctable(Species, size,
         prop = "r", chisq = TRUE, headings = FALSE
  ) %>%
  print(
    method = "render",
    style = "rmarkdown",
    footnote = NA
  )

library(vcd)

mosaic(~ Species + size,
       direction = c("v", "h"),
       data = dat,
       shade = TRUE)


# ggstatsplot method :
library(ggstatsplot)
library(ggplot2)

ggbarstats(data = dat,
           x = size, y = Species) + 
  labs(caption = NULL)
