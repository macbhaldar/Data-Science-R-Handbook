# Survival Analysis

## Overview
**Survival analysis** lets you analyze the rates of occurrence of events over time, without assuming the rates are constant. Generally, survival analysis lets you model the time until an event occurs, or compare the time-to-event between different groups, or how time-to-event correlates with quantitative variables.

The **hazard** is the instantaneous event (death) rate at a particular time point t. Survival analysis doesn’t assume the hazard is constant over time. The cumulative hazard is the total hazard experienced up to time t.

The **survival function**, is the probability an individual survives (or, the probability that the event of interest does not occur) up to and including time t. It’s the probability that the event (e.g., death) hasn’t occured yet. It looks like this, where T is the time of death, and $$Pr(T>t)$$ is the probability that the time of death is greater than some time t. S is a probability, so $$0≤S(t)≤1$$, since survival times are always positive (T≥0).

$$ S(t)= P_r(T>t) $$

The **Kaplan-Meier curve** illustrates the survival function. It’s a step function illustrating the cumulative survival probability over time. The curve is horizontal over periods where no event occurs, then drops vertically corresponding to a change in the survival function at each time an event occurs.

**Censoring** is a type of missing data problem unique to survival analysis. This happens when you track the sample/subject through the end of the study and the event never occurs. This could also happen due to the sample/subject dropping out of the study for reasons other than death, or some other loss to followup. The sample is censored in that you only know that the individual survived up to the loss to followup, but you don’t know anything about survival after that.

**Proportional hazards assumption**: The main goal of survival analysis is to compare the survival functions in different groups, e.g., leukemia patients as compared to cancer-free controls. If you followed both groups until everyone died, both survival curves would end at 0%, but one group might have survived on average a lot longer than the other group. Survival analysis does this by comparing the hazard at different times over the observation period. Survival analysis doesn’t assume that the hazard is constant, but does assume that the ratio of hazards between groups is constant over time. This class does not cover methods to deal with non-proportional hazards, or interactions of covariates with the time to event.

**Proportional hazards regression** a.k.a. Cox regression is the most common approach to assess the effect of different variables on survival.

## Cox Proportional Hazards Model
Kaplan-Meier curves are good for visualizing differences in survival between two categories5, but they do not work well for assessing the effect of quantitative variables like age, gene expression, leukocyte count, etc.

Cox proportional hazards (PH) regression can assess the effect of both categorical and continuous variables, and can model the effect of multiple variables at once.

Cox PH regression models the natural log of the hazard at time t, denoted by h(t), as a function of the baseline hazard, *h<sub>0</sub>(t)* (the hazard for an individual where all exposure variables are 0), and multiple exposure variables *x1, x2,…, xp*.

$$ log(h(t))=log(h_0(t))+\beta_1x_1 +\beta_2x_2 + ... + \beta_px_p $$

If we limit the right hand side to just a single categorical exposure variable (x<sub>1</sub>) with two groups (x1]<sub>1</sub>=1 for exposed and x<sub>1</sub>=0 for unexposed), the previous equation is equivalent to:

$$ h_1(t)=h_0(t)+e $$

HR(t)  is the hazard ratio, comparing the exposed to the unexposed individuals at time t.

This model shows that the hazard ratio is $$e^{β_1}$$ 
and remains constant over time t (hence the name proportional hazards regression).

The βs are the regression coefficients that are estimated from the model, and represent the log(HR) for each unit increase in the corresponding predictor variable.

The interpretation of the hazard ratio depends on the measurement scale of the predictor variable. In simple terms for the variable in question,
- a β>0 indicates more hazard than baseline and hence worse survival, and
- a β<0 indicates less hazard than baseline and hence better survival.

## Getting Started with R

The core survival analysis functions are in the survival package. The survival package is one of the few “core” packages that comes bundled with your basic R installation, so you probably did not need to use `install.packages()`. However, you will need to load it like any other library when you want to use it.

We will also want to load the survminer package, which provides much nicer Kaplan-Meier plots compared to base graphics.

