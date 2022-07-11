# Association Rules

# Loading Libraries
library(tidyr)
library(dplyr)
library(ggplot2)
library(stringr)
library(lubridate)
library(anytime)
library(plyr)
library(arules)
library(BayesLCA)
library(arulesViz)
library(reshape2)
library(sjmisc)
library(cowplot)
library(RColorBrewer)

# Import Data
groceries <- read.table("Groceries.csv", head=FALSE, stringsAsFactors = FALSE, sep = ",", strip.white = TRUE, blank.lines.skip = TRUE,
                        col.names = paste0("V",seq_len(34)), fill = TRUE, na.strings="NA")


# EXPLORATORY DATA ANALYSIS

class(groceries) #data.frame

# Explore the first 10 rows of the file
head(groceries, 10)

# Check if there is any NA values
sapply(groceries, function(x) sum(is.na(x)))
# Doesn't seem to be any NA

# Check again with different function the missing values
groceries[!complete.cases(groceries), ]
# no missing values

# Check the structure of the data set
str(groceries)

# Check the number of rows and columns
dim(groceries) 
# confirmed 1,499 rows and 34 columns


# DATA CLEANING

# A new data frame is created called groceries_clean
# Split data appearing in first column V1. Create two new variables date and product_1

groceries_clean <- groceries %>%
  separate(col = V1,
           into = c("date","product_1"),
           sep = "(?<=[0-9])(?=[A-Za-z])"
           )

# Now, as the old V1 was dropped product_1 can be renamed to V1, as fist column of products
groceries_clean <- groceries_clean %>% dplyr::rename("V1" = "product_1")

# add transaction ID for each row
groceries_clean$transactionID <- seq.int(nrow(groceries_clean))

str(groceries_clean)


# PROCESSING DATA FRAME TO BE IMPORTED BY READ.TRANSACTIONS FUNCTION AS SINGLE FORMAT

# Remove date from data frame
groceries_items <- select(groceries_clean,-c("date"))

# Check structure
str(groceries_items)

# Move all the items into one column
groceries_items_single <- melt(groceries_items, id = "transactionID")

# Check that the formula has worked, checking items for transaction 1
subset(groceries_items_single, transactionID == 1)

# Remove variable
groceries_items_single <- select(groceries_items_single,-c("variable"))

# Check how many different items there are
count(unique(groceries_items_single$value)) #One of the elements is empty

# Cleaning empty values 
groceries_items_single <- groceries_items_single[-which(groceries_items_single$value == ""), ]

# Check if there is any NA values
sapply(groceries_items_single, function(x) sum(is.na(x))) #not NA found

# check again for NA values in different way
sum(is.na(groceries_items_single))

# Check again with different function the missing values
groceries_items_single[!complete.cases(groceries_items_single), ]

# Check how many different items there are
count(unique(groceries_items_single$value)) 
# Now there are no empty elemnets and is ready to export

# Check Structure
str(groceries_items_single)
# Export cleaned data frame
write.csv(groceries_items_single, "groceries_items_single.csv", row.names = FALSE)


# IMPORT CSV AS TRANSACTION IN SINGLE FORMAT
# As some items can be bought twice and can then appear twice in the transaction rm.duplicates equals true is used to remove them
groceries_transactions <- read.transactions(file = "groceries_items_single.csv",
                                            format = "single",
                                            sep = ",",
                                            header = TRUE,
                                            rm.duplicates = TRUE,
                                            cols = c("transactionID","value"))

# Checking the class of the new data imported with read.transactions
class(groceries_transactions)

# Checking the structure of the new transaction data file
str(groceries_transactions)


# EXPLORATORY ANALYSIS OF TRANSACTIONS

# Checking the summary of the transactions matrix
summary(groceries_transactions)

# Return all the rows with the items for each of them
inspect(groceries_transactions)

# Return the number of rows
length(groceries_transactions)

# Return the number of rows and items (columns)
items(groceries_transactions)


# Frequency of the items in absolute terms
freq_abs <- itemFrequency(groceries_transactions, type = "absolute")

# Ordering
freq_abs <- freq_abs %>% sort(decreasing = TRUE)

# Visualizing them
freq_abs

# Creating Plot
itemFrequencyPlot(groceries_transactions,type="absolute",
                  main="Absolute Item Frequency", ylab = "Absolute Item Frequency", topN = 38)



# Frequency of the items in relative terms
freq_rel <- itemFrequency(groceries_transactions, type = "relative")

# Ordering
freq_rel <- freq_rel %>% sort(decreasing = TRUE)

# Visualizing them
freq_rel # vegetables appear in 72.64% of the item sets

# Creating Plot
itemFrequencyPlot(groceries_transactions,type="relative",
                  main="Relative Item Frequency", ylab = "Relative Item Frequency", topN = 38)



# Number of items in each of the transactions
size_transactions <- data.frame(size = size(groceries_transactions))

# show the first transactions
head(size_transactions)

# Summary of size of transactions
summary(size_transactions)
# the mean and the median are very similar which indicate that are normally distributed
# the min number of items within a transaction are 4 and the max 27, as seen already in the summary

