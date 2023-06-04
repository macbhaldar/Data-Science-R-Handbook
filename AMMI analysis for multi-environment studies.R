# options(width = 70)

rm(list=ls())

library(devtools)
install_github("OnofriAndreaPG/aomisc")

library(reshape)
library(emmeans)
library(aomisc)

fileName <- "https://www.casaonofri.it/_datasets/fabaBean.csv"
dataset <- read.csv(fileName, header=T)
dataset <- transform(dataset, Block = factor(Block),
                     Genotype = factor(Genotype),
                     Environment = factor(Environment))
head(dataset)

# Two-ways table of means
GEmedie <- cast(Genotype ~ Environment, data = dataset,
                value = "Yield", fun=mean)
GEmedie

# Marginal means for genotypes
apply(GEmedie, 1, mean)

# Marginal means for environments
apply(GEmedie, 2, mean)

# Overall mean
mean(as.matrix(GEmedie))
## [1] 3.103264

4.1050 - 3.577 - 3.22 + 3.103
## [1] 0.411

GE <- as.data.frame(t(scale( t(scale(GEmedie, center=T,
                                     scale=F)), center=T, scale=F)))
print(round(GE, 3))

mean(unlist(GE))
## [1] 6.914424e-18
sum(GE^2)
## [1] 7.742996
mod <- lm(Yield ~ Environment/Block + Genotype*Environment, data = dataset)
anova(mod)

## Analysis of Variance Table
30.97/4
## [1] 7.7425

U <- svd(GE)$u
V <- svd(GE)$v
D <- diag(svd(GE)$d)
Sg <- U %*% sqrt(D)
Se <- V %*% sqrt(D)
row.names(Sg) <- levels(dataset$Genotype)
row.names(Se) <- levels(dataset$Environment)
colnames(Sg) <- colnames(Se) <- paste("PC", 1:6, sep ="")
round(Sg %*% t(Se), 3)

round(Sg, 3)

round(Se, 3)

-0.607 * -0.831 +
  -0.384 *  0.095 +
  0.001 * -0.467 +
  0.208 * -0.317 + 
  -0.063 * -0.151 +
  0 * 0
## [1] 0.411047

PC <- 2
Sg2 <- Sg[,1:PC]
Se2 <- Se[,1:PC]
GE2 <- Sg2 %*% t(Se2)
print ( round(GE2, 3) )

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

AMMIobj <- AMMI(yield = ge.lsm$emmean, 
                genotype = ge.lsm$Genotype, 
                environment = ge.lsm$Environment, 
                MSE = RMSE, dfr = dfr)
#
AMMIobj$genotype_scores

#
AMMIobj$environment_scores

#
AMMIobj$mult_Interaction


biplot(AMMIobj, xlab = "Yield")
biplot(AMMIobj, biplot = 2)
