# Targeting treatment for heart disease patients

# loading the data
heart_disease = read.csv("data/heart_disease_patients.csv")

# print the first ten rows of the data set
head(heart_disease, 10)

# check that only numeric variables
lapply(heart_disease, class)

# evidence that the data should be scaled?
summary(heart_disease)

# remove id
heart_disease = heart_disease[ , !(names(heart_disease) %in% c('id'))]

# scaling data and saving as a data frame
scaled = scale(heart_disease)

# what does data look like now?
summary(scaled)

# set the seed so that results are reproducible
seed_val = 10
set.seed(seed_val)

# select a number of clusters
k = 5

# run the k-means algorithms
first_clust = kmeans(scaled, centers = k, nstart = 1)

# how many patients are in each group
first_clust$size

# set the seed
seed_val = 38
set.seed(seed_val)

# run the k-means algorithms
k = 5
second_clust = kmeans(scaled, k, nstart=1)

# how many patients are in each group
second_clust$size

# Comparing patient clusters
# adding cluster assignments to the data
heart_disease['first_clust'] = first_clust$cluster
heart_disease['second_clust'] = second_clust$cluster

# load ggplot2
library(ggplot2)

# creating the plots of age and chol for the first clustering algorithm
plot_one = ggplot(heart_disease, aes(x=age, y=chol, color=as.factor(first_clust))) + geom_point()
plot_one 

# creating the plots of age and chol for the second clustering algorithm
plot_two = ggplot(heart_disease, aes(x=age, y=chol, color=as.factor(second_clust))) + geom_point()
plot_two

# Hierarchical clustering
# executing hierarchical clustering with complete linkage
hier_clust_1 = hclust(dist(scaled), method= 'complete')

# printing the dendrogram
plot(hier_clust_1)

# getting cluster assignments based on number of selected clusters
hc_1_assign <- cutree(hier_clust_1, 5)


# executing hierarchical clustering with complete linkage
hier_clust_2 = hclust(dist(scaled), method='single')

# printing the dendrogram
plot(hier_clust_2)

# getting cluster assignments based on number of selected clusters
hc_2_assign <- cutree(hier_clust_2,5)

# Comparing clustering results
# adding assignments of chosen hierarchical linkage
heart_disease['hc_clust'] = hc_1_assign

# remove 'sex', 'first_clust', and 'second_clust' variables
hd_simple = heart_disease[, !(names(heart_disease) %in% c('sex', 'first_clust', 'second_clust'))]

# getting mean and standard deviation summary statistics
clust_summary = do.call(data.frame, aggregate(. ~hc_clust, data = hd_simple, function(x) c(avg = mean(x), sd = sd(x))))
clust_summary

# Visualizing the cluster contents
# plotting age and chol
plot_one = ggplot(hd_simple, aes(x=age, y=chol, color=as.factor(hc_clust))) + geom_point()
plot_one 

# plotting oldpeak and trestbps
plot_two = ggplot(hd_simple, aes(oldpeak, trestbps, color=as.factor(hc_clust))) + geom_point()
plot_two
