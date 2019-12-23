#예제 1 - 단일집단 평균검정
setwd("c:/Rwork/Part-III")
data <- read.csv("one_sample.csv", header = T)
str(data)
head(data)
x <- data$time
head(x)
summary(x)

mean(x, na.rm = T)

x1 <- na.omit(x)
summary(x1)
shapiro.test(x1)
hist(x1)
qqnorm(x1)

t.test(x1, mu=5.2)
t.test(x1, mu=5.2, alternative = "greater", conf.level = 0.95)


#예제2 - 두집단간 비율 분석

data <- read.csv("two_sample.csv", header = T)
data
head(data)

x <- data$method
y <- data$survey

table(x)
table(y)
table(x,y, useNA = 'ifany')

#귀무가설이 채택, 두 집단간의 차이는 없다.
prop.test(c(110, 135),c(150,150), alternative = "greater")

#대립가설이 채택, 앞의 값이 뒤에 값보다 적다.
prop.test(c(110, 135),c(150,150), alternative = "less")



#예제3 - 두집단의 평균검정

result <- subset(data, !is.na(score), c(method, score))
head(result)

length(result$score)

a <- subset(result, method == 1)
b <- subset(result, method == 2)

a1 <- a$score
b1 <- b$score

mean(a1)
mean(b1)

var.test(a1, b1)

t.test(a1,b1, var.equal = T)


#예제4 - 대응 두집단 평균 검정

data3 <- read.csv("paired_sample.csv", header=TRUE)
head(data3)
summary(data3)
result <- subset(data3, !is.na(after), c(before,after))
head(result)

x <- result$before
y <- result$after

mean(x)
mean(y)

var.test(x, y, paired = T) # 동질집단일 때에는 paired를 Ture로 줘야됨.

t.test(x, y, paired = T)


#교차검정

data <- read.csv("cleanDescriptive.csv", header = T)
head(data)
x <- data$level2 # 부모의 학력수준 정보
y <- data$pass2 # 자녀의 대학 진학여부

table(x,y)


install.packages("gmodels") # crossTable을 지원하는 패키지
library(gmodels)
library(ggplot2) #diamond 모델 

data("diamonds")
diamonds
CrossTable(x = diamonds$color, y = diamonds$cut)