```r
library(survival)  # core survival analysis function
library(survminer) # recommended for visualizing survival curves
```

The core functions we will use out of the survival package include:

- `Surv()`: creates the response variable (survival object), and typical usage takes the time-to-event,6 and whether or not the event occurred (i.e., death vs censored).
- `survfit()`: Fits a survival curve using either a formula, or a previously fitted Cox model. It creates a survival curve which could be displayed or plotted.
- `coxph()`: Fits a Cox proportional hazards regression model. Models are specified the same way as in regular linear models (e.g. lm()).

Other optional functions you might use include:

- `cox.zph()`: Tests the proportional hazards assumption of a Cox regression model.
- `survdiff()`: Tests for differences in survival between two groups using a log-rank / Mantel-Haenszel test

We will use the built-in lung cancer data set8 in the survival package. You can get some more information about the data set by running ?lung.

```r
library(survival)
?lung
```

`inst`: Institution code

`time`: Survival time in days

`status`: censoring status 1=censored, 2=dead

`age`: Age in years

`sex`: Male=1 Female=2

`ph.ecog`: ECOG performance score (0=good 5=dead)

`ph.karno`: Karnofsky performance score as rated by physician

`pat.karno`: Karnofsky performance score as rated by patient

`meal.cal`: Calories consumed at meals

`wt.loss`: Weight loss in last six months

```r
dim(lung) # returns the dimensions of the data frame
head(lung) # returns the first few rows from the data
View(lung) # opens the data in the viewer pane
```

## Survival Curves
### `Surv()`
This is the main function we will use to create the survival object.

They will match time and event in that order.

This is the common shorthand for right-censored data. The alternative lets you specify interval data, where you give it the start and end times (time and time2).

`Surv` function tries to guess the coding of the status variable. It will try to guess whether you are using 0/1 or 1/2 to represent censored vs death, respectively.

```r
s = Surv(lung$time, lung$status)
class(s)
s
```

### `survfit()`
Fit a survival curve with the survfit() function.

```r
sfit = survfit(s~1)
# or we can also use the following
sfit = survfit(Surv(time, status)~1, data=lung)
# sfit

summary(sfit)
```

Fit survival curves separately by sex.

```r
sfit = survfit(Surv(time, status)~sex, data=lung)
sfit

summary(sfit)
```

## Kaplan-Meier Plots

Kaplan-Meier plot is used to visualize the survival curve fit to the data.
To do this we can use the `plot()` function on the fitted survival curve sfit.

```r
sfit = survfit(Surv(time, status)~sex, data=lung)
plot(sfit)
```

Output :

![plot_ly](./images/sfit-plot.png)

### `ggsurvplot()`
It is much easier to produce publication-ready survival plots, and if you are familiar with `ggplot2` syntax it is pretty easy to modify.

```r
library(survminer)
ggsurvplot(sfit)
```

Output :

![plot_ly](./images/sfit-gg.png)

```r
ggsurvplot(sfit,
           conf.int=TRUE, # add confidence intervals
           pval=TRUE, # show the p-value for the log-rank test
           risk.table=TRUE, # show a risk table below the plot
           legend.labs=c("Male", "Female"), # change group labels
           legend.title="Sex",  # add legend title
           palette=c("dodgerblue4", "orchid2"), # change colors of the groups
           title="Kaplan-Meier Curve for Lung Cancer Survival", # add title to plot
           risk.table.height=.2)
```

Output :

![plot_ly](./images/sfit-ggint.png)

## Cox Regression

Kaplan-Meier curves are good for visualizing differences in survival between two categorical groups. The p-value for the log-rank test provided when pval=TRUE is also useful for identifying any differences in survival between different groups.

However, this does not generalize well for assessing the effect of quantitative variables.

Just try creating a K-M plot for the nodes variable, which has values that range from 0−33.

```r
ggsurvplot(survfit(Surv(time, status)~inst, data=lung))
```


Output :

![plot_ly](./images/km-plot.png)

At some point using a categorical grouping for K-M plots breaks down, more so when we might want to assess how multiple variables work together to influence survival.

