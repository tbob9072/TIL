# 머신러닝 & 알고리즘

## 1. 머신러닝 흐름

> 1. 수집
> 2. 전처리
>    1. 결측치 제거
>    2. 파생, 표준화
>    3. **데이터 분할**
> 3. 학습으로 패턴 찾기
> 4. 분할된 테스트 데이터로 패턴 검증



## 2. 머신러닝 학습방법의 종류

> 1. 지도학습 (Supervised Learning)
>    1. 분류 예측(Classification)
>    2. 수치 예측(Regression)
> 2. 비지도 학습 (Unsupervised Learning)
> 3. 강화학습 (Reinforcement Learning)



> - 지도학습
>   - feature들이 label에 미치는 영향을 파악하여 패턴을 만드는 것 (y값이 데이터안에 주어짐)
>   - cf) 독립변수 --> Features
>   - cf) 종속변수 --> Label
>   - label의 타입(범주형, 연속형)에 따라 학습방법이 또 나눠짐
>     - 분류 예측 알고리즘
>     - 수치 예측 알고리즘
>   - 모델을 평가할 때에는 실측치와 예측치를 비교하여 평가함
> - 비지도학습
>   - 데이터에 feature값만 존재하는 것
>   - label이 없기 때문에 행과 행사이의 유사성을 측정하여 패턴을 만듬
>   - 유사성 = 거리
>   - 거리를 파악하기 위해서는 feature들을 벡터화 시켜줘야함
> - 강화학습
>   - 잘한 것에 보상을 주고 못한것에 벌칙을 부여하는 방식



## 3. 지도학습 실습

### 다중회귀분석으로 모델 만들기

```R
install.packages("caret")
library(caret)

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
```

- 수치형자료를 평가할 때는 평균제곱오차(MES)를 사용함

### 의사결정트리로 모델 만들기

```R
idx <- createDataPartition(iris$Species, p = 0.7, list = F)
iris_train[idx,]
iris_test[-idx,]

library(rpart)

model <- rpart(Species~., data = iris_train)
result <- predict(model, iris_test, type = "class")
head(result)
confusionMatrix(result, iris_test$Species)
```

- 분류예측을 평가 할 경우에는 혼동행렬,  주요평가지표, ROC곡선, K-교차검증을 사용한다.

#### 혼동행렬

> - 예측값과 실제 범주값으로 메트릭스를 구성하여 검증하는 것
>   - TP : 긍정적으로 예측해서 맞은 것
>   - FN : 부정적으로 예측해서 틀린 것 (1종 오류)
>   - FP : 긍정적으로 예측해서 틀린 것 (2종 오류)
>   - TN : 부정적으로 예측해서 맞은 것
> - accuracy = TP + TN / TP + FN + FP + TF
> - sensitivity = TP / TP + FN
> - precision = TP / TP + FP
> - F1-Score는 precision의 값이 높을 수록 더 높은 값을 갖음
>
> 정확도만 보지말고 이런 지표값을들 상세히 봐야 더 정확한 분석이 가능함

### RandomForest

```R
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
```

### KNN : K-최근접 이웃(K-Nearest Neighbor) 기법

> - 특정 데이터 좌표점과 다른 나머지 데이터 좌표점 들간의 거리에 기반을 두어 가장 가까운 K개점들의 목적변수(혹은 반응변수) 값들의 다수결로 분류하는 기법
> - 근처에 있는 친구들을 따라가기 때문에 정확도 면에서는 많이 떨어짐
> - K를 자신의 마음대로 정하기 때문에 근거가 부족함
> - K계 안에 들어오면 영향을 주는 정도가 같다라고 보기 때문에 가중치에 대한 요구가 있었음 --> 그 결과 가중치있는 KNN모델도 나옴
> - 새로운 데이터가 주어질 때마다 모든 데이터와의 유사성을 계산해야 하므로 소요시간이 오래걸림, Lazy Learning으로도 불림

```R
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
```

> - Minkowski Distance
>   - 두 점 사이에 장애물이 없을 경우에는 피타고라스 정리로 계산함
>   - 장애물이 있다면 맨하탄의 거리로 계산함

