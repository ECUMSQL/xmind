## (I) Example of Wine Price Prediction
curwd = setwd('C:/Users/cuixu/Desktop/Week 4/wine dataset/')
wine<- read.csv("wine.csv")
str(wine)
summary(wine)
model1=lm(Price~AGST,data=wine)
summary(model1)

model1$residuals
RSS=sum(model1$residuals^2)
RSS

model2=lm(Price~AGST+HarvestRain,data=wine)
summary(model2)
RSS=sum(model2$residuals^2)
RSS

model3=lm(Price~AGST+HarvestRain+WinterRain+Age+FrancePop,data=wine)
summary(model3)
RSS=sum(model3$residuals^2)
RSS

model4=lm(Price~AGST+HarvestRain+WinterRain+Age,data=wine)
summary(model4)
RSS=sum(model4$residuals^2)
RSS

#####multicolinearity 
cor(wine$WinterRain,wine$Price)
cor(wine$Age,wine$FrancePop)
cor(wine)

model5=lm(Price~AGST+HarvestRain+WinterRain,data=wine)
summary(model5)
RSS=sum(model5$residuals^2)
RSS

### test linear regression (multicollinearity problem)
install.packages("car")
library(car)
vif(model3)
sqrt(vif(model3))>2 #squart vif >2  has multicollinearity problem

###############making prediction 
wineTest<- read.csv("wine_test.csv")
str(wineTest)
predictTest=predict(model4,newdata=wineTest)
predictTest
RSS= sum((wineTest$Price-predictTest)^2)
TSS= sum((wineTest$Price-mean(wine$Price))^2)
Test_R2=1-RSS/TSS
mean((predictTest-wineTest$Price)^2)





## (II) Example of Boston Housing Dataset

 install.packages("MASS")
library(MASS)
data(Boston)
str(Boston)

# Regression formulae

fit <- lm(medv~rm,data=Boston)
summary(fit)

fit <- lm(medv~rm+age,data=Boston)
summary(fit)

fit <- lm(medv~rm+age+rm:age,data=Boston)  ####interaction term
summary(fit)

fit <- lm(medv~rm*age,data=Boston)  ####interaction term
summary(fit)

fit <- lm(medv~rm*age+I(rm^2)+I(age^2),data=Boston)  ####rm square term
summary(fit)

fit <- lm(medv~.,data=Boston)  ####all the variables regression
summary(fit)

fit <- lm(medv~.-age,data=Boston)### drop variable age
summary(fit)


# Validation Set Approach

set.seed(1)
train <- sample(506,354)  #training sample: randomly sample 354 number from 506


fit <- lm(medv~.,data=Boston,subset=train)
summary(fit)
pred <- predict(fit,Boston[-train,])
y.test <- Boston$medv[-train]
mean((pred-y.test)^2)

set.seed(123)  
train <- sample(506,354) # check robustness by using different seed and having different sample
fit <- lm(medv~.,data=Boston,subset = train)
summary(fit)
pred <- predict(fit,Boston[-train,])
y.test <- Boston$medv[-train]
mean((pred-y.test)^2)

# Cross Validation

install.packages("boot")
library(boot)

fit <- glm(medv~.,data=Boston)  ####glm=lm
set.seed(1)
cv.err <- cv.glm(Boston,fit,K=10) ###10 fold cross validation
names(cv.err)
cv.err$delta  #cross-validation error

set.seed(123)
cv.err <- cv.glm(Boston,fit,K=10)
cv.err$delta ##first value is general cross-validation error, second value is bias-corrected cross-validation error

# LOOCV
cv.err <- cv.glm(Boston,fit)####leave-one-out cross validation(LOOCV)
cv.err$delta

#compare time between 10 fold and LOOCV
system.time(cv.glm(Boston,fit,K=10))
system.time(cv.glm(Boston,fit))