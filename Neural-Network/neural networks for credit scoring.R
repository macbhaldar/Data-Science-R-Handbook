set.seed(1234567890)

library("neuralnet")

dataset <- read.csv("creditset.csv")
head(dataset)

##   clientid income   age   loan       LTI default10yr
## 1        1  66156 59.02 8106.5 0.1225368           0
## 2        2  34415 48.12 6564.7 0.1907516           0
## 3        3  57317 63.11 8021.0 0.1399398           0
## 4        4  42710 45.75 6103.6 0.1429105           0
## 5        5  66953 18.58 8770.1 0.1309895           1
## 6        6  24904 57.47   15.5 0.0006223           0

## extract a set to train the NN
trainset <- dataset[1:800, ]

## select the test set
testset <- dataset[801:2000, ]

## extract a set to train the NN
trainset <- dataset[1:800, ]

## select the test set
testset <- dataset[801:2000, ]

## build the neural network (NN)
creditnet <- neuralnet(default10yr ~ LTI + age, trainset, hidden = 4, lifesign = "minimal", 
                       linear.output = FALSE, threshold = 0.1)

## hidden: 4    thresh: 0.1    rep: 1/1    steps:    7266   error: 0.79202  time: 9.32 secs

## plot the NN
plot(creditnet, rep = "best")

## test the resulting output
temp_test <- subset(testset, select = c("LTI", "age"))

creditnet.results <- compute(creditnet, temp_test)

head(temp_test)

##               LTI         age
## 801 0.02306808811 25.90644520
## 802 0.13729704954 40.77430558
## 803 0.10456984914 32.47350580
## 804 0.15985046411 53.22813215
## 805 0.11161429579 46.47915325
## 806 0.11489364221 47.12736998

results <- data.frame(actual = testset$default10yr, prediction = creditnet.results$net.result)
results[100:115, ]

##     actual                                 prediction
## 900      0 0.0000000000000000000000000015964854322398
## 901      0 0.0000000000000000000000000065162871249459
## 902      0 0.0000000000164043993271687692878796349660
## 903      1 0.9999999999219191249011373656685464084148
## 904      0 0.0000000000000000013810778585990359033486
## 905      0 0.0000000000000000539636283549265018946381
## 906      0 0.0000000000000000000234592312583958126923
## 907      1 0.9581419934268182725389806364546529948711
## 908      0 0.2499229633059911748205195181071758270264
## 909      0 0.0000000000000007044361454974853363648901
## 910      0 0.0006082559674722616289282983714770125516
## 911      1 0.9999999878713862200285689141310285776854
## 912      0 0.0000000000000000000000000015562211243506
## 913      1 0.9999999993455563895849991240538656711578
## 914      0 0.0000000000000000000000000000003082538282
## 915      0 0.0000000019359618836434052080615331181690

results$prediction <- round(results$prediction)
results[100:115, ]

##     actual prediction
## 900      0          0
## 901      0          0
## 902      0          0
## 903      1          1
## 904      0          0
## 905      0          0
## 906      0          0
## 907      1          1
## 908      0          0
## 909      0          0
## 910      0          0
## 911      1          1
## 912      0          0
## 913      1          1
## 914      0          0
## 915      0          0

