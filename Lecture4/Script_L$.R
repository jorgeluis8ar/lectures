# Script lecture 4- Big Data & Machine Learning 
#Installing the packages need to run the code
require("dplyr")
#install.packages("McSpatial")
#This package contains the dataset we're going to use
require("McSpatial")
#install.packages("stargazer")
require("stargazer")


data(matchdata)
?set.seed
# Used by Ignacrio set.seed(10101)
set.seed(341234)
#Spliting the sample into training and test. 
# In this example we're using 70% training and 30% testing
indic=sample(1:nrow(matchdata),floor(.7*nrow(matchdata)))

#specifing the datasets
train=matchdata[indic,]
test=matchdata[-indic,]

reg1=lm(lnprice~bathrooms, data=train)
summary(reg1)
#stargazer(reg1,type="latex")
stargazer(reg1,type="text")

test$yhat=predict(reg1,test)
test<- test %>%mutate(err=(lnprice-yhat)^2)
sqrt(mean(test$err))

reg2<-lm(lnprice~bathrooms+rooms+fireplace,data=train)
test$yhat_2=predict(reg2,test)
test<- test %>%mutate(err_2=(lnprice-yhat_2)^2)
sqrt(mean(test$err_2))