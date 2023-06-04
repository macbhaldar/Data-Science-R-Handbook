# Fitting complex mixed models with nlme

rm(list=ls())
library(nlme)
library(emmeans)
## Welcome to emmeans.
## NOTE -- Important change from versions <= 1.41:
##     Indicator predictors are now treated as 2-level factors by default.
##     To revert to old behavior, use emm_options(cov.keep = character(0))
Block <- factor(rep(c(1:3), 42))
Var <- factor(rep(LETTERS[1:7],each=18))
Loc <- factor(rep(rep(letters[1:6], each=3), 7))
P1 <- factor(Loc:Block)
Yield <- c(60,65,60,80,65,75,70,75,70,72,82,90,48,45,50,50,40,40,
           80,90,83,70,60,60,85,90,90,70,85,80,40,40,40,38,40,50,
           25,28,30,40,35,35,35,30,30,40,35,35,35,25,20,35,30,30,
           50,65,50,40,40,40,48,50,52,45,45,50,50,50,45,40,48,40,
           52,50,55,55,54,50,40,40,60,48,38,45,38,30,40,35,40,35,
           22,25,25,30,28,32,28,25,30,26,28,28,45,50,45,50,50,50,
           30,30,25,28,34,35,40,45,35,30,32,35,45,35,38,44,45,40)
dataFull <- data.frame(Block, Var, Loc, Yield)
rm(Block, Var, Loc, P1, Yield)
head(dataFull)
##   Block Var Loc Yield
## 1     1   A   a    60
## 2     2   A   a    65
## 3     3   A   a    60
## 4     1   A   b    80
## 5     2   A   b    65
## 6     3   A   b    75

library(dplyr)
dataFull <- dataFull %>%
  group_by(Loc) %>% 
  mutate(ej = mean(Yield) - mean(dataFull$Yield))
head(dataFull)
## # A tibble: 6 x 5
## # Groups:   Loc [2]
##   Block Var   Loc   Yield    ej
##   <fct> <fct> <fct> <dbl> <dbl>
## 1 1     A     a        60 1.45 
## 2 2     A     a        65 1.45 
## 3 3     A     a        60 1.45 
## 4 1     A     b        80 0.786
## 5 2     A     b        65 0.786
## 6 3     A     b        75 0.786

mod.aov <- lm(Yield ~ Loc/Block + Var*Loc, data = dataFull)
anova(mod.aov)
## Analysis of Variance Table
## 
## Response: Yield
##           Df  Sum Sq Mean Sq  F value    Pr(>F)    
## Loc        5  1856.0   371.2  17.9749 1.575e-11 ***
## Var        6 20599.2  3433.2 166.2504 < 2.2e-16 ***
## Loc:Block 12   309.8    25.8   1.2502    0.2673    
## Loc:Var   30 12063.6   402.1  19.4724 < 2.2e-16 ***
## Residuals 72  1486.9    20.7                       
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# Augmented ANOVA model
mod.aov2 <- lm(Yield ~ Loc/Block + Var/ej + Loc:Var, data=dataFull)
anova(mod.aov2)
## Analysis of Variance Table
## 
## Response: Yield
##           Df  Sum Sq Mean Sq  F value    Pr(>F)    
## Loc        5  1856.0   371.2  17.9749 1.575e-11 ***
## Var        6 20599.2  3433.2 166.2504 < 2.2e-16 ***
## Loc:Block 12   309.8    25.8   1.2502    0.2673    
## Var:ej     6  9181.2  1530.2  74.0985 < 2.2e-16 ***
## Loc:Var   24  2882.5   120.1   5.8159 2.960e-09 ***
## Residuals 72  1486.9    20.7                       
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

# Finlay-Wilkinson model
modFull1 <- lme(Yield ~ Var/ej - 1, 
                random = list(Loc = pdIdent(~ Var - 1),
                              Loc = pdIdent(~ Block - 1)), 
                data=dataFull)
