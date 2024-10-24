//线性测试 散点图
drop if missing
twoway(scatter logwage educ)(lfit logwage educ),name(plot1)
twoway(scatter logwage potexper)(lfit logwage potexper),name(plot2)
twoway(scatter logwage ability)(lfit logwage ability),name(plot3)
graph combine plot1 plot2 plot3
regress logwage educ potexper ability      //回归
estat vif //共线性测试
//第二题 残差回归
set matsize 11000
regress mothered educ potexper ability //预测并计算残差
predict resid_mother, residuals 
regress fathered educ potexper ability
predict resid_father, residuals
regress siblings educ potexper ability
predict resid_siblings, residuals
// 将残差组合成矩阵 X2_star(其实也可以不，就是一个矩阵更清爽而已，其他一样)
regress logwage educ potexper ability resid_siblings resid_father resid_mother
regress logwage educ potexper ability mothered fathered siblings

//第三题
regress logwage educ potexper ability mothered fathered siblings brknhome
//进行White检验
estat imtest, white
//进行BP检验
estat hettest
//进行Godfrey (1988)拉格检验 
//R语言：
//library(lmtest)
//data <- read.csv("C:/Users/ASUS/Desktop/Econometrics/Koop-Tobias(1).csv")
//model <- lm(LOGWAGE ~ EDUC +ABILITY +BRKNHOME +FATHERED+ MOTHERED +POTEXPER +SIBLINGS,data //= data)
//language_multiplier <- lrtest(model)
//异方差稳健的标准误回归
regress logwage educ potexper ability mothered fathered siblings brknhome,robust
//预测值
//margins, at(brknhome = 0 educ=mean(educ)  potexper = mean(potexper) ability= mean(ability) mothered=mean(mothered) fathered=mean(fathered)  siblings=mean(siblings)) 
margins, at(brknhome = 0 educ=12.67604  potexper = 8.362688  ability= 0.052374 mothered=11.4719 fathered=11.70925  siblings=3.156203) 