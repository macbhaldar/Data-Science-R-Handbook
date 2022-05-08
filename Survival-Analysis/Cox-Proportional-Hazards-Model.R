# Cox proportional-hazards model (Cox, 1972) is essentially a regression model 
# commonly used statistical in medical research for investigating the association
# between the survival time of patients and one or more predictor variables.

# Load the packages
library("survival")
library("survminer")

# compute the Cox model: coxph()
coxph(formula, data, method)

# use the lung cancer data in the survival R package.
data("lung")
head(lung)

# Univariate Cox regression
res.cox <- coxph(Surv(time, status) ~ sex, data = lung)
res.cox

summary(res.cox)

# apply the univariate coxph function to multiple covariates at once
covariates <- c("age", "sex",  "ph.karno", "ph.ecog", "wt.loss")
univ_formulas <- sapply(covariates,
                        function(x) as.formula(paste('Surv(time, status)~', x)))

univ_models <- lapply( univ_formulas, function(x){coxph(x, data = lung)})
# Extract data 
univ_results <- lapply(univ_models,
                       function(x){ 
                         x <- summary(x)
                         p.value<-signif(x$wald["pvalue"], digits=2)
                         wald.test<-signif(x$wald["test"], digits=2)
                         beta<-signif(x$coef[1], digits=2);#coeficient beta
                         HR <-signif(x$coef[2], digits=2);#exp(beta)
                         HR.confint.lower <- signif(x$conf.int[,"lower .95"], 2)
                         HR.confint.upper <- signif(x$conf.int[,"upper .95"],2)
                         HR <- paste0(HR, " (", 
                                      HR.confint.lower, "-", HR.confint.upper, ")")
                         res<-c(beta, HR, wald.test, p.value)
                         names(res)<-c("beta", "HR (95% CI for HR)", "wald.test", 
                                       "p.value")
                         return(res)
                         #return(exp(cbind(coef(x),confint(x))))
                       })
res <- t(as.data.frame(univ_results, check.names = FALSE))
as.data.frame(res)

# Multivariate Cox regression analysis
# Cox regression of time to death on the time-constant covariates
res.cox <- coxph(Surv(time, status) ~ age + sex + ph.ecog, data =  lung)
summary(res.cox)

# Visualizing the estimated distribution of survival times
# Plot the baseline survival function
ggsurvplot(survfit(res.cox), color = "#2E9FDF",
           ggtheme = theme_minimal())

# Create the new data  
sex_df <- with(lung,
               data.frame(sex = c(1, 2), 
                          age = rep(mean(age, na.rm = TRUE), 2),
                          ph.ecog = c(1, 1)
               )
)
sex_df

# Survival curves
fit <- survfit(res.cox, newdata = sex_df)
ggsurvplot(fit, conf.int = TRUE, legend.labs=c("Sex=1", "Sex=2"),
           ggtheme = theme_minimal())
