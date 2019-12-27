setwd("/Users/tbob/Rproject")
train <- read.csv("train.csv", fileEncoding = "euc-kr")
head(train)
test <- read.csv("hoho.csv", fileEncoding = "euc-kr")
head(test)
str(train)

library(dplyr)

train$성별 <- as.factor(train$성별)
train$혼인상태 <- as.factor(train$혼인상태)
train$주택형태 <- as.factor(train$주택형태)
train$종교 <- as.factor(train$종교)
train$봉사 <- as.factor(train$봉사)
train$기부 <- as.factor(train$기부)
train$정치성향 <- as.factor(train$정치성향)
train$직업 <- as.factor(train$직업)

test$성별 <- as.factor(test$성별)
test$혼인상태 <- as.factor(test$혼인상태)
test$주택형태 <- as.factor(test$주택형태)
test$종교 <- as.factor(test$종교)
test$봉사 <- as.factor(test$봉사)
test$기부 <- as.factor(test$기부)
test$정치성향 <- as.factor(test$정치성향)
test$직업 <- as.factor(test$직업)


train <- train %>% select(-c(id, 자치구, 가족신뢰도, 공공기관신뢰도, 종합신뢰도))
test <- test %>% select(-c(id, 자치구, 가족신뢰도, 공공기관신뢰도, 종합신뢰도, 신뢰도))

library(nnet)
model <- multinom(이웃신뢰도~., data = train)
# summary(model)
result <- predict(model, test)
result

confusionMatrix(result, as.factor(test$이웃신뢰도))

train_fe <- train %>% filter(성별 == 2)
mean(train_fe$이웃신뢰도)
train_fe

train_ma <- train %>% filter(성별 == 1)  
train_ma

hist(train_fe$이웃신뢰도)
hist(train_ma$이웃신뢰도)
t.test(train_fe$이웃신뢰도, train_ma$이웃신뢰도)
var.test(train_fe$이웃신뢰도, train_ma$이웃신뢰도)

t.test(train$성별, train$이웃신뢰도, paired = T)
head(train)
str(train)

install.packages("caret")
library(caret)
library(nnet)

nnet.result <- nnet(이웃신뢰도~. , train, size = 5)
nnet.pred <- predict(nnet.result, test)
table(nnet.pred, test$이웃신뢰도)

