data("iris")
library(caret)
idx <- createDataPartition(iris$Species, p = 0.7, list = F)

iris_train <- iris[idx,]
iris_test <- iris[-idx,]

table(iris_train$Species)
table(iris_test$Species)

library(e1071)

naive.result <- naiveBayes(iris_train, iris_train$Species, laplace = 1)

naive.pred <- predict(naive.result, iris_test, type = "class")
table(naive.pred, iris_test$Species)


#연습문제 1
setwd("c://Rwork/ml")
movie <- read.csv("movie.csv", header = T)
nm <- naiveBayes(movie[1:5], movie$장르, laplace = 0)
head(movie)

result <- predict(nm, movie[1:5])
sum(movie$장르 != result)
result

#연습문제2
mail <- read.csv("spam.csv", header = T) 
mail[is.na(mail)] <- 0
nm2 <- naiveBayes(mail[2:13], mail$메일종류, laplace = 0)
head(mail)

result2 <- predict(nm2, mail[2:13])
sum(mail$메일종류 != result2)
result2





# 인공신경망 실습예제
data("iris")
library(caret)
idx <- createDataPartition(iris$Species, p = 0.7, list = F)

iris_train <- iris[idx,]
iris_test <- iris[-idx,]
table(iris_train$Species)

library(nnet)

iris_train_scale <- as.data.frame(sapply(iris_train[,-5], scale))
iris_test_scale <- as.data.frame(sapply(iris_test[,-5], scale))
iris_train_scale$Species <- iris_train$Species
iris_test_scale$Species <- iris_test$Species

nnet.result <- nnet(Species~. , iris_train_scale, size = 3)
nnet.pred <- predict(nnet.result, iris_test_scale, type = "class")
table(nnet.pred, iris_test$Species)


# 연습문제 1-2
prob <- read.csv("problem.csv", header = T, stringsAsFactors = F)
head(prob)

#정규화 방법 1
for(i in 1:30) {
  prob[i] <- prob[i] * (1/5)
}
head(prob)
View(prob)

#정규화 방법 2
normalize <- function(x) {
  return((x-min(x)) / diff(range(x)))
}

#정규화 방법 3
sigmoid <- function(x) {
  return(1 / (1 + exp(-x)))
}

prob$accident2 <- with(prob, ifelse(accident == "suicide" | accident == "violence", 1, 0))
head(prob)

library(nnet)
prob <- prob[-31]
m1 <- nnet(accident2 ~ . , data = prob, size = 10)
r1 <- predict(m1, prob)
head(r1)

cbind(prob$accident2, r1 > 0.5)
sum(as.numeric(r1 > 0.5) != prob$accident2)
