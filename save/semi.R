setwd("/Users/tbob/Rproject")
train <- read.csv("train.csv", fileEncoding = "euc-kr")
head(train)
test <- read.csv("hoho.csv", fileEncoding = "euc-kr")
head(test)
str(train)
library(caret)
library(dplyr)
View(train)
colSums(is.na(train))
str(train)


train$성별 <- as.factor(train$성별)
train$혼인상태 <- as.factor(train$혼인상태)
train$주택형태 <- as.factor(train$주택형태)
train$종교 <- as.factor(train$종교)
train$봉사 <- as.factor(train$봉사)
train$기부 <- as.factor(train$기부)
train$정치성향 <- as.factor(train$정치성향)
train$직업 <- as.factor(train$직업)
train$이웃신뢰도 <- as.factor(train$이웃신뢰도)
train$가족신뢰도 <- as.factor(train$가족신뢰도)

test$성별 <- as.factor(test$성별)
test$혼인상태 <- as.factor(test$혼인상태)
test$주택형태 <- as.factor(test$주택형태)
test$종교 <- as.factor(test$종교)
test$봉사 <- as.factor(test$봉사)
test$기부 <- as.factor(test$기부)
test$정치성향 <- as.factor(test$정치성향)
test$직업 <- as.factor(test$직업)
test$이웃신뢰도 <- as.factor(test$이웃신뢰도)
test$가족신뢰도 <- as.factor(test$가족신뢰도)


train <- train %>% select(-c(id, 자치구, 가족신뢰도, 공공기관신뢰도, 종합신뢰도))
test <- test %>% select(-c(id, 자치구, 가족신뢰도, 공공기관신뢰도, 종합신뢰도, 신뢰도))

# 다중회귀분석 머신러닝
library(nnet)
model <- multinom(가족신뢰도~., data = train)
# summary(model)
result <- predict(model, test)
result

confusionMatrix(result, test$가족신뢰도)

# 의사결정트리 머신러닝
library(rpart)
install.packages("party")
library(party)

model <- rpart(이웃신뢰도~., data = train)
model <- ctree(이웃신뢰도~., data = train)
result <- predict(model, test, type = "class")
head(result)
confusionMatrix(result, test$이웃신뢰도)
plot(model)



#랜덤포레스트
install.packages("randomForest")
library(randomForest)
rdf <- randomForest(이웃신뢰도~., data = train, importance = T, prOximity=TRUE, na.action=na.roughfix)
rdf.pred <- predict(rdf, newdata = test, type = "response")
confusionMatrix(rdf.pred, iris_test$Species, positive = "versicolor")

#knn
library(class)
model <- knn(train = train[,-26],
             test = test[,-26],
             cl = train$이웃신뢰도,
             k = 3)
summary(model)
confusionMatrix(model,iris_test$Species)



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

nnet.result <- nnet(이웃신뢰도~. , train, size = 3)
nnet.pred <- predict(nnet.result, test, type = "class")
table(nnet.pred, test$이웃신뢰도)

length(nnet.pred)
length(test$이웃신뢰도)

confusionMatrix(factor(nnet.pred, levels = c(1, 2, 3, 4, 5)), test$이웃신뢰도)


#PCA 분석
result<-prcomp(na.omit(train),scale = T)
result
summary(result)
biplot(result)
screeplot(result,npcs=4,type="lines",main="Score")

#교차분석
install.packages("gmodels")
library(gmodels)
CrossTable(train$성별, train$이웃신뢰도, expected = T, chisq = T) # low
CrossTable(train$연령, train$이웃신뢰도, expected = T) # low
CrossTable(train$학력, train$이웃신뢰도, expected = T) # low
CrossTable(train$소득, train$이웃신뢰도, expected = T) # low
CrossTable(train$혼인상태, train$이웃신뢰도, expected = T) # low
CrossTable(train$주택형태, train$이웃신뢰도, expected = T) # low
CrossTable(train$종교, train$이웃신뢰도, expected = T) # low
CrossTable(train$서울고향, train$이웃신뢰도, expected = T) # low
CrossTable(train$행복_건강, train$이웃신뢰도, expected = T) # low
CrossTable(train$행복_재정, train$이웃신뢰도, expected = T) # low
CrossTable(train$행복_친구, train$이웃신뢰도, expected = T) # low
CrossTable(train$행복_가정, train$이웃신뢰도, expected = T) # low
CrossTable(train$행복_사회, train$이웃신뢰도, expected = T) # low
CrossTable(train$봉사, train$이웃신뢰도, expected = T) # low
CrossTable(train$기부, train$이웃신뢰도, expected = T) # low
CrossTable(train$사회적지위, train$이웃신뢰도, expected = T) # low
CrossTable(train$약자_장애, train$이웃신뢰도, expected = T) # low
CrossTable(train$약자_제도, train$이웃신뢰도, expected = T) # low
CrossTable(train$약자_노인, train$이웃신뢰도, expected = T) # low
CrossTable(train$약자_여성, train$이웃신뢰도, expected = T) # low
CrossTable(train$외국인_친구, train$이웃신뢰도, expected = T) # low
CrossTable(train$외국인_이웃, train$이웃신뢰도, expected = T) # low
CrossTable(train$외국인_가족, train$이웃신뢰도, expected = T) # low
CrossTable(train$정치성향, train$이웃신뢰도, expected = T) # low
CrossTable(train$직업, train$이웃신뢰도, expected = T) # low




train
train <- train %>% select(-c(id, 자치구, 가족신뢰도, 공공기관신뢰도, 이웃신뢰도))
str(train)

t<- lm(종합신뢰도~., data=train)
summary(t)

step(t, direction = 'both')

par(mfrow=c(2,2))
plot(t)

t_model <- lm(formula = 종합신뢰도 ~ 성별 + 연령 + 학력 + 소득 + 
                혼인상태 + 주택형태 + 종교 + 서울고향 + 행복_건강 + 
                행복_재정 + 행복_친구 + 기부 + 사회적지위 + 
                약자_장애 + 약자_제도 + 약자_노인 + 약자_여성 + 
                외국인_친구 + 외국인_이웃 + 외국인_가족 + 
                정치성향 + 직업, data = train)

summary(t_model)
plot(t_model)
par(mfrow=c(1,1))



