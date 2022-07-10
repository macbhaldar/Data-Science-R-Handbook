# one-sample t-test

# variance of the population is known

dat1 <- data.frame(
  value = c(0.9, -0.8, 1.3, -0.3, 1.7)
)

dat1

library(ggplot2)

ggplot(dat1) +
  aes(y = value) +
  geom_boxplot() +
  theme_minimal()

boxplot(dat1$value)

t.test2 <- function(x, V, m0 = 0, alpha = 0.05, alternative = "two.sided") {
  M <- mean(x)
  n <- length(x)
  sigma <- sqrt(V)
  S <- sqrt(V / n)
  statistic <- (M - m0) / S
  p <- if (alternative == "two.sided") {
    2 * pnorm(abs(statistic), lower.tail = FALSE)
  } else if (alternative == "less") {
    pnorm(statistic, lower.tail = TRUE)
  } else {
    pnorm(statistic, lower.tail = FALSE)
  }
  LCL <- (M - S * qnorm(1 - alpha / 2))
  UCL <- (M + S * qnorm(1 - alpha / 2))
  value <- list(mean = M, m0 = m0, sigma = sigma, statistic = statistic, p.value = p, LCL = LCL, UCL = UCL, alternative = alternative)
  return(value)
}

test <- t.test2(dat1$value,
                V = 1
)
test

test$p.value

library(BSDA)

z.test(dat1$value,
       alternative = "two.sided",
       mu = 0,
       sigma.x = 1,
       conf.level = 0.95
)


# variance of the population is unknown

dat2 <- data.frame(
  value = c(7.9, 5.8, 6.3, 7.3, 6.7)
)

dat2

ggplot(dat2) +
  aes(y = value) +
  geom_boxplot() +
  theme_minimal()

test <- t.test(dat2$value,
               mu = 5,
               alternative = "greater"
)

test

test$p.value


# Confidence interval

test$conf.int

# Combination of plot and statistical test

# variance of the population is unknown

library(ggstatsplot)
library(ggplot2)

gghistostats(
  data = dat2, # dataframe from which variable is to be taken
  x = value, # numeric variable whose distribution is of interest
  type = "parametric", # for student's t-test
  test.value = 5 # default value is 0
) +
  labs(caption = NULL)

