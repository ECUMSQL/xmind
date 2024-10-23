###########################Linear regression###################
###############################################################

####(1) One-Variable Linear Regression

################################## Simulate Data ##################################
i.dim = 50 # Data Size
set.seed(1234) 

#independent variable
xv = rnorm(i.dim,5,2) # price

# error term in regression model
rv = rnorm(i.dim,0,1) #error term

# Parameters for assignment
b.1 = -0.90  #slope
b.0=10.13   #intercept

#dependent variable 
yv=b.0+b.1*xv+rv ######sales
yv1=round(yv)

#data frame 
marketingdata <- data.frame(yv1,xv)

#############################Analysis: recover the coefficient########

## scatter plot
plot(marketingdata$xv,marketingdata$yv1,xlab="price", ylab="sales",xlim=c(0,10),ylim=c(1,11),type="p",cex = 1.5, lwd =1.5,pch=21,col="blue")
title("Demand Analysis ¨CPlot")
abline(c(10.36,-0.92),lwd=2,lty=1, col="red")  #####a, b	the intercept and slope, single values

#regression results:using package lm
summary(marketingdata$xv)
model1 = lm(yv1 ~ xv,data=marketingdata)
print(model1)
summary(model1)
model1$residuals
model1$fit
RSS=sum(model1$residuals^2)
TSS=sum((yv1-mean(yv1))^2)
R2=1-RSS/TSS


#regression results: Matrix Operations

#X*y 
#t(X)%*%y #matrix multiplication
#crossprod(X,y) # t(X) %*%Y
#chol2inv(chol(X))# compute inverse of square positive definite matrix using its Cholesky root

# Example (linear regression)
xv <- matrix(as.numeric(xv),ncol=1)
xv1 <-cbind(rep(1,nrow(xv)),xv)
XpXinv = chol2inv(chol(crossprod(xv1)))
bhat = XpXinv%*%crossprod(xv1,yv1) # the coefficient of linear regression 
res = as.vector(yv1-xv1%*%bhat)


######################Regression results application
#(1) Optimal Pricing 
f=function(xv)(xv)^2*(-0.92)+10.36*xv
df=curve(f,0,10,xlab="price", ylab="Revenue" ) 
max(df$y,na.rm = TRUE)
 #maximum revenue  29.1648

df$x[which(df$y==(max(df$y,na.rm = TRUE)))]
 #maximum value of price 5.6



#(2) price elasticity
logxv=log(xv)
logyv=log(yv1)
model2 = lm(logyv ~ logxv)
summary(model2)
##coefficient  -0.42640  is the price elasitity




####(2) Multiple Linear Regression

#Price is not correlated with advertising
################################## Simulate Data ##################################
i.dim = 50 # Data Size
set.seed(1234)
xv2 =rnorm(i.dim,3,1) # advertising
xv1 = rnorm(i.dim,5,2) # price
rv = rnorm(i.dim,0,1) # error term in outcome model
# Parameters for assignment
b.1 = -0.90
b.2=2
b.0=10.13
yv=b.0+b.1*xv1+b.2*xv2+rv ######sales
yv1=round(yv)

#Estimation
model3 = lm(yv1 ~ xv1+xv2)
summary(model3)
model4 = lm(yv1 ~ xv1)#omitted variable 
summary(model4)


######Price is  correlated with advertising
################################## Simulate Data ##################################
i.dim = 50 # Data Size
set.seed(1234)
xv2 =rnorm(i.dim,3,1) # advertising
xv1 = rnorm(i.dim,5,2)+2*xv2 # price(correlation with advertising)
rv <- rnorm(i.dim,0,1) # error term in outcome model
# Parameters for assignment
b.1 = -0.90
b.2=2
b.0=10.13
yv=b.0+b.1*xv1+b.2*xv2+rv ######sales
yv1=round(yv)

#Estimation
model5 = lm(yv1 ~ xv1+xv2)
summary(model5)
model6 = lm(yv1 ~ xv1)#omited variable 
summary(model6)
