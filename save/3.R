data(cars)
head(cars)
m <- lm(dist~speed, data = cars)
m
summary(m)

# fitted가 대체 뭐야?!
fitted(m)[1:4]

# 잔차
residuals(m)[1:4]

# fitted 값과 residuals 값을 합하면 실측치가 나옴

predict(m, newdata = data.frame(speed = 3))

library(MASS)
data(Boston)
head(Boston)

install.packages("mlbench")
library(mlbench)
data("BostonHousing")

m2 <- lm(medv ~., data = BostonHousing  )
summary(m2)

m3 <- step(m2 ,direction = "both")
