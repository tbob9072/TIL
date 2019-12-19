# 의사결정 트리(Decision Tree)

- S/W = program = Data + code
- Data의 양이 많아짐에 따라 code가 동일하더라도 Data의 관리에 따라 연산 속도가 달라짐. 
- 그래서 대두된 것이 **자료구조**임 
- 자료구조는 두 가지로 나눠짐
  - 선형 : 데이터를 일렬로 나열하는 것 (물리적, 논리적)
    - ex) R의 vector구조
  - 비선형 :  선형적이지 않은 데이터를 통칭 (위아래, 계층구조)
    - ex) tree구조



- Tree구조 : 그래프의 일종이지만 cycle이 없음 (계층때문에 위로 못올라감)
- 가장 큰 장점은 탐색시간을 줄여줌 (log 2 n 으로 줄여줌)



## 1. 의사결정트리란?

> - 머신러닝 기법 중 하나로 여러 가지 규칙을 순차적으로 적용하면서 독립 변수 공간을 분할하는 분석 모형이다.
> - 분류기준을 정할 때는 기준에 따라 나눴을 때 불순도가 가장 낮도록 해야한다.
> - 분류기준은 개별속성을 여러번 사용할 수 있다.
> - 한 종류로만 이뤄진 노드(순수노드)가 만들어질 때까지 계속 진행한다.
> - 통계학적으로 보강한 랜덤포레스트, **XGboost**도 있다.



## 2. 의사결정트리 분석 방법

- 성장단계 : 각 마디에서 적절한 최적의 분리규칙(불순도가 낮음)을 찾아서 나무를 성장시키는 과정 
  - 불순도 : 데이터가 제대로 분류되지 않고 섞여있는 정도
    - ex ) 50:50일 때 불순도는 최대가 됨
  - 정보이득(Information Gain)이라는 값이 최대가 되도록 만들어줌
    - 불순도와 counterpart임 
    - `정보이득값 = 부모 노드의 데이터 불순도 - 자식노드의 데이터 불순도의 합`  : 자식으로 갈 수록 불순도가 낮아져야 정보이득값이 최대가 됨
  - 최상단에 위치한 분리규칙이 불순도를 제일 낮게 만들어 주기 때문에 가장 중요한 속성값임 -> ***그래서 주요변수를 찾을 때 사용 가능하다***
  - 이상치가 속하게 되면 tree가 깊어지게 되고 과적합(overfitting)이 일어날 수 있다.
- 가지치기단계 : 오차를 크게 할 위험이 높거나 부적절한 추론규칙을 가지고 있는 가지 또는 불필요한 가지를 제거 (과적합 방지)
  - 사전가지치기 : 생성할 때 단계를 미리 정하고 진행 (**대부분 이것 선택**)
  - 사후가지치기 : 다 완성한 후 잘라내는 것



### 불순도 측정방법

> - 지니 인덱스 (Gini Index)
> - 엔트로피 (entropy) : 스트레스 지수라고도 부름
>
> - 분류 오류 (Classification Error) : 잘안씀

![](https://tensorflowkorea.files.wordpress.com/2018/03/overview-plot.png)

(출처 : [텐서 플로우 블로그][https://tensorflow.blog/tag/%EC%A7%80%EB%8B%88-%EB%B6%88%EC%88%9C%EB%8F%84/])



### 의사결정분석 알고리즘의 종류

> - CART : R의 rpart 라이브러리가 구현한 의사결정 나무 알고리즘
> - CHAID
> - 조건부 추론나무(Conditional Inference Tree) : CART의  두가지 문제 해결
>   - 통계적 유의성에 대한 판단이 없어 과적합(overfitting) 해결
>   - 다양한 값으로 분할 가능한 변수가 선호되는 문제 해결
>   - 정확도는 떨어지기때문에 분위기를 알아보는 정도로 사용함
> - 등등



### rpart : CART 실습

- 코드

~~~R
install.packages("rpart")
library(rpart)


# CART : 목적변수가 범주형(지니지수), 연속형(분산이용)
help("rpart")

m <- rpart(Species~., data = iris)
m
~~~

----

- 결과

~~~R
> m
n= 150 

# 출력순서 설명 : 노드) 분류기준, 만족갯수, 설명안되는 수, 등등
node), split, n, loss, yval, (yprob)
      * denotes terminal node

1) root 150 100 setosa (0.33333333 0.33333333 0.33333333)  
  2) Petal.Length< 2.45 50   0 setosa (1.00000000 0.00000000 0.00000000) *
  3) Petal.Length>=2.45 100  50 versicolor (0.00000000 0.50000000 0.50000000)  
    6) Petal.Width< 1.75 54   5 versicolor (0.00000000 0.90740741 0.09259259) *
    7) Petal.Width>=1.75 46   1 virginica (0.00000000 0.02173913 0.97826087) *
