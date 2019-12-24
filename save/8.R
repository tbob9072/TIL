install.packages("kernlab") 
library(kernlab)

#기본적으로 가우시안 커널을 사용한다.
m = ksvm(Species~., data = iris)
m

head(predict(m, newdata = iris))

ksvm(Species~., data = iris, kernel = "vanilladot")

library(e1071)

tune.svm(Species~, data=iris, gamma = 2^(-1:1), cost = 2^(2:4))

setwd("c://Rwork/ml")
set1 <- read.csv("set1.csv")
install.packages("SparseM")
library(MASS)
library(e1071)

density <- kde2d(set$food, set1$book, n =400)

m1 <- svm(status ~ food + book + cul + cloth + travel, type = "C-classification", data = set1)
m1

predict(m1, set1)
sum(set1$status != predict(m1, set1))

library(kernlab)
m2 <- ksvm(status ~ . , kernel = "rbfdot", data = set1)
m2
sum(as.numeric(predict(m2,set1) > 0.5) != set1$status)
