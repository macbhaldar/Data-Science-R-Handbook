# Survival Analysis in R
# Survival analysis is a set of statistical approaches for data analysis where the outcome variable of interest is time until an event occurs.
# Survival analysis deals with predicting the time when a specific event is going to occur. 
# It is also known as failure time analysis or analysis of time to death. 
# For example predicting the number of days a person with cancer will survive 
# or predicting the time when a mechanical system is going to fail.

install.packages("survival")

# Load the library.
library("survival")
library("survminer")

# Print first few rows.
print(head(pbc))

# Create the survival object. 
survfit(Surv(pbc$time,pbc$status == 2)~1)

# Plot the graph. 
plot(survfit(Surv(pbc$time,pbc$status == 2)~1))


# Survival Analysis lung dataset
data("lung")
head(lung)

fit <- survfit(Surv(time, status) ~ sex, data = lung)
print(fit)

# Summary of survival curves
summary(fit)
# Access to the sort summary table
summary(fit)$table

d <- data.frame(time = fit$time,
                n.risk = fit$n.risk,
                n.event = fit$n.event,
                n.censor = fit$n.censor,
                surv = fit$surv,
                upper = fit$upper,
                lower = fit$lower
)
head(d)

# Change color, linetype by strata, risk.table color by strata
ggsurvplot(fit,
           pval = TRUE, conf.int = TRUE,
           risk.table = TRUE, # Add risk table
           risk.table.col = "strata", # Change risk table color by groups
           linetype = "strata", # Change line type by groups
           surv.median.line = "hv", # Specify median survival
           ggtheme = theme_bw(), # Change ggplot2 theme
           palette = c("#E7B800", "#2E9FDF"))

ggsurvplot(
  fit,                     # survfit object with calculated statistics.
  pval = TRUE,             # show p-value of log-rank test.
  conf.int = TRUE,         # show confidence intervals for 
  # point estimaes of survival curves.
  conf.int.style = "step",  # customize style of confidence intervals
  xlab = "Time in days",   # customize X axis label.
  break.time.by = 200,     # break X axis in time intervals by 200.
  ggtheme = theme_light(), # customize plot and risk table with a theme.
  risk.table = "abs_pct",  # absolute number and percentage at risk.
  risk.table.y.text.col = T,# colour risk table text annotations.
  risk.table.y.text = FALSE,# show bars instead of names in text annotations
  # in legend of risk table.
  ncensor.plot = TRUE,      # plot the number of censored subjects at time t
  surv.median.line = "hv",  # add the median survival pointer.
  legend.labs = 
    c("Male", "Female"),    # change legend labels.
  palette = 
    c("#E7B800", "#2E9FDF") # custom color palettes.
)

# survival curves can be shorten using the argument xlim
ggsurvplot(fit,
           conf.int = TRUE,
           risk.table.col = "strata", # Change risk table color by groups
           ggtheme = theme_bw(), # Change ggplot2 theme
           palette = c("#E7B800", "#2E9FDF"),
           xlim = c(0, 600))

# to plot cumulative events
ggsurvplot(fit,
           conf.int = TRUE,
           risk.table.col = "strata", # Change risk table color by groups
           ggtheme = theme_bw(), # Change ggplot2 theme
           palette = c("#E7B800", "#2E9FDF"),
           fun = "event")

# To plot cumulative hazard
ggsurvplot(fit,
           conf.int = TRUE,
           risk.table.col = "strata", # Change risk table color by groups
           ggtheme = theme_bw(), # Change ggplot2 theme
           palette = c("#E7B800", "#2E9FDF"),
           fun = "cumhaz")

# Kaplan-Meier life table: summary of survival curves
summary(fit)
res.sum <- surv_summary(fit)
head(res.sum)

# Log-Rank test comparing survival curves: survdiff()
surv_diff <- survdiff(Surv(time, status) ~ sex, data = lung)
surv_diff

# Fit complex survival curves
require("survival")
fit2 <- survfit( Surv(time, status) ~ sex + rx + adhere,
                 data = colon )

# Plot survival curves by sex and facet by rx and adhere
ggsurv <- ggsurvplot(fit2, fun = "event", conf.int = TRUE,
                     ggtheme = theme_bw())

ggsurv$plot +theme_bw() + 
  theme (legend.position = "right")+
  facet_grid(rx ~ adhere)
