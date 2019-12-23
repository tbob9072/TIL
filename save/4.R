#예제 1

setwd("c://Rwork/ml")

drink = read.csv("drink.csv", header = T)
View(drink)
str(drink)

library(class)

# y값에 범주형 데이터가 들어가야 됨.
m = glm(지각여부 ~ 나이 + 결혼여부 + 자녀여부 + 체력 + 주량 + 직급 + 성별, family = binomial(link = logit), data = drink)
# y에 대해서 binomial로 이항분류 적용해줘야됨. family = binomial(link = logit)

m
# e는 뒤에 10의 n승이라는 의미임 뒤에 -01이 붙으면 10 -1승으로 0.1이라는 의미이다.
# 즉 4.581e-01이면 0.4581이라는 뜻임
# 나온 값을 exp(지수함수)에다가 넣고 값을 돌려보면 1이 나오면 상관없다는 거고 클수록 상관있다는 것임

predict(m, drink, type = "response")

predict(m, drink, type = "response") >= 0.5

table(drink$지각여부, predict(m, drink, type = "response") >= 0.5)

summary(m)

exp(-1.312e-14)



#예제 2


install.packages("aod")
library(aod)
library(ggplot2)
mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
str(mydata)
summary(mydata)
mydata$rank = factor(mydata$rank)

sapply(mydata, sd) # 표준편차를 구하는 함수 (두번째 변수), mydata에 적용 해주는 거임

xtabs(~admit+rank, data = mydata)

#glm에 들어가는 y값은 무조건 범주형이어야되서 자동으로 변환 시켜줌
mylogit <- glm(admit ~ gre + gpa + rank, data = mydata, family = "binomial")
summary(mylogit)
# summary로 나온 Estimate값을 보면 log함수 값이기 때문에 양의 정수일 때 x값이 1보다 커야 된다.
# 이 말은 곧 p(y), 즉 성공할 확률이 실패할 확률보다 높음을 의미한다.
# 더미변수인 rank1은 자동으로 형성이되고 이 더미변수는 아무런 영향력이 없는 친구이다.
# rank2부터는 rank1에 비해서 얼마나 영향력이 있나 보여주는 것임. 



# 예제 3
install.packages("foreign")
install.packages("nnet")
install.packages("reshape2")

require(foreign)
require(nnet)
require(ggplot2)
require(reshape2)


ml <- read.dta("https://stats.idre.ucla.edu/stat/data/hsbdemo.dta")
