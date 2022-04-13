# data set "warpbreaks" which describes the effect of wool type (A or B) 
# and tension (low, medium or high) on the number of warp breaks per loom
input <- warpbreaks
print(head(input))

# Create Regression Model
output <-glm(formula = breaks ~ wool+tension, data = warpbreaks,
             family = poisson)
print(summary(output))

# p-value in the last column to be less than 0.05 
# to consider an impact of the predictor variable on the response variable. 
# As seen the wooltype B having tension type M and H have impact on the count of breaks.