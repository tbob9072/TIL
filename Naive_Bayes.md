# Naive Bayes

> - Naive Bayes는 compound로 Bayes라는 조건부확률 통계학적인 추론기법에 Naive라는 기법을 추가한 것



## 1. 조건부 확률

> - 확률공간의 두 사건 A, B에 대해서 P(B) > 0의 조건 하에, B가 일어났을 때, A가 일어날 확률을 P(A|B)라 표기한다.
> - **P(A|B) = P(A ∩ B) / P(B)**
> - A와 B의 사건이 서로 독립이라면 P(A|B) = P(A), P(B|A) = P(B)가 성립하며 **P(A ∩ B) = P(A)P(B)**가 성립한다.



## 2. 나이브 베이즈(Naive Bayes) 기법

> - 나이브 베이즈 기법
>   - 목표변수의 범주를 학습시키기 위해 통계학에서 사용되는 베이즈 정리를 사용한다. 즉, 나이브 베이즈 기법은 베이즈 확률 추정에 기반을 둔 확률 모형이다.
> - 베이즈 정리 (Bayes' theorem)
>   - **P(A|B) = P(B|A) X P(A) / P(B)**
>   - 예를 들어 B = '반짝할인'이 들어간 메일 중 A = '스팸'일 확률을 구하고 싶다고 한다면 B가 feature와 같은 역할이고 A가 label과 같은 느낌이다. 하지만 B로 A를 파악하는 것이 애매하기때문에 베이즈 정리 를 활용하여 구할 수 있는 값들로 지도학습시키는 것이다.
> - 나이브의 의미
>   - 변수로 정한 사건이 일어날 수치는 알 수 있지만, 그 사건에 영향을 주는 세부적인 사건이 존재하고, 얼마나 영향을 주는지 알 수는 없다. 그렇기 때문에 세부사건들이 독립이라고 생각하고 변수로 정한 사건을 대략적으로 추정하는 것.
> - 즉, 사후확률을 구하기 위하여 사전확률들로만 계산할 수 있도록 바꿔놓은 공식

```R
# 실습코드
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

```

