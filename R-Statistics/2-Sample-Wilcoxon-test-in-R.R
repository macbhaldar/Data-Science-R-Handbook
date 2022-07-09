# Two sample Wilcoxon test in R: 
## how to compare 2 groups under the non-normality assumption

'''
Wilcoxon test is used to compare two groups and see whether they are 
significantly different from each other in terms of the variable of interest.
'''

'''
The two groups to be compared are either:
- independent, or
- paired (i.e., dependent)
'''

'''
There are actually two versions of the Wilcoxon test:
1. The Mann-Withney-Wilcoxon test 
(also referred as Wilcoxon rank sum test or Mann-Whitney U test) is performed 
when the samples are independent (so this test is the non-parametric equivalent 
to the Student’s t-test for independent samples).
2. The Wilcoxon signed-rank test 
(also sometimes referred as Wilcoxon test for paired samples) is performed 
when the samples are paired/dependent (so this test is the non-parametric equivalent 
to the Student’s t-test for paired samples).
'''

# Independent samples
'''
## For the Wilcoxon test with independent samples, 
## suppose that we want to test whether grades at the statistics exam differ 
## between female and male students.
'''

data1 <- data.frame(
  Sex = as.factor(c(rep("Girl", 12), rep("Boy", 12))),
  Grade = c(
    19, 18, 9, 17, 8, 7, 16, 19, 20, 9, 11, 18,
    16, 5, 15, 2, 14, 15, 4, 7, 15, 6, 7, 14))
data1

# distributions of the grades by sex
library(ggplot2)

ggplot(data1) +
  aes(x = Sex, y = Grade) +
  geom_boxplot(fill = "#007fff") +
  theme_minimal()

# Grades for Boys
hist(subset(data1, Sex == "Boy")$Grade,
     main = "Grades for boys",
     xlab = "Grades")

# Grades for girls
hist(subset(data1, Sex == "Girl")$Grade,
     main = "Grades for girls",
     xlab = "Grades")

# Shapiro-Wilk test
shapiro.test(subset(data1, Sex == "Girl")$Grade)
shapiro.test(subset(data1, Sex == "Boy")$Grade)

'''
The histograms show that both distributions do not seem to follow a normal distribution 
and the p-values of the Shapiro-Wilk tests confirm it (since we reject 
the null hypothesis of normality for both distributions at the 5% significance level).
We just showed that normality assumption is violated for both groups 
so it is now time to see how to perform the Wilcoxon test in R.
'''

'''
Note that in order to use the Student’s t-test (the parametric version of the Wilcoxon test), 
it is required that both samples follow a normal distribution if samples are small. 
Therefore, even if one sample follows a normal distribution 
and the other does not follow a normal distribution, 
it is recommended to use the non-parametric test.
'''

test <- wilcox.test(data1$Grade ~ data1$Sex)
test

## p-value is 0.02056. Therefore, at the 5% significance level, we reject the null hypothesis 
## and we conclude that grades are significantly different between girls and boys.

test <- wilcox.test(data1$Grade ~ data1$Sex,
                    alternative = "less")
test

## p-value is 0.01028. Therefore, at the 5% significance level, we reject the null hypothesis 
## and we conclude that girls performed significantly better than boys.


# Paired samples
'''
For paired samples scenario, consider that we administered a math test in 
a class of 12 students at the beginning of a semester, and that we administered 
a similar test at the end of the semester to the exact same students.
'''

data2 <- data.frame(
  Beginning = c(16, 5, 15, 2, 14, 15, 4, 7, 15, 6, 7, 14),
  End = c(19, 18, 9, 17, 8, 7, 16, 19, 20, 9, 11, 18))
data2

# transform the dataset to have it in a tidy format:

data2 <- data.frame(
  Time = c(rep("Before", 12), rep("After", 12)),
  Grade = c(data2$Beginning, data2$End))
data2

# distribution of the grades at the beginning and after the semester:
data2$Time <- factor(data2$Time,
                      levels = c("Before", "After"))

ggplot(data2) +
  aes(x = Time, y = Grade) +
  geom_boxplot(fill = "#007fff") +
  theme_minimal()

'''
In this example, it is clear that the two samples are not independent 
since the same 12 students took the exam before and after the semester.
we thus use the Wilcoxon test for paired samples.
'''

test <- wilcox.test(data2$Grade ~ data2$Time,
                    paired = TRUE)
test

## p-value is 0.1692. Therefore, at the 5% significance level, we do not reject 
## the null hypothesis that the grades are similar before and after the semester.


# Combination of plot and statistical test

# Independent samples
## For independent samples, ggbetweenstats() function is used:
library(ggstatsplot)
ggbetweenstats(
  data = data1,
  x = Sex,
  y = Grade,
  plot.type = "box", # for boxplot
  type = "nonparametric", # for wilcoxon
  centrality.plotting = FALSE # remove median
)

# Paired samples
## For paired samples, ggwithinstats() function is used:
library(ggstatsplot)
ggwithinstats(
  data = data2,
  x = Time,
  y = Grade,
  type = "nonparametric", # for wilcoxon
  centrality.plotting = FALSE # remove median
)