summary(modFull1)$tTable
##              Value Std.Error  DF    t-value      p-value
## VarA    63.1666667 2.4017164 107 26.3006350 1.624334e-48
## VarB    66.1666667 2.4017164 107 27.5497417 2.135264e-50
## VarC    31.8333333 2.4017164 107 13.2544097 2.599693e-24
## VarD    47.1111111 2.4017164 107 19.6156012 3.170228e-37
## VarE    44.7222222 2.4017164 107 18.6209421 2.378452e-35
## VarF    34.2777778 2.4017164 107 14.2722004 1.614127e-26
## VarG    35.8888889 2.4017164 107 14.9430169 6.028635e-28
## VarA:ej  3.2249875 0.6257787 107  5.1535588 1.176645e-06
## VarB:ej  4.7936139 0.6257787 107  7.6602379 8.827229e-12
## VarC:ej  0.4771074 0.6257787 107  0.7624219 4.474857e-01
## VarD:ej  0.3653064 0.6257787 107  0.5837629 5.606084e-01
## VarE:ej  1.2369950 0.6257787 107  1.9767291 5.064533e-02
## VarF:ej -2.4316943 0.6257787 107 -3.8858692 1.770611e-04
## VarG:ej -0.6663160 0.6257787 107 -1.0647790 2.893729e-01
VarCorr(modFull1)
##          Variance           StdDev   
## Loc =    pdIdent(Var - 1)            
## VarA     27.5007919         5.2441197
## VarB     27.5007919         5.2441197
## VarC     27.5007919         5.2441197
## VarD     27.5007919         5.2441197
## VarE     27.5007919         5.2441197
## VarF     27.5007919         5.2441197
## VarG     27.5007919         5.2441197
## Loc =    pdIdent(Block - 1)          
## Block1    0.4478291         0.6692003
## Block2    0.4478291         0.6692003
## Block3    0.4478291         0.6692003
## Residual 20.8781458         4.5692610

# Eberhart-Russel model
modFull2 <- lme(Yield ~ Var/ej - 1, 
                random = list(Loc = pdDiag(~ Var - 1),
                              Loc = pdIdent(~ Block - 1)), 
                data=dataFull)
summary(modFull2)$tTable
##              Value Std.Error  DF    t-value      p-value
## VarA    63.1666667 3.0507629 107 20.7052032 3.221930e-39
## VarB    66.1666667 2.7818326 107 23.7852798 1.604422e-44
## VarC    31.8333333 1.7240721 107 18.4640387 4.753742e-35
## VarD    47.1111111 2.3526521 107 20.0246824 5.564350e-38
## VarE    44.7222222 2.4054296 107 18.5921974 2.699536e-35
## VarF    34.2777778 1.9814442 107 17.2993906 8.947485e-33
## VarG    35.8888889 2.2617501 107 15.8677515 7.076551e-30
## VarA:ej  3.2249875 0.7948909 107  4.0571447 9.466174e-05
## VarB:ej  4.7936139 0.7248198 107  6.6135249 1.522848e-09
## VarC:ej  0.4771074 0.4492152 107  1.0620909 2.905857e-01
## VarD:ej  0.3653064 0.6129948 107  0.5959372 5.524757e-01
## VarE:ej  1.2369950 0.6267462 107  1.9736777 5.099652e-02
## VarF:ej -2.4316943 0.5162748 107 -4.7100774 7.473942e-06
## VarG:ej -0.6663160 0.5893098 107 -1.1306718 2.607213e-01
VarCorr(modFull2)
##          Variance           StdDev   
## Loc =    pdDiag(Var - 1)             
## VarA     48.7341240         6.9809830
## VarB     39.3227526         6.2707856
## VarC     10.7257438         3.2750181
## VarD     26.1010286         5.1089166
## VarE     27.6077467         5.2543074
## VarF     16.4479246         4.0556041
## VarG     23.5842788         4.8563648
## Loc =    pdIdent(Block - 1)          
## Block1    0.4520678         0.6723599
## Block2    0.4520678         0.6723599
## Block3    0.4520678         0.6723599
## Residual 20.8743411         4.5688446

