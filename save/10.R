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