# distribution of the size of the transactions
density_transactions <- ggplot(size_transactions, aes(x = size)) +
  geom_density(fill = "grey", alpha = 0.2) +
  labs(x = "Number of Items per Transaction", y = "Density") +
  theme_bw()

# Distribution
hist_transactions <- ggplot(size_transactions, aes(x = size)) +
  geom_histogram(fill = "grey", alpha = 0.5) +
  labs(x = "Number of Items per Transaction", y = "Number of Transactions") +
  theme_bw()

# Adding both plots together
plot_grid(density_transactions, hist_transactions, labels = "AUTO")

# Visualizing 100 transactions
image(sample(groceries_transactions,100)) 
# doesn't seem to be any item repeated in all of them




# APRIORI ALGORITHM - CHECKING the item sets

# Using apriori algorithm to check the item sets that has a support of 0.01, a confidence of 0.8 and which contain at least 2 items
groceries_apriori_items <- apriori(groceries_transactions,parameter=list(support=0.01,confidence=0.8,minlen=2, target = "frequent item sets"))

# Ordering the items by support
groceries_apriori_items <- sort(groceries_apriori_items,by="support", decreasinfg = TRUE)

# Checking the summary of the item sets generated with those interest measure
summary(groceries_apriori_items)


# Inspecting only the head of the item sets
inspect(head(groceries_apriori_items, 10))
# The max support seems to be 0.32, for itemset with two items
# As expected all the combinations contain vegetables as appears in 72.64% of the transactions

# Checking again but without vegetables
groceries_apriori_items_non_veg <- apriori(groceries_transactions,
                                           parameter=list(support=0.01,confidence=0.8,minlen=2, target = "frequent item sets"),
                                           appearance = list(none = "vegetables"))

# Ordering the item sets by support
groceries_apriori_items_non_veg <- sort(groceries_apriori_items_non_veg,by="support", decreasing = TRUE)

# Inspecting only the head of the item sets
inspect(head(groceries_apriori_items_non_veg, 10)) 
# now the max support is 0.18. In general the support seems very low

# Checking again but wihout vegetables and increasing the min of items in the item set to 3
groceries_apriori_items_non_veg_3 <- apriori(groceries_transactions,
                                             parameter=list(support=0.01,confidence=0.8,minlen=2, target = "frequent item sets"),
                                             appearance = list(none = "vegetables"))

# Ordering the item sets by support
groceries_apriori_items_non_veg_3 <- sort(groceries_apriori_items_non_veg_3,by="support", decreasing = TRUE)

# Checking the summary of the item sets generated with those interest measure
summary(groceries_apriori_items_non_veg_3) # there are 619,044 item sets that acomplish those requirements, most of them contain 5 items

# Inspecting only the head of the item sets
inspect(head(groceries_apriori_items_non_veg_3, 10)) 
# now the max support is 0.09, very very low
# This is the combination that will be explored when creating the rules


# APRIORI ALGORITHM - CREATING RULES
# Creating rules with latest measures
groceries_apriori_rules <- apriori(groceries_transactions,
                                   parameter=list(support=0.01,confidence=0.8,minlen=3, target = "rules"),
                                   appearance = list(none = "vegetables"))
# there are 9,660 rules with those interest measures

# Checking the summary
summary(groceries_apriori_rules) # most of the rules contain 6 items



# Checking again but increasing support to 0.02
groceries_apriori_rules_1 <- apriori(groceries_transactions,
                                     parameter=list(support=0.02,confidence=0.8,minlen=3, target = "rules"),
                                     appearance = list(none = "vegetables"))
# there are 9,660 rules with those interest measures

# Checking the summary
summary(groceries_apriori_rules_1)  # now there are only 14 rules left

# Checking the rules
inspect(groceries_apriori_rules_1)

# Checking the length
length(groceries_apriori_rules_1)

# Checking Conviction
cbind(as(groceries_apriori_rules_1, "data.frame"), conviction=interestMeasure(groceries_apriori_rules_1, "conviction", groceries_transactions))

# Check other diferent metrics
interestMeasure(groceries_apriori_rules_1, c("leverage", "collectiveStrength"), 
                transactions = groceries_transactions)

# ploting all the selected rules by confidence and support
plot(groceries_apriori_rules_1, jitter = 0)

# ploting all the selected rules by support and lift
plot(groceries_apriori_rules_1, measure=c("support", "lift"), shading="confidence")


# Interactive plot
plotly_arules(groceries_apriori_rules_1)

# other way of representing the rules, size is the support and color the lift
# incoming lines are antecedents (LHS)
plot(groceries_apriori_rules_1, method = "graph", main = "Graph for 14 rules - Interaction between Items")

# widthh represent support and intensity of the color confidence
plot(groceries_apriori_rules_1, method = "paracoord")

# grouped matrix
plot(sort(groceries_apriori_rules_1, by="lift"), method="grouped", 
     main = "Grouped Matrix for the 14 rules")

