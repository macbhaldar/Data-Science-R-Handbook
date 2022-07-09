# ANOVA
## ANOVA (ANalysis Of VAriance) is a statistical test to determine 
## whether two or more population means are different. In other words, 
## it is used to compare two or more groups to see if they are significantly different.

# install.packages("palmerpenguins")
library(palmerpenguins)
library(tidyverse)

peg <- penguins %>%
  select(species, flipper_length_mm)

## The dataset contains data for 344 penguins of 3 different species (Adelie, Chinstrap and Gentoo). 
## The dataset contains 8 variables, but we focus only on the flipper length and the species 

summary(peg)

library(ggplot2)

ggplot(peg) +
  aes(x = species, y = flipper_length_mm, color = species) +
  geom_jitter() +
  theme(legend.position = "none")


res_aov <- aov(flipper_length_mm ~ species,
               data = peg)


par(mfrow = c(1, 2)) # combine plots

# histogram
hist(res_aov$residuals)

# QQ-plot
library(car)
qqPlot(res_aov$residuals,
       id = FALSE # id = FALSE to remove point identification
)


shapiro.test(res_aov$residuals)


# Boxplot
boxplot(flipper_length_mm ~ species,
        data = peg)

# Dotplot
library("lattice")
dotplot(flipper_length_mm ~ species,
        data = peg)

# Levene's test
library(car)
leveneTest(flipper_length_mm ~ species,
           data = peg)

# Another method to test normality and homogeneity
par(mfrow = c(1, 2)) # combine plots

# 1. Homogeneity of variances
plot(res_aov, which = 3)

# 2. Normality
plot(res_aov, which = 2)

# Outliers

# boxplot(flipper_length_mm ~ species, data = peg)

library(ggplot2)
ggplot(peg) +
  aes(x = species, y = flipper_length_mm) +
  geom_boxplot()

# Descriptive statistics
aggregate(flipper_length_mm ~ species,
          data = peg,
          function(x) round(c(mean = mean(x), sd = sd(x)), 2))

library(dplyr)
group_by(peg, species) %>%
  summarise(
    mean = mean(flipper_length_mm, na.rm = TRUE),
    sd = sd(flipper_length_mm, na.rm = TRUE))


# ANOVA
## With the oneway.test() function:
oneway.test(flipper_length_mm ~ species,
            data = peg,
            var.equal = TRUE)

## With the summary() and aov() functions:
res_aov <- aov(flipper_length_mm ~ species,
               data = peg)
summary(res_aov)

oneway.test(flipper_length_mm ~ species,
            data = peg,
            var.equal = FALSE)

# Interpretations of ANOVA results
# install.packages("remotes")
# remotes::install_github("easystats/report") # You only need to do that once

library("report")
report(res_aov)

library(multcomp)

# Tukey HSD test:
post_test <- glht(res_aov,
                  linfct = mcp(species = "Tukey")
)

summary(post_test)

par(mar = c(3, 8, 3, 3))
plot(post_test)


TukeyHSD(res_aov)

plot(TukeyHSD(res_aov))

# Dunnett’s test
library(multcomp)

# Dunnett's test:
post_test <- glht(res_aov,
                  linfct = mcp(species = "Dunnett")
)

summary(post_test)

par(mar = c(3, 8, 3, 3))
plot(post_test)

# Change reference category:
peg$species <- relevel(peg$species, ref = "Gentoo")

# Check that Gentoo is the reference category:
levels(peg$species)

res_aov2 <- aov(flipper_length_mm ~ species,
                data = peg)

# Dunnett's test:
post_test <- glht(res_aov2,
                  linfct = mcp(species = "Dunnett"))
summary(post_test)

par(mar = c(3, 8, 3, 3))
plot(post_test)

# pairwise.t.test
pairwise.t.test(peg$flipper_length_mm, peg$species,
                p.adjust.method = "holm")

# Visualization of ANOVA and post-hoc tests on the same plot
x <- which(names(peg) == "species") # name of grouping variable
y <- which(names(peg) == "flipper_length_mm" # names of variables to test
           )
method1 <- "anova" # one of "anova" or "kruskal.test"
method2 <- "t.test" # one of "wilcox.test" or "t.test"
my_comparisons <- list(c("Chinstrap", "Adelie"), c("Gentoo", "Adelie"), c("Gentoo", "Chinstrap")) # comparisons for post-hoc tests
# Edit until here


# Edit at your own risk
library(ggpubr)
for (i in y) {
  for (j in x) {
    p <- ggboxplot(peg,
                   x = colnames(peg[j]), y = colnames(peg[i]),
                   color = colnames(peg[j]),
                   legend = "none",
                   palette = "npg",
                   add = "jitter"
    )
    print(
      p + stat_compare_means(aes(label = paste0(..method.., ", p-value = ", ..p.format..)),
                             method = method1, label.y = max(peg[, i], na.rm = TRUE)
      )
      + stat_compare_means(comparisons = my_comparisons, method = method2, label = "p.format") # remove if p-value of ANOVA or Kruskal-Wallis test >= alpha
    )
  }
}

# ggstatsplot method
library(ggstatsplot)
ggbetweenstats(
  data = peg,
  x = species,
  y = flipper_length_mm,
  type = "parametric", # ANOVA or Kruskal-Wallis
  var.equal = TRUE, # ANOVA or Welch ANOVA
  plot.type = "box",
  pairwise.comparisons = TRUE,
  pairwise.display = "significant",
  centrality.plotting = FALSE,
  bf.message = FALSE
)
