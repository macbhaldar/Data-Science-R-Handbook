# Student’s t-test in R

# Independent samples with 2 known variances

dat1 <- data.frame(
  sample1 = c(0.9, -0.8, 0.1, -0.3, 0.2),
  sample2 = c(0.8, -0.9, -0.1, 0.4, 0.1)
)
dat1

dat_ggplot <- data.frame(
  value = c(0.9, -0.8, 0.1, -0.3, 0.2, 0.8, -0.9, -0.1, 0.4, 0.1),
  sample = c(rep("1", 5), rep("2", 5))
)

library(ggplot2)

ggplot(dat_ggplot) +
  aes(x = sample, y = value) +
  geom_boxplot() +
  theme_minimal()

boxplot(value ~ sample,
        data = dat_ggplot
)

t.test_knownvar <- function(x, y, V1, V2, m0 = 0, alpha = 0.05, alternative = "two.sided") {
  M1 <- mean(x)
  M2 <- mean(y)
  n1 <- length(x)
  n2 <- length(y)
  sigma1 <- sqrt(V1)
  sigma2 <- sqrt(V2)
  S <- sqrt((V1 / n1) + (V2 / n2))
  statistic <- (M1 - M2 - m0) / S
  p <- if (alternative == "two.sided") {
    2 * pnorm(abs(statistic), lower.tail = FALSE)
  } else if (alternative == "less") {
    pnorm(statistic, lower.tail = TRUE)
  } else {
    pnorm(statistic, lower.tail = FALSE)
  }
  LCL <- (M1 - M2 - S * qnorm(1 - alpha / 2))
  UCL <- (M1 - M2 + S * qnorm(1 - alpha / 2))
  value <- list(mean1 = M1, mean2 = M2, m0 = m0, sigma1 = sigma1, sigma2 = sigma2, S = S, statistic = statistic, p.value = p, LCL = LCL, UCL = UCL, alternative = alternative)
  return(value)
}

test <- t.test_knownvar(dat1$sample1, dat1$sample2,
                        V1 = 1, V2 = 1
)
test

test$p.value

library(BSDA)

z.test(dat1$sample1,
       dat1$sample2,
       alternative = "two.sided",
       mu = 0,
       sigma.x = 1,
       sigma.y = 1,
       conf.level = 0.95
)


# Independent samples with 2 equal but unknown variances

dat2 <- data.frame(
  sample1 = c(1.78, 1.5, 0.9, 0.6, 0.8, 1.9),
  sample2 = c(0.8, -0.7, -0.1, 0.4, 0.1, NA)
)
dat2

dat_ggplot <- data.frame(
  value = c(1.78, 1.5, 0.9, 0.6, 0.8, 1.9, 0.8, -0.7, -0.1, 0.4, 0.1),
  sample = c(rep("1", 6), rep("2", 5))
)

ggplot(dat_ggplot) +
  aes(x = sample, y = value) +
  geom_boxplot() +
  theme_minimal()

test <- t.test(dat2$sample1, dat2$sample2,
               var.equal = TRUE, alternative = "greater"
)
test

test$p.value

# install.packages("remotes")
# remotes::install_github("easystats/report") # You only need to do that once
library("report")

report(test)

dat2bis <- data.frame(
  value = c(1.78, 1.5, 0.9, 0.6, 0.8, 1.9, 0.8, -0.7, -0.1, 0.4, 0.1),
  sample = c(rep("1", 6), rep("2", 5))
)
dat2bis

test <- t.test(value ~ sample,
               data = dat2bis,
               var.equal = TRUE,
               alternative = "greater"
)
test

test$p.valuetest$p.value


# Independent samples with 2 unequal and unknown variances

dat3 <- data.frame(
  value = c(0.8, 0.7, 0.1, 0.4, 0.1, 1.78, 1.5, 0.9, 0.6, 0.8, 1.9),
  sample = c(rep("1", 5), rep("2", 6))
)
dat3

ggplot(dat3) +
  aes(x = sample, y = value) +
  geom_boxplot() +
  theme_minimal()

test <- t.test(value ~ sample,
               data = dat3,
               var.equal = FALSE,
               alternative = "less"
)
test

test$p.value


# Paired samples where the variance of the differences is known

dat4 <- data.frame(
  before = c(0.9, -0.8, 0.1, -0.3, 0.2),
  after = c(0.8, -0.9, -0.1, 0.4, 0.1)
)
dat4

dat4$difference <- dat4$after - dat4$before

ggplot(dat4) +
  aes(y = difference) +
  geom_boxplot() +
  theme_minimal()

t.test_pairedknownvar <- function(x, V, m0 = 0, alpha = 0.05, alternative = "two.sided") {
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
  # print(sprintf("P-value = %g",p))
  # print(sprintf("Lower %.2f%% Confidence Limit = %g",
  #               alpha, LCL))
  # print(sprintf("Upper %.2f%% Confidence Limit = %g",
  #               alpha, UCL))
  return(value)
}

test <- t.test_pairedknownvar(dat4$after - dat4$before,
                              V = 1
)
test

test$p.value


# Paired samples where the variance of the differences is unknown

dat5 <- data.frame(
  before = c(9, 8, 1, 3, 2),
  after = c(16, 11, 15, 12, 9)
)
dat5

dat5$difference <- dat5$after - dat5$before

ggplot(dat5) +
  aes(y = difference) +
  geom_boxplot() +
  theme_minimal()

test <- t.test(dat5$after, dat5$before,
               alternative = "greater",
               paired = TRUE
)
test

dat5 <- data.frame(
  value = c(9, 8, 1, 3, 2, 16, 11, 15, 12, 9),
  time = c(rep("before", 5), rep("after", 5))
)
dat5

test <- t.test(value ~ time,
               data = dat5,
               alternative = "greater",
               paired = TRUE
)
test

test$p.value


# Combination of plot and statistical test
# Independent samples with 2 equal but unknown variances

# load package
library(ggstatsplot)
library(ggplot2)

# plot with statistical results
ggbetweenstats(
  data = dat2bis,
  x = sample,
  y = value,
  plot.type = "box", # for boxplot
  type = "parametric", # for student's t-test
  var.equal = TRUE, # equal variances
  centrality.plotting = FALSE # remove mean
) +
  labs(caption = NULL)

# Independent samples with 2 unequal and unknown variances

# plot with statistical results
ggbetweenstats(
  data = dat3,
  x = sample,
  y = value,
  plot.type = "box", # for boxplot
  type = "parametric", # for student's t-test
  var.equal = FALSE, # unequal variances
  centrality.plotting = FALSE # remove mean
) +
  labs(caption = NULL)

# Paired samples where the variance of the differences is unknown

ggwithinstats(
  data = dat5,
  x = time,
  y = value,
  type = "parametric", # for student's t-test
  centrality.plotting = FALSE # remove mean
) +
  labs(caption = NULL)
