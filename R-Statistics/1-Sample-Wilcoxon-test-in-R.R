# One-sample Wilcoxon test in R

'''
# Mann-Whitney-Wilcoxon test (also referred as Wilcoxon rank sum test or Mann-Whitney U test), 
used to compare two independent samples. This test is the non-parametric version of 
the Student’s t-test for independent samples.
# The Wilcoxon signed-rank test (also referred as Wilcoxon test for paired samples), 
used to compare two paired samples. This test is the non-parametric version of the Student’s t-test for paired samples.
'''

dat <- data.frame(
  Student_ID = seq(1, 15),
  Score = c(
    17, 5, 1, 10, 4, 18, 17, 15, 7, 4, 5, 14,
    20, 18, 15))
dat


# histogram
hist(dat$Score)

# one-sample Wilcoxon test

#  boxplot
boxplot(dat$Score,
        ylab = "Score")

# boxplot
library(ggplot2)
ggplot(dat, aes(y = Score)) +
  geom_boxplot() +
  labs(y = "Score") +
  theme( # remove axis text and ticks
    axis.text.x = element_blank(),
    axis.ticks = element_blank()
  )

# Descriptive statistics :
round(summary(dat$Score),
      digits = 4)

wilcox.test(dat$Score,
            mu = 10
            )

## Based on the results of the test, (at the significance level of 0.05) 
## we do not reject the null hypothesis, so we do not reject the hypothesis 
## that the scores at this exam are equal to 10, and we cannot conclude that 
## the scores are significantly different from 10 (p-value = 0.3779).

'''
By default, it is a two-tailed test that is done. As for the t.test() function, 
we can specify that a one-sided test is required by using either the alternative = "greater" 
or alternative = "less argument in the wilcox.test() function.


'''

wilcox.test(dat$Score,
            mu = 10, # default value
            alternative = "greater" # H1: scores > 10
            )

## In this case, we still do not reject the hypothesis that scores are equal to 10 and 
## we cannot conclude that scores are significantly higher than 10 (p-value = 0.189).


# Combine statistical test and plot

library(ggstatsplot)
gghistostats(
  data = dat, # dataframe
  x = Score, # variable
  type = "nonparametric", # nonparemetric = Wilcoxon, parametric = t-test
  test.value = 10 # default value
)
