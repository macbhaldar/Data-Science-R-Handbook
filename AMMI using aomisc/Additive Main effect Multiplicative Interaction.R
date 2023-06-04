# Additive Main effect Multiplicative Interaction

# options(width = 70)

rm(list=ls())
# library(devtools)
# install_github("OnofriAndreaPG/aomisc")
library(reshape)
library(emmeans)
library(aomisc)

fileName <- "https://www.casaonofri.it/_datasets/fabaBean.csv"
dataset <- read.csv(fileName, header=T)
dataset <- transform(dataset, Block = factor(Block),
                     Genotype = factor(Genotype),
                     Environment = factor(Environment))
head(dataset)
##      Genotype Block Environment Yield
## 1    Chiaro_A     1       bad_1  4.36
## 2    Chiaro_P     1       bad_1  2.76
## 3 Collameno_A     1       bad_1  3.01
## 4 Collameno_P     1       bad_1  2.50
## 5    Palomb_A     1       bad_1  3.85
## 6    Palomb_P     1       bad_1  2.21
#
# Two-ways table of means
GEmedie <- cast(Genotype ~ Environment, data = dataset,
                value = "Yield", fun=mean)
GEmedie
##       Genotype  bad_1  bad_2  bad_3  pap_1  pap_2  pap_3
## 1     Chiaro_A 4.1050 2.3400 4.1250 4.6325 2.4100 3.8500
## 2     Chiaro_P 2.5075 1.3325 4.2025 3.3225 1.4050 4.3175
## 3  Collameno_A 3.2500 2.1150 4.3825 3.8475 2.2325 4.0700
## 4  Collameno_P 1.9075 0.8475 3.8650 2.5200 0.9850 4.0525
## 5     Palomb_A 3.8400 2.0750 4.2050 5.0525 2.6850 4.6675
## 6     Palomb_P 2.2500 0.9725 3.2575 3.2700 0.8825 4.0125
## 7      Scuro_A 4.3700 2.1050 4.1525 4.8625 2.1275 4.2050
## 8      Scuro_P 3.0500 1.6375 3.9300 3.7200 1.7475 4.5125
## 9    Sicania_A 3.8300 1.9450 4.5050 3.9550 2.2350 4.2350
## 10   Sicania_P 3.2700 0.9900 3.7300 4.0475 0.8225 3.8950
## 11   Vesuvio_A 4.1375 2.0175 4.0275 4.5025 2.2650 4.3225
## 12   Vesuvio_P 2.1225 1.1800 3.5250 3.0950 0.9375 3.6275
#
# Marginal means for genotypes
apply(GEmedie, 1, mean)
##    Chiaro_A    Chiaro_P Collameno_A Collameno_P    Palomb_A 
##    3.577083    2.847917    3.316250    2.362917    3.754167 
##    Palomb_P     Scuro_A     Scuro_P   Sicania_A   Sicania_P 
##    2.440833    3.637083    3.099583    3.450833    2.792500 
##   Vesuvio_A   Vesuvio_P 
##    3.545417    2.414583
#
# Marginal means for environments
apply(GEmedie, 2, mean)
##    bad_1    bad_2    bad_3    pap_1    pap_2    pap_3 
## 3.220000 1.629792 3.992292 3.902292 1.727917 4.147292
#
# Overall mean
mean(as.matrix(GEmedie))
## [1] 3.103264

4.1050 - 3.577 - 3.22 + 3.103
## [1] 0.411

GE <- as.data.frame(t(scale( t(scale(GEmedie, center=T,
                                     scale=F)), center=T, scale=F)))
print(round(GE, 3))
##              bad_1  bad_2  bad_3  pap_1  pap_2  pap_3
## Chiaro_A     0.411  0.236 -0.341  0.256  0.208 -0.771
## Chiaro_P    -0.457 -0.042  0.466 -0.324 -0.068  0.426
## Collameno_A -0.183  0.272  0.177 -0.268  0.292 -0.290
## Collameno_P -0.572 -0.042  0.613 -0.642 -0.003  0.646
## Palomb_A    -0.031 -0.206 -0.438  0.499  0.306 -0.131
## Palomb_P    -0.308  0.005 -0.072  0.030 -0.183  0.528
## Scuro_A      0.616 -0.059 -0.374  0.426 -0.134 -0.476
## Scuro_P     -0.166  0.011 -0.059 -0.179  0.023  0.369
## Sicania_A    0.262 -0.032  0.165 -0.295  0.160 -0.260
## Sicania_P    0.361 -0.329  0.048  0.456 -0.595  0.058
## Vesuvio_A    0.475 -0.054 -0.407  0.158  0.095 -0.267
## Vesuvio_P   -0.409  0.239  0.221 -0.119 -0.102  0.169

