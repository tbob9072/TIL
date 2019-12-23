install.packages("caret")
library(caret)

#다중회귀분석 사용

#특정데이터가 test쪽으로 쏠리게 되면 패턴을 파악하는게 어렵기 때문에 y값을 기준으로 비율값을 나누기
idx <- createDataPartition(iris$Species, p = 0.7, list = F)
View(idx)
iris_train <- iris[idx,]
iris_test <- iris[-idx,]

table(iris_train$Species)
table(iris_test$Species)

library(nnet)
model <- multinom(Species~., data = iris_train)
# summary(model)
result <- predict(model, iris_test)
result

confusionMatrix(result, iris_test$Species)




# 의사결정나무 사용
idx <- createDataPartition(iris$Species, p = 0.7, list = F)
iris_train[idx,]
iris_test[-idx,]

library(rpart)

model <- rpart(Species~., data = iris_train)
result <- predict(model, iris_test, type = "class")
head(result)
confusionMatrix(result, iris_test$Species)



# randomforest 사용
library(rpart)
library(randomForest)
install.packages("e1071")
library(e1071)

idx <- createDataPartition(iris$Species, p = 0.7, list = F)
iris_train[idx,]
iris_test[-idx,]

rdf <- randomForest(Species~., data = iris_train, importance = T)
rdf.pred <- predict(rdf, newdata = iris_test, type = "response")
confusionMatrix(rdf.pred, iris_test$Species, positive = "versicolor")



# KNN 사용
library(class)

idx <- createDataPartition(iris$Species, p = 0.7, list = F)
iris_train[idx,]
iris_test[-idx,]
set.seed(1234)

model <- knn(train = iris_train[,-5],
             test = iris_test[,-5],
             cl = iris_train$Species,
             k = 3)
summary(model)
confusionMatrix(model,iris_test$Species)