For example, we might want to simultaneously examine the effect of race and socioeconomic status (so as to adjust for factors like income, access to care, etc.) before concluding that ethnicity influences some outcome.

### Model Fit
Cox PH regression can assess the effect of both categorical and continuous variables, and can model the effect of multiple variables at once.

The `coxph()` function uses the same syntax as `lm()`, `glm()`, etc.

```r
fit = coxph(Surv(time, status)~sex, data=lung)
fit
```

Output :

```
Call:
coxph(formula = Surv(time, status) ~ sex, data = lung)

       coef exp(coef) se(coef)      z       p
sex -0.5310    0.5880   0.1672 -3.176 0.00149

Likelihood ratio test=10.63  on 1 df, p=0.001111
n= 228, number of events= 165 
```

The `exp(coef)` column contains $$e^β_1$$. This is the hazard ratio – the multiplicative effect of that variable on the hazard rate (for each unit increase in that variable).

For a categorical variable like `sex`, going from male (baseline) to female results in approximately ~40% reduction in hazard.

We could also flip the sign on the `coef` column, and take `exp(0.531)`, which can be interpreted as:

- Males have a 1.7-fold increase in hazard, or that
- Males die at approximately 1.7× the rate per unit time as females (females die at 0.588× the rate per unit time as males).

Remember:

- HR=1: No effect
- HR>1: Increase in hazard
- HR<1: Decrease in hazard

There is a p-value on the sex term, and a p-value on the overall model.

- That 0.00111 p-value is really close to the p=0.00131 p-value we saw on the Kaplan-Meier plot.
- That is because the KM plot is showing the log-rank test p-value.


We can get this out of the Cox model with a call to `summary(fit)`.
```r
summary(fit)
```
Output
```
Call:
coxph(formula = Surv(time, status) ~ sex, data = lung)

  n= 228, number of events= 165 

       coef exp(coef) se(coef)      z Pr(>|z|)   
sex -0.5310    0.5880   0.1672 -3.176  0.00149 **
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

    exp(coef) exp(-coef) lower .95 upper .95
sex     0.588      1.701    0.4237     0.816

Concordance= 0.579  (se = 0.021 )
Likelihood ratio test= 10.63  on 1 df,   p=0.001
Wald test            = 10.09  on 1 df,   p=0.001
Score (logrank) test = 10.33  on 1 df,   p=0.001
```

We can directly calculate the log-rank test p-value using `survdiff()`.
```r
survdiff(Surv(time, status)~sex, data=lung)
```


Output
```
Call:
survdiff(formula = Surv(time, status) ~ sex, data = lung)

        N Observed Expected (O-E)^2/E (O-E)^2/V
sex=1 138      112     91.6      4.55      10.3
sex=2  90       53     73.4      5.68      10.3

 Chisq= 10.3  on 1 degrees of freedom, p= 0.001 
```

### Testing Proportional Hazards Assumption
The proportional hazards (PH) assumption can be checked using statistical tests and graphical diagnostics based on the scaled Schoenfeld residuals.

In principle, the Schoenfeld residuals are independent of time. A plot that shows a non-random pattern against time is evidence of violation of the PH assumption.

The function `cox.zph()` provides a convenient solution to test the proportional hazards assumption for each covariate included in a Cox regression model fit.

```r
test.ph = cox.zph(fit)
test.ph
```

Output

```
       chisq df     p
sex     2.86  1 0.091
GLOBAL  2.86  1 0.091
```

graphical diagnostic using the function ggcoxzph()

```r
ggcoxzph(test.ph)
```

Output :

![plot_ly](./images/ggcoxzph.png)

### Testing Influential Observations

```r
ggcoxdiagnostics(fit, type = "dfbeta",
                 linear.predictions = FALSE, ggtheme = theme_bw())
```

Output :

![plot_ly](./images/dfbeta.png)

### Outliers by visualizing the deviance residuals

```r
ggcoxdiagnostics(fit, type = "deviance",
                 linear.predictions = FALSE, ggtheme = theme_bw())
```

Output :

![plot_ly](./images/deviance.png)