# interactive  graph
plot(groceries_apriori_rules_1, method="graph", measure = "support", engine="htmlwidget",
     shading = "lift", control = list(verbose = TRUE))
# antecdedent and consequent, maybe needs more items
plot(groceries_apriori_rules_1, method="matrix", measure="support")

# subseting only the rules withh more than 2.2 lift
rules_lift_2_2 <- subset(groceries_apriori_rules_1, subset = lift > 2.2)

# inspecting the rules
inspect(rules_lift_2_2)

# savig association rules with higher lift
write(rules_lift_2_2, file = "rules_lift_2_2.csv", sep = ",", quote = TRUE, row.names = FALSE)

# graph fpr one rule, double decker plots
# areas is the support ,and high is the confidence
# selecting rule 12
rule_1 <- rules_lift_2_2[1,]

# Ploting rule 12
plot(rule_1, method = "doubledecker", data = groceries_transactions, main = "Doubledecker for Rule 1")

# selecting rule 13
rule_2 <- rules_lift_2_2[2,]

# Ploting rule 13
plot(rule_2, method = "doubledecker", data = groceries_transactions, main = "Doubledecker for Rule 2")



# APRIORI ALGORITHM - CREATING RULES - BEEF- RULE 1 FROM LATEST SUBSET

# subset rules from groceries_apriori_rules_1 (support=0.02,confidence=0.8,minlen=3, non-vegetables) which contain spaghetti sauce
rules_spaghetti_sauce <- arules::subset(groceries_apriori_rules_1, 
                                        subset = items %ain% c("spaghetti sauce"))

# inspect the rules
inspect(rules_spaghetti_sauce)

# subset rules from groceries_apriori_rules_1 (support=0.02,confidence=0.8,minlen=3, non-vegetables) which contain beef
rules_beef <- arules::subset(groceries_apriori_rules_1, 
                             subset = items %ain% c("beef"))

# inspect the rules
inspect(rules_beef)

# subset rules from groceries_apriori_rules_1 (support=0.02,confidence=0.8,minlen=3, non-vegetables) which contain sugar
rules_sugar <- arules::subset(groceries_apriori_rules_1, 
                              subset = items %ain% c("sugar"))

# inspect the rules
inspect(rules_sugar)

# subset rules from groceries_apriori_rules_1 (support=0.02,confidence=0.8,minlen=3, non-vegetables) which contain bagels
rules_bagels <- arules::subset(groceries_apriori_rules_1, 
                               subset = items %ain% c("bagels"))

# inspect the rules
inspect(rules_bagels)

# subset rules from groceries_apriori_rules_1 (support=0.02,confidence=0.8,minlen=3, non-vegetables) which contain toilet paper
rules_toilet_paper <- arules::subset(groceries_apriori_rules_1, 
                                     subset = items %ain% c("toilet paper" ))

# inspect the rules
inspect(rules_toilet_paper)

# subset rules from groceries_apriori_rules_1 (support=0.02,confidence=0.8,minlen=3, non-vegetables) which contain poultry
rules_poultry <- arules::subset(groceries_apriori_rules_1, 
                                subset = items %ain% c("poultry" ))

# inspect the rules
inspect(rules_poultry)


# APRIORI ALGORITHM - CREATING RULES - BEEF

# Rules for users that bouth other items and then beef
rules_beef_all_after <- apriori(groceries_transactions, parameter = list(supp = 0.02, conf = 0.8,minlen=2),
                                appearance = list(default = "lhs", rhs = "beef"))

# Inspecting the selected rules
inspect(rules_beef_all_after)


# PROCESSING DATA FRAME TO BE IMPORTED BY READ.TRANSACTIONS FUNCTION IN BASKET FORMAT
# A new data frame is created called groceries_items_basket
# Drop date and transactionID
groceries_items_basket <- select(groceries_clean,-c("date","transactionID"))

# Check again structure
str(groceries_items_basket)

# Check column names
colnames(groceries_items_basket)

# Export clean and with just items data frame into a csv file
write.csv(groceries_items_basket,"groceries_items_basket.csv", row.names = FALSE)


# IMPORT CSV AS TRANSACTION IN BASKET FORMAT

# Import csv file again as transactions
# As some items can be bought twice and can then appear twice in the transaction rm.duplicates equals true is used to remove them
# The format has been set to basket as there is one transaction per row with all the transactions
groceries_transactions_basket <- read.transactions(file = "groceries_items_basket.csv",
                                                   format = "basket",
                                                   sep = ",",
                                                   header = TRUE,
                                                   rm.duplicates = TRUE)

# Checking the class of the new data imported with read.transactions
class(groceries_transactions_basket)

# Checking the structure of the new transaction data file
str(groceries_transactions_basket) 

# Checking the summary of the transactions matrix
summary(groceries_transactions_basket)

# Return all the rows with the items for each of them
inspect(groceries_transactions_basket)

# Return the number of rows
length(groceries_transactions_basket)

# Return the number of rows and items (columns)
items(groceries_transactions_basket)

# The result is exactly the same as when using single format
# The only difference is that the transactionIDs are missing
