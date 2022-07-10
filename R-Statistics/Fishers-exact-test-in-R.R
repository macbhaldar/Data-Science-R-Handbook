# Fisher's exact test in R

dat <- data.frame(
  "smoke_no" = c(7, 0),
  "smoke_yes" = c(2, 5),
  row.names = c("Athlete", "Non-athlete"),
  stringsAsFactors = FALSE
)
colnames(dat) <- c("Non-smoker", "Smoker")

dat

mosaicplot(dat,
           main = "Mosaic plot",
           color = TRUE
)

chisq.test(dat)$expected

test <- fisher.test(dat)
test

test$p.value

fisher.test(table(dat$variable1, dat$variable2))

# create dataframe from contingency table
x <- c()
for (row in rownames(dat)) {
  for (col in colnames(dat)) {
    x <- rbind(x, matrix(rep(c(row, col), dat[row, col]), ncol = 2, byrow = TRUE))
  }
}
df <- as.data.frame(x)
colnames(df) <- c("Sport_habits", "Smoking_habits")
df

# Fisher's exact test with raw data
test <- fisher.test(table(df))

# combine plot and statistical test with ggbarstats
library(ggstatsplot)
ggbarstats(
  df, Smoking_habits, Sport_habits,
  results.subtitle = FALSE,
  subtitle = paste0(
    "Fisher's exact test", ", p-value = ",
    ifelse(test$p.value < 0.001, "< 0.001", round(test$p.value, 3))
  )
)

