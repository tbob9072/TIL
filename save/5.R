install.packages("rpart")
library(rpart)


# CART : 목적변수가 범주형(지니지수), 연속형(분산이용)
help("rpart")

m <- rpart(Species~., data = iris)
m


#그래프로 그려보기
plot(m, margin = .2)
text(m, cex=0.6)

install.packages("rpart.plot")
library(rpart.plot)
prp(m, type = 4, extra = 2, digits = 3)


# ctree
install.packages("party")
library(party)

m2 <- ctree(Species~., data = iris)
m2
plot(m2)
