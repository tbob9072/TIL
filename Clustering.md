# 비지도학습 : 군집화 (Clustering)

# 1. 군집화

> - 유사성 혹은 비유사성에 근거해서 패턴화
> - 유사성 기반의 그룹화를 응용하여 역으로 이상치(Outlier)등의 특이점 혹은 비정상 패턴을 찾는 분야 등에 활용
> - 유사한 개체들을 묶어 필요한 정보를 압축하여 활용(동영상 압축)
> - 평가 = 집단간의 분산 ↑ / 집단내의 분산 ↓

### 계층적 클러스터

> - 각 관측치는 자신을 하나의 최초 군집으로 시작한다. 그 다음 유사도를 이용해 한번에 두 개씩 모든 군집들이 하나의 군집이 될 때까지
> - 대략적으로 몇가지 그룹으로 이뤄지는지 확인하는데 사용할 수 있음



### 비계층적 클러스터

#### K- means 클러스터링

> - 주어지는 군집 수 k에 대해서 군집 내 거리 제곱 합의 합을 최소화하는 형태로 데이터 내의 개체들을 서로 다른 군집으로 그룹화하는 기법
> - 이상치가 포함되어있는 경우에는 이상한 결과값이 나올 수 있다. 이상치 처리가 필수적임
> - 결과값들 중 cluster, withness, betweeness 3가지가 추가됨
>   - cluster : 집단 구분
>   - withness : 집단내 분산
>   - betweeness : 집단간 분산
> - k값에 따라 withness와 betweeness가 변하는데 급감하는 점(elbow point)을 찾아 k값으로 설정해줘야된다.

```R
library(ggplot2)
data(diamonds)
head(diamonds)
str(diamonds)

t <- sample(1:nrow(diamonds), 1000)
test <- diamonds[t,]
dim(test)
test

mydia <- test[c("price","carat","depth","table")]

result <- hclust(dist(mydia), method = "ave") #군집의 대표값으로 ave (평균)을 쓰겠다는 의미

plot(result, hang = -1)


#k means
result2 <- kmeans(mydia, 3)
names(result2)
result2

g1 <- subset(mydia, result2$cluster == 1)
summary(g1)

g2 <- subset(mydia, result2$cluster == 2)
summary(g2)

g3 <- subset(mydia, result2$cluster == 3)
summary(g3)

#적절한 k값 찾기 (elbow point 이용)
km.out.withness <- c()
km.out.betweeness <- c()

for(i in 2:7) {
  set.seed(1)
  km.out <- kmeans(mydia, centers = i)
  km.out.withness[i-1] <- km.out$tot.withinss
  km.out.betweeness[i-1] <- km.out$betweenss
}
data.frame(km.out.withness, km.out.betweeness)
```



#### DB Scan

> - k평균 기법이 K개의 평균과 각 데이터 점들 간의 거리를 계산하여 그룹화를 하는 반면, 밀도개념을 도입하여 일정한 밀도로 연결된 데이터집합은 동일한 그룹으로 판정하여 노이즈 및 이상치식별에 강한 군집화 기법

#### 연관성규칙(장바구니분석)

