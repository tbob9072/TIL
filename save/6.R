# 

install.packages("party")
library(party)
str(airquality)
summary(airquality)

air_ctree <- ctree(Temp ~ Solar.R + Wind + Ozone, data = airquality)
air_ctree
plot(air_ctree)



# 랜덤포레스트
install.packages("randomForest")
library(randomForest)
rf <- randomForest(Species ~ . , data = iris, importance = TRUE)
rf
importance(rf)
varImpPlot(rf, main="varImpPlot of iris")
