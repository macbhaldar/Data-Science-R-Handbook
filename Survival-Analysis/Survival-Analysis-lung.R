library(survival)  # core survival analysis function
library(survminer) # recommended for visualizing survival curves

library(survival)
?lung

dim(lung) # returns the dimensions of the data frame
head(lung) # returns the first few rows from the data
View(lung) # opens the data in the viewer pane

s = Surv(lung$time, lung$status)
class(s)
s

sfit = survfit(s~1)
# or we can also use the following
sfit = survfit(Surv(time, status)~1, data=lung)
# sfit
summary(sfit)

# fit survival curves separately by sex.
sfit = survfit(Surv(time, status)~sex, data=lung)
sfit
summary(sfit)

# Kaplan-Meier Plots
sfit = survfit(Surv(time, status)~sex, data=lung)
plot(sfit)

# ggsurvplot()
library(survminer)
ggsurvplot(sfit)


# Interactive plot
ggsurvplot(sfit,
           conf.int=TRUE, # add confidence intervals
           pval=TRUE, # show the p-value for the log-rank test
           risk.table=TRUE, # show a risk table below the plot
           legend.labs=c("Male", "Female"), # change group labels
           legend.title="Sex",  # add legend title
           palette=c("dodgerblue4", "orchid2"), # change colors of the groups
           title="Kaplan-Meier Curve for Lung Cancer Survival", # add title to plot
           risk.table.height=.2)


ggsurvplot(survfit(Surv(time, status)~inst, data=lung))



fit = coxph(Surv(time, status)~sex, data=lung)
fit

summary(fit)

survdiff(Surv(time, status)~sex, data=lung)


# Testing Proportional Hazards Assumption
test.ph = cox.zph(fit)
test.ph

ggcoxzph(test.ph)


# Testing Influential Observations
ggcoxdiagnostics(fit, type = "dfbeta",
                 linear.predictions = FALSE, ggtheme = theme_bw())


# check outliers by visualizing the deviance residuals.
ggcoxdiagnostics(fit, type = "deviance",
                 linear.predictions = FALSE, ggtheme = theme_bw())