> - 연관석 분석 기법은 방대한 데이터 세트에서 객체나 아이템 간의 연관관계를 찾아내는 분석기법
> - {X} -> {Y} 처럼 특정 아이템 'X'가 발생하면 'Y'가 함께 발생한다는 형태로 표현한다.
> - 사전에 목표변수(Y)가 주어지지 않으며, 각 트랜잭션(혹은 거래데이터)에서 객체나 아이템 간의 패턴을 찾아내는 기법이므로 자율학습(비지도 학습)기법에 속한다.
> - 주요 3개 척도
>   - 지지도 : 전체 거래건 수에서 특정한 아이템 조합이 등장하는 정도
>   - 신뢰도 : X가 발생했을 때, Y가 발생한 비율을 의미 (조건부 확률)
>   - **향상도** : 지지도와 신뢰도가 중요한 요소임엔 틀림없지만, 만약 Y의 등장횟수가 많아서 X와 많이 묶여있는 것이라면 의미가 없어짐. 그렇기 때문에 X와 Y가 함께 나타나는 경우의 수가 많아서 그런 것인지, Y의 양이 많아서 X와 함께 탐색된 것인지 검증하는 지표이다.
> - 모든 분석은 데이터셋을 메트릭스화 시켜서 넣어야됨. 하지만 관련코드에 자동으로 변환시켜주는 코드가 있기때문에 적절히 사용하면됨
> - 주요 활용 분야
>   - 쇼핑/유통 분야에서 구매된 물품 간의 장바구니 분석
>   - 금융상품이나 서비스 간의 가입 패턴의 연관성 분석
>   - 웹 페이지 간의 방문 영관성 및 순서 패턴 도출 통한 쿠폰 마케팅 등 활용

- 클라우드 서비스
  - 기존에는 컴퓨터만 클라우드에 연결되어 원하는 서비스를 24시간 받는 것
  - 현재는 센서, 휴대폰 등 사물인터넷도 포함됨
  - 나중에는 분석도 클라우드 서비스로 제공될 가능성이 높으므로 비즈니스 모델을 해석하고 분석결과를 해석하는 능력을 키우는 것이 좋음

> - 연관성규칙 생성을 위한 주요 알고리즘
>   - 아프리오리 알고리즘
>   - 빈출패턴 성장

> - 연관성규칙 실습
>   - arules패키지는 transactions 타입의 데이터만 받으므로 csv파일을 불러오면 transactions타입으로 변환하여 넣어야 됨

```R
#연관성규칙
install.packages("arules")
install.packages("arulesViz")
library(arules)
library(arulesViz)
data(Groceries)
str(Groceries)
Groceries
inspect(Groceries)
summary(Groceries)


sort(itemFrequency(Groceries,type="absolute"),decreasing = T)
itemFrequencyPlot(Groceries,topN=10,type="absolute")
itemFrequencyPlot(Groceries,topN=10,type="relative")


apriori(Groceries) #support=0.1, confidence=0.8
result_rules<-apriori(Groceries, # transactions형태의 자료를 그대로 담음
                      parameter=list(support=0.005,confidence=0.5,minlen=2)) #파라미터는 데이터에 따라서 달라지니까 알아내서 넣어야됨
result_rules
summary(result_rules) # {lhs} --> {rhs}
inspect(result_rules[1:10])


#트랙잭션 생성하기
setwd("C:\\r_data\\kame_data\\Part-IV")
help("read.transactions")
stran2<-read.transactions("single_format.csv",format="single",
                          sep=",",cols=c(1,2), rm.duplicates=T)
summary(stran2)



# 연습문제 1-1
setwd("c://Rwork/ml")
build <- read.csv("building.csv", header = T)
build[is.na(build)] <- 0
build <- build[-1]
build

library(arules)
trans <- as.matrix(build, "transaction")
View(trans)
rules1 <- apriori(trans, parameter = list(supp = 0.2, conf = 0.6, target = "rules"))
rules1

inspect(sort(rules1))

rules2 <- subset(rules1, subset = lhs %pin% '보습학원' & confidence > 0.7)
inspect(sort(rules2))

rules3 <- subset(rules1, subset = lhs %pin% '편의점' & confidence > 0.7)
inspect(sort(rules3))

b2 <- t(as.matrix(build)) %*% as.matrix(build)
install.packages("sna")
install.packages("rgl")
library(sna)
library(rgl)
b2.w <- b2 - diag(diag(b2))
gplot(b2.w, displaylabels = T, vertex.cex = sqrt(diag(b2)), vertex.col = "green", edge.col = "blue", boxed.labels = F,
      arrowhead.cex = .3, label.pos = 3, edge.lwd = b2.w*2)
```

