# Statistical Modeling in R

library(tidyverse)
library(sjPlot)
library(lme4)

url = "https://raw.githubusercontent.com/ccs-amsterdam/r-course-material/master/data/piketty_capital.csv"
capital = read_csv(url)
head(capital)

# T-test
anglo = c("U.S.", "U.K.", "Canada", "Australia")
capital = mutate(capital, Group = ifelse(capital$Country %in% anglo, "anglo", "european"))
table(capital$Group)

t.test(capital$Private ~ capital$Group)

pergroup = capital %>% 
  na.omit() %>% 
  group_by(Year, Group) %>% 
  summarize(Private=mean(Private))

library(ggplot2)
pergroup %>% 
  ggplot + geom_line(aes(x=Year, y=Private, colour=Group))

pergroup = pivot_wider(pergroup, names_from = Group, values_from = Private)

t.test(pergroup$anglo, pergroup$european, paired=T)

mean(pergroup$anglo, na.rm = T)
sd(pergroup$anglo, na.rm = T)

mean(pergroup$european, na.rm = T)
sd(pergroup$european, na.rm = T)

# Anova
capital = mutate(capital, Country = as.factor(Country))
plot(capital$Private ~ capital$Country)

m = aov(capital$Private ~ capital$Country)
summary(m)

posthoc = pairwise.t.test(capital$Private, capital$Country, p.adj = "bonf")
round(posthoc$p.value, 3)

capital %>%
  group_by(Country) %>%
  summarise(M = mean(Private, na.rm = T), SD = sd(Private, na.rm = T))

# Linear Models
m = lm(Private ~ Country + Public, data=capital)  
summary(m)

m = lm(Private ~ -1 + Country + Public, data=capital)
summary(m)

m1 = lm(Private ~ Group + Public, data=capital)
m2 = lm(Private ~ Group + Public + Group:Public, data=capital)

## remember to first install with install.packages('sjPlot')
library(sjPlot)
tab_model(m1, m2)

tab_model(m1,m2, file = 'model.html')

browseURL('model.html')

m1 = lm(Private ~ Group + Public, data=capital)
m2 = lm(Private ~ Group + Public + Group:Public, data=capital)
anova(m1, m2)

par(mfrow=c(2,2))
plot(m)

par(mfrow=c(1,1))

library(jmv)

ANOVA(capital, dep = 'Private', factors = 'Country', postHoc = 'Country')

ttestIS(capital, vars = 'Private', group = 'Group', plots=T)


# Logistic Regression
d = mutate(iris, versicolor = as.numeric(Species == 'versicolor'))
head(d)

m = glm(versicolor ~ Sepal.Length + Sepal.Width, family = binomial, data = d)
tab_model(m)

odds = 3270.76         ## intercept
odds = odds * 1.14     ## sepal length is 1, so multiply by 1.14 once
odds = odds * 0.04^2   ## sepal width is 2, so multiply by 0.04 twice
odds / (odds + 1)      ## transform odds to probability

predict(m, type='response',
        newdata = data.frame(Sepal.Length = 1, Sepal.Width = 2))

m_base = glm(versicolor ~ 1, family = binomial, data = d)
m1 = glm(versicolor ~ Sepal.Length + Sepal.Width, family = binomial, data = d)
m2 = glm(versicolor ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width, family = binomial, data = d)
anova(m_base, m1,m2, test="Chisq")

tab_model(m1,m2)

plot_model(m2, type = 'pred', terms = 'Sepal.Width')

p = plot_model(m2, type = 'pred')     ## creates a list of plots
plot_grid(p)

# Multilevel models
head(sleepstudy)

d = data.frame(Reaction = c(0,1,7,9,17,16,12,10,29,27,24,22,39,36,33,30,49,47,42,42),
               Days = c(1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4,1,2,3,4),
               Subject = c(1,1,1,1,2,2,2,2,3,3,3,3,4,4,4,4,5,5,5,5))

cols = rainbow(5)  # make colors for 5 subjects
plot(d$Days, d$Reaction, col=cols[d$Subject], pch=16)

m = lm(Reaction ~ Days, data=d)
tab_model(m)

plot(d$Days, d$Reaction, col=cols[d$Subject], pch=16)
abline(coef(m)[1], coef(m)[2])

# Multilevel model with random intercepts
m_ri = lmer(Reaction ~ Days + (1 | Subject), data=d)

tab_model(m_ri)

plot(d$Days, d$Reaction, col=cols[d$Subject], pch=16)
for (i in 1:5) {  ## for each subject
  abline(coef(m_ri)$Subject[i,1], coef(m_ri)$Subject[i,2], col=cols[i])
}

# Multilevel model with random intercepts and random slopes
m_rs = lmer(Reaction ~ Days + (1 + Days| Subject), data=d)
tab_model(m_rs)

plot(d$Days, d$Reaction, col=cols[d$Subject], pch=16)  ## redo the plot for clarity
for (i in 1:5) {  ## for each subject
  abline(coef(m_rs)$Subject[i,1], coef(m_rs)$Subject[i,2], col=cols[i])
}

# Comparing multilevel models
m_base = lmer(Reaction ~ (1 | Subject), data=d)
m1 = lmer(Reaction ~ Days + (1 | Subject), data=d)
m2 = lmer(Reaction ~ Days + (1 + Days| Subject), data=d)
anova(m_base,m1,m2)

tab_model(m_base,m1,m2)
