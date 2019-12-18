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
> - 등등



### CART 실습

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
> - 속성개수가 30개 이하일 때만 사용가능 (빅데이터, 머신러닝분야에서는 활용이 어려움)

~~~R
# ctree
install.packages("party")
library(party)

m2 <- ctree(Species~., data = iris)
m2
plot(m2)
~~~