mean(unlist(GE))
## [1] 6.914424e-18
sum(GE^2)
## [1] 7.742996
mod <- lm(Yield ~ Environment/Block + Genotype*Environment, data = dataset)
anova(mod)
## Analysis of Variance Table
## 
## Response: Yield
##                       Df Sum Sq Mean Sq  F value    Pr(>F)    
## Environment            5 316.57  63.313 580.9181 < 2.2e-16 ***
## Genotype              11  70.03   6.366  58.4111 < 2.2e-16 ***
## Environment:Block     18   6.76   0.375   3.4450 8.724e-06 ***
## Environment:Genotype  55  30.97   0.563   5.1669 < 2.2e-16 ***
## Residuals            198  21.58   0.109                       
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
30.97/4
## [1] 7.7425

# Decomposing the GE matrix
U <- svd(GE)$u
V <- svd(GE)$v
D <- diag(svd(GE)$d)
Sg <- U %*% sqrt(D)
Se <- V %*% sqrt(D)
row.names(Sg) <- levels(dataset$Genotype)
row.names(Se) <- levels(dataset$Environment)
colnames(Sg) <- colnames(Se) <- paste("PC", 1:6, sep ="")
round(Sg %*% t(Se), 3)
##              bad_1  bad_2  bad_3  pap_1  pap_2  pap_3
## Chiaro_A     0.411  0.236 -0.341  0.256  0.208 -0.771
## Chiaro_P    -0.457 -0.042  0.466 -0.324 -0.068  0.426
## Collameno_A -0.183  0.272  0.177 -0.268  0.292 -0.290
## Collameno_P -0.572 -0.042  0.613 -0.642 -0.003  0.646
## Palomb_A    -0.031 -0.206 -0.438  0.499  0.306 -0.131
## Palomb_P    -0.308  0.005 -0.072  0.030 -0.183  0.528
## Scuro_A      0.616 -0.059 -0.374  0.426 -0.134 -0.476
## Scuro_P     -0.166  0.011 -0.059 -0.179  0.023  0.369
## Sicania_A    0.262 -0.032  0.165 -0.295  0.160 -0.260
## Sicania_P    0.361 -0.329  0.048  0.456 -0.595  0.058
## Vesuvio_A    0.475 -0.054 -0.407  0.158  0.095 -0.267
## Vesuvio_P   -0.409  0.239  0.221 -0.119 -0.102  0.169

round(Sg, 3)
##                PC1    PC2    PC3    PC4    PC5 PC6
## Chiaro_A    -0.607 -0.384  0.001  0.208 -0.063   0
## Chiaro_P     0.552  0.027 -0.081  0.045  0.164   0
## Collameno_A  0.084 -0.542 -0.006  0.176  0.057   0
## Collameno_P  0.807 -0.066 -0.132 -0.172  0.079   0
## Palomb_A    -0.321  0.110  0.591 -0.083  0.389   0
## Palomb_P     0.281  0.346  0.282  0.042 -0.253   0
## Scuro_A     -0.626  0.139 -0.163  0.017 -0.080   0
## Scuro_P      0.230  0.077  0.182 -0.207 -0.242   0
## Sicania_A   -0.063 -0.324 -0.355 -0.280  0.090   0
## Sicania_P   -0.214  0.683 -0.402  0.148  0.151   0
## Vesuvio_A   -0.438 -0.008  0.020 -0.300 -0.177   0
## Vesuvio_P    0.316 -0.058  0.063  0.405 -0.114   0
round(Se, 3)
##          PC1    PC2    PC3    PC4    PC5 PC6
## bad_1 -0.831  0.095 -0.467 -0.317 -0.151   0
## bad_2  0.044 -0.418  0.070  0.371 -0.403   0
## bad_3  0.670 -0.130 -0.525  0.171  0.298   0
## pap_1 -0.661  0.513  0.289  0.314  0.221   0
## pap_2 -0.069 -0.627  0.420 -0.294  0.208   0
## pap_3  0.846  0.567  0.213 -0.244 -0.173   0

-0.607 * -0.831 +
  -0.384 *  0.095 +
  0.001 * -0.467 +
  0.208 * -0.317 + 
  -0.063 * -0.151 +
  0 * 0
## [1] 0.411047

