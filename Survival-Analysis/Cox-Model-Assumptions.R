# Cox Model Assumptions in R

# Load the packages
library("survival")
library("survminer")

# compute a Cox model
res.cox <- coxph(Surv(time, status) ~ age + sex + wt.loss, data =  lung)
res.cox

# computing a Cox regression model using the lung data set
res.cox <- coxph(Surv(time, status) ~ age + sex + wt.loss, data =  lung)
res.cox

# test for the proportional-hazards (PH) assumption
test.ph <- cox.zph(res.cox)
test.ph

# graphs of the scaled Schoenfeld residuals against the transformed time
ggcoxzph(test.ph)

# Testing influential observations
ggcoxdiagnostics(fit, type = , linear.predictions = TRUE)

ggcoxdiagnostics(res.cox, type = "dfbeta",
                 linear.predictions = FALSE, ggtheme = theme_bw())

# deviance residuals
ggcoxdiagnostics(res.cox, type = "deviance",
                 linear.predictions = FALSE, ggtheme = theme_bw())

# Testing non linearity
ggcoxfunctional(Surv(time, status) ~ age + log(age) + sqrt(age), data = lung)