library(emmeans)
muGE <- as.data.frame( emmeans(mod.aov, ~Var:Loc) )[,1:3]
names(muGE) <- c("Var", "Loc", "Yield")
muGE <- muGE %>% 
  group_by(Loc) %>% 
  mutate(ej = mean(Yield) - mean(muGE$Yield))

# Finlay-Wilkinson model
modFinlay <- lm(Yield ~ Var/ej - 1, data=muGE)
summary(modFinlay)
## 
## Call:
## lm(formula = Yield ~ Var/ej - 1, data = muGE)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -7.3981 -3.5314 -0.8864  3.7791 11.2045 
## 
## Coefficients:
##         Estimate Std. Error t value Pr(>|t|)    
## VarA     63.1667     2.3915  26.413  < 2e-16 ***
## VarB     66.1667     2.3915  27.668  < 2e-16 ***
## VarC     31.8333     2.3915  13.311 1.24e-13 ***
## VarD     47.1111     2.3915  19.699  < 2e-16 ***
## VarE     44.7222     2.3915  18.701  < 2e-16 ***
## VarF     34.2778     2.3915  14.333 2.02e-14 ***
## VarG     35.8889     2.3915  15.007 6.45e-15 ***
## VarA:ej   3.2250     0.6231   5.176 1.72e-05 ***
## VarB:ej   4.7936     0.6231   7.693 2.22e-08 ***
## VarC:ej   0.4771     0.6231   0.766 0.450272    
## VarD:ej   0.3653     0.6231   0.586 0.562398    
## VarE:ej   1.2370     0.6231   1.985 0.056998 .  
## VarF:ej  -2.4317     0.6231  -3.902 0.000545 ***
## VarG:ej  -0.6663     0.6231  -1.069 0.294052    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 5.858 on 28 degrees of freedom
## Multiple R-squared:  0.9905, Adjusted R-squared:  0.9857 
## F-statistic: 208.3 on 14 and 28 DF,  p-value: < 2.2e-16
sigmaf <- summary(modFinlay)$sigma^2 
sigma2 <- summary(mod.aov)$sigma^2 
sigmaf - sigma2/3 #sigma2_d
## [1] 27.43169

# Eberarth-Russel model
modEberarth <- gls(Yield ~ Var/ej - 1, 
                   weights=varIdent(form=~1|Var), data=muGE)
coefs <- summary(modEberarth)$tTable
coefs
##              Value Std.Error    t-value      p-value
## VarA    63.1666667 3.0434527 20.7549360 1.531581e-18
## VarB    66.1666667 2.7653537 23.9270177 3.508778e-20
## VarC    31.8333333 1.7165377 18.5450822 2.912238e-17
## VarD    47.1111111 2.3344802 20.1805574 3.204306e-18
## VarE    44.7222222 2.3899219 18.7128381 2.304763e-17
## VarF    34.2777778 1.9783684 17.3262868 1.685683e-16
## VarG    35.8888889 2.2589244 15.8876005 1.537133e-15
## VarA:ej  3.2249875 0.7929862  4.0668898 3.511248e-04
## VarB:ej  4.7936139 0.7205262  6.6529352 3.218756e-07
## VarC:ej  0.4771074 0.4472521  1.0667527 2.951955e-01
## VarD:ej  0.3653064 0.6082600  0.6005761 5.529531e-01
## VarE:ej  1.2369950 0.6227056  1.9864844 5.684599e-02
## VarF:ej -2.4316943 0.5154734 -4.7174004 6.004832e-05
## VarG:ej -0.6663160 0.5885736 -1.1320862 2.672006e-01
sigma <- summary(modEberarth)$sigma
sigma2fi <- (c(1, coef(modEberarth$modelStruct$varStruct, uncons = FALSE)) * sigma)^2
names(sigma2fi)[1] <- "A"
sigma2fi - sigma2/3 #sigma2_di
##        A        B        C        D        E        F        G 
## 48.69203 38.99949 10.79541 25.81519 27.38676 16.60005 23.73284