# Reducing the rank
PC <- 2
Sg2 <- Sg[,1:PC]
Se2 <- Se[,1:PC]
GE2 <- Sg2 %*% t(Se2)
print ( round(GE2, 3) )
##              bad_1  bad_2  bad_3  pap_1  pap_2  pap_3
## Chiaro_A     0.468  0.134 -0.357  0.205  0.282 -0.732
## Chiaro_P    -0.456  0.013  0.367 -0.351 -0.055  0.482
## Collameno_A -0.122  0.230  0.127 -0.334  0.334 -0.236
## Collameno_P -0.676  0.063  0.549 -0.567 -0.014  0.645
## Palomb_A     0.277 -0.060 -0.230  0.269 -0.047 -0.209
## Palomb_P    -0.201 -0.132  0.144 -0.009 -0.236  0.434
## Scuro_A      0.534 -0.086 -0.438  0.486 -0.044 -0.451
## Scuro_P     -0.184 -0.022  0.144 -0.113 -0.064  0.238
## Sicania_A    0.022  0.133  0.000 -0.124  0.207 -0.237
## Sicania_P    0.243 -0.295 -0.232  0.492 -0.414  0.206
## Vesuvio_A    0.363 -0.016 -0.293  0.286  0.035 -0.375
## Vesuvio_P   -0.268  0.038  0.219 -0.239  0.015  0.234

sum(GE2^2)
## [1] 6.678985

-0.607 * -0.831 + -0.384 * 0.095
## [1] 0.467937

0.41118056 -0.607 * -0.831 + -0.384 * 0.095
## [1] 0.8791176

biplot(Sg[,1:2], Se[,1:2], xlim = c(-1, 1), ylim = c(-1, 1),
       xlab = "PC 1", ylab = "PC 2")
abline(h = 0, lty = 2)
abline(v = 0, lty = 2)

PC <- 1
Sg2 <- Sg[,1:PC]
Se2 <- Se[,1:PC]
GE2 <- Sg2 %*% t(Se2)
sum(GE2^2)
## [1] 5.290174

6.678985 - 5.290174
## [1] 1.388811

RMSE <- summary(mod)$sigma^2 / 4
dfr <- mod$df.residual
ge.lsm <- emmeans(mod, ~Genotype:Environment)
ge.lsm <- data.frame(ge.lsm)[,1:3]

AMMIobj <- AMMImeans(yield = ge.lsm$emmean, 
                     genotype = ge.lsm$Genotype, 
                     environment = ge.lsm$Environment, 
                     MSE = RMSE, dfr = dfr)
#
AMMIobj$genotype_scores
##                     PC1          PC2
## Chiaro_A    -0.60710888 -0.383732821
## Chiaro_P     0.55192742  0.026531045
## Collameno_A  0.08444877 -0.542185666
## Collameno_P  0.80677055 -0.065752971
## Palomb_A    -0.32130513  0.110117240
## Palomb_P     0.28104959  0.345909298
## Scuro_A     -0.62638795  0.139185954
## Scuro_P      0.22961347  0.076555540
## Sicania_A   -0.06286803 -0.323857285
## Sicania_P   -0.21433211  0.683296898
## Vesuvio_A   -0.43786742 -0.007914342
## Vesuvio_P    0.31605973 -0.058152890
#
AMMIobj$environment_scores
##               PC1         PC2
## bad_1 -0.83078550  0.09477362
## bad_2  0.04401963 -0.41801637
## bad_3  0.67043214 -0.12977423
## pap_1 -0.66137357  0.51268429
## pap_2 -0.06863235 -0.62703224
## pap_3  0.84633965  0.56736492
#
round(AMMIobj$summary, 4)
##   PC Singular_value  PC_SS Perc_of_Total_SS cum_perc
## 1  1         2.3000 5.2902          68.3220  68.3220
## 2  2         1.1785 1.3888          17.9364  86.2584
## 3  3         0.8035 0.6456           8.3375  94.5959
## 4  4         0.5119 0.2621           3.3846  97.9806
## 5  5         0.3954 0.1564           2.0194 100.0000
## 6  6         0.0000 0.0000           0.0000 100.0000
#
round(AMMIobj$anova, 4)
##   PC     SS DF     MS       F P.value
## 1  1 5.2902 15 0.3527 12.9437  0.0000
## 2  2 1.3888 13 0.1068  3.9208  0.0000
## 3  3 0.6456 11 0.0587  2.1539  0.0184
## 4  4 0.2621  9 0.0291  1.0687  0.3876
## 5  5 0.1564  7 0.0223  0.8198  0.5718
## 6  6 0.0000  5 0.0000  0.0000  1.0000

AMMIobj2 <- AMMI(yield = dataset$Yield, 
                 genotype = dataset$Genotype,
                 environment = dataset$Environment, 
                 block = dataset$Block)