~~~

- 그래프 그려보기

```R
plot(m, margin = .2)
text(m, cex=0.6)

install.packages("rpart.plot")
library(rpart.plot)
prp(m, type = 4, extra = 2, digits = 3)
```

----



### ctree 실습

> - CART는 이분법적인 사고가 강하기 때문에 약간의 차이만으로 오차가 크게 생길 수 있음. 이를 보완한 것이 ctree임
> - 속성개수가 30개 이하일 때만 사용가능 (빅데이터, 머신러닝분야에서는 활용이 어려움 - 하지만 본격적으로 분석에 돌입하기 전에 분위기를 보는 용도로는 많이 쓰임)

~~~R
# ctree 1번
install.packages("party")
library(party)

m2 <- ctree(Species~., data = iris)
m2
plot(m2)
~~~

~~~R
# ctree 2번
air_ctree <- ctree(Temp ~ Solar.R + Wind + Ozone, data = airquality)
air_ctree
#그래프그려보기
plot(air_ctree)

-----------결과------------

	 Conditional inference tree with 5 terminal nodes

Response:  Temp 
Inputs:  Solar.R, Wind, Ozone 
Number of observations:  153 

1) Ozone <= 37; criterion = 1, statistic = 56.086
  2) Wind <= 15.5; criterion = 0.993, statistic = 9.387
    3) Ozone <= 19; criterion = 0.964, statistic = 6.299
      4)*  weights = 29 
    3) Ozone > 19
      5)*  weights = 69 
  2) Wind > 15.5
    6)*  weights = 7 
1) Ozone > 37
  7) Ozone <= 65; criterion = 0.971, statistic = 6.691
    8)*  weights = 22 
  7) Ozone > 65
    9)*  weights = 26
~~~

> - 넣은 변수 중 Solar.R은 등장하지 않기 때문에 중요한 변수는 아니다.
>
> - 또한 상위계층에 위치한 Ozone이 wind보다는 더 중요한 변수이다.
>
> - criterion = 1 - p-value 임, 즉 0.95보다 criterion이 크면 귀무가설을 기각하여도 5%의 오류발생정도이기 때문에 대립가설을 사용한다.
>
>   (여기서 대립가설은 분류기준으로 선택된 내용이다.)
>
> - *찍힌 애들은 더이상 분기하지 않는 친구들이다.



## 3. Tree의 구조

- Decision Tree(의사결정트리) : y가 범주형
- Regresstion Tree(회귀트리) : y가 연속형



## 4. 회귀트리

> -  결정트리와 닮았지만 주요한 차이는 각 노드에서 **클래스**를 예측하는 대신 **값**을 예측한다는 점이다.
> - 나온 값 중에서 mse는 평균제곱오차율을 나타내는 것이다.
> - 오차율이란 예측치와 실측치의 차이점을 뜻한다. 작을수록 예측치로 대다수의 실측치들이 설명이 된다는 의미이다.
> - 자식계층으로 내려갈수록 오차율이 낮아지는 방향으로 분기하는 것이다.
> - 결정트리의 주된 문제점은 훈련 데이터에 있는 작은 변화에도 매우 민감하다(평균값으로 나누기 때문에 이상치에 영향을 받음, 또한 경계에 있는 친구들이 문제를 일으킴)
>   - 그래서 문제가되는 데이터는 제거해주는 것이 좋음

### 회귀트리의 과적합

> - 과적합이 발생하면 훈련한 데이터는 잘 처리하지만, 새로들어온 데이터를 못푸는 문제가 발생함 (너무 디테일하게 들어가면 이미 주어진 데이터에만 특화됨)
> - 그래서 규제를 해서 핵심만 찾을 수 있도록 모델을 만드는 것이 좋음



