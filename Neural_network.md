# 인공신경망(neural network)

![](https://miro.medium.com/max/1826/1*L9xLcwKhuZ2cuS8fF0ZjwA.png)

[(출처 : towards data science)](https://towardsdatascience.com/power-of-a-single-neuron-perceptron-c418ba445095)

## 1. 인공신경망 발전의 역사

> - 1943년 매컬로크-피츠 뉴런
>   - and, or, not과 같은 선형처리가 잘되는 신경망을 만들어냄
> - 1957년 퍼셉트론
>   - 입력층 1개, 출력층 1개로 선형적인 모델을 해결하는데 특화
>   - XOR문제와 같은 비선형적문제는 해결하지 못함
> - 다층퍼셉트론 (Multi Layer Perceptron)
>   - 입력층과 출력층 사이에 **중간층(Hidden layer)**을 두어 다양한 관점으로 현상을 바라 볼 수 있게됨. 비선형적인 문제도 해결할 수 있도록 개선된 모델
>   - 정확도를 높이기 위해서는 중간층의 갯수를 늘리거나, 중간층 안에 노드수를 늘리는 방법이 존재함 (무조건 많이 늘리는 것이 좋은 것은 아님)



- SVM, 인공신경망 기법을 사용할 때 경사하강법을 사용하기 때문에 표준화, 정규화를 꼭 해줘야함.

```R
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

```

- scale함수는 표준화시켜주는 작업임 0을 평균으로 표준편차가 1이되도록 만들어줌.
- 정규화는 모든데이터가 0 ~ 1사이로 rescaled됨. 표준편차가 매우 작을 때 효과적임
  - 정규화시에는 outlier들에 대한 정보가 사라지는 경향이 있다.