## 5. 앙상블 기법

> - 머신러닝에서는 주로 지도학습에 사용된다.
> - 배깅(Bagging) 
>   - Bootstrap Aggregating 의 약자임
> - 부스팅(Boosting)
>   - bootstrap 표본추출시, 단계별로 표본추출 확률을 조정함
>   - 전 단계에서 오분류된 데이터가 추출될 확률을 높여서 오류가 높은 부분에 대해 학습량을 늘려서 정확도를 향상시키는 방식
>   - 배깅과 다르게 병렬구조가아닌 직렬모델이다.
>   - ex) Ada Boost : weak classifier를 계속 활용해서 strong classifier를 만드는 방식
> - 스태킹(Stacking)



> - 



## 6. Random Forest

> - 앙상블 방식 중 배깅방식을 사용한 모델이다.
> - 여러 예측모델의 예측을 모아서 종합적으로 예측하는 것
> - 데이터를 쪼개서 여러개의 트리를 만들고(중복을 허용함 - Bootstrap) 여러트리를 종합(병렬적으로 바라봄 - Aggregating)하여 투표 후 결과를 도출해 내는 것
> - 데이터의 양이 충분하다면 7:3 이상으로 Training set, Test set으로 나눠서 학습하고 검사를 한다.
> - Training set에서 추출할 때 빠진 친구들(out of bag sample : OOB)이 있는데 이 친구들은 모아서 유효성 검사용으로 사용한다.
> - Training -> OOB -> Test set 순으로 사용

![](https://miro.medium.com/max/1170/1*58f1CZ8M4il0OZYg2oRN4w.png)

(출처 : [APPLYING RANDOM FOREST (CLASSIFICATION)](https://medium.com/@ar.ingenious/applying-random-forest-classification-machine-learning-algorithm-from-scratch-with-real-24ff198a1c57))

~~~R
# Random Forest 실습
install.packages("randomForest")
library(randomForest)
rf <- randomForest(Species ~ . , data = iris)
rf

-------------------------결과-----------------------------

Call:
 randomForest(formula = Species ~ ., data = iris) 
               Type of random forest: classification
                     Number of trees: 500
No. of variables tried at each split: 2

        OOB estimate of  error rate: 4%
Confusion matrix:
           setosa versicolor virginica class.error
setosa         50          0         0        0.00
versicolor      0         47         3        0.06
virginica       0          3        47        0.06
~~~

> - OOB estimate of error rate 
>   - 평가용 데이터가 4%정도 오분류를 낼 것이라고 예측한다는 의미
> - confusion matrix 해석
>   - 행 : 실측치
>   - 열 : 예측치

~~~R
# 변수의 중요도 평가
rf <- randomForest(Species ~ . , data = iris, importance = TRUE)
importance(rf)
varImpPlot(rf, main="varImpPlot of iris")

-------------------------결과-----------------------------

               setosa versicolor virginica
Sepal.Length  6.584302  5.9330530  8.141629
Sepal.Width   4.439434  0.4044195  5.482658
Petal.Length 23.739392 35.1686258 29.135377
Petal.Width  20.590738 30.4599128 28.673503
             MeanDecreaseAccuracy MeanDecreaseGini
Sepal.Length            10.491726         9.962692
Sepal.Width              4.428468         2.447807
Petal.Length            35.833564        45.011880
Petal.Width             31.332954        41.842015
~~~

> - MeanDecreaseAccuracy : 정확도를 개선시키는데 얼마나 영향력이 있나
> - MeanDecreaseGini : 불순도를 개선시키는데 얼마나 영향력이 있나
>   - 둘다 높을 수록 중요한 변수들임
> - 어느 선이 높은 것인지에 대한 절대값은 없음 그렇기 때문에 여러 변수선정 기법들(회귀분석, 경험상, XGboost)을 사용하여 선정하면 됨 (참고값으로 사용할 것)

### 파라미터 튜닝

> - ntree : randomForest()에는 나무 개수
> - mtry : 자식 노드로 나누는 기준을 정할 때 고려할 변수의 개수