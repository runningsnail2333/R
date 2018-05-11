set.seed(1)
x <- seq(1,5,length.out = 100)
noise <- rnorm(n=100, mean = 0, sd=1)
beta0 <- 1
beta1 <- 2
y <- beta0+beta1*x+noise
#前面是生成数据，如果需要生成图表的话直接用PLOT函数

plot(y-x)

#接下来使用线性模型来建模，用的是最小二乘方法lm函数
model <- lm(y~x)
plot(y~x)
abline(model)


#回归估计，线性回归输出结果
summary(model)#可以把model里的结果调出来
model.matrix(model)#调出建模时的矩阵



#回归统计
#判定系数

ybar <- mean(y)
yPred <- model$fitted.values
Rsquared <- sum((yPred-ybar)^2)/sum((y-ybar)^2)
sqrt(sum(model$residuals^2)/98)

#利用模型进行新样本的预测



yConf <- predict(model,interval="confidence")
yPred <- predict(model,interval="prediction")
lines(yConf$lwr~x,col="black",lty=3)
lines(yConf$upr~x,col="black",lty=3)
lines(yPred$lwr~x,col="black",lty=2)
lines(yPred$upr~x,col="black",lty=2)
lines(yPred$fit~x,col="black",lty=1)



#虚拟变量
set.seed(1)
x <- factor(rep(c(0,1),each=30))
y <- c(rnorm(30,0,1),rnorm(30,1,1))
plot(y~x)
model <- lm(y~x)

#扁你变量的数据结构
model.matrix(model)

#虚拟变量回归结果的解释
#回归诊断的第一个方面是检查我们对模型的结构假设是否
#正确，即解释变量和目标变量之间是否有线性关系

set.seed(1)
x <- seq(1,5,length.out=100)
noise <- rnorm(n=100,mean = 0,sd=1)
beta0 <- 1
beta1 <- 2
y <- beta0+beta1*x^2+noise
model <- lm(y~x)
summary(model)
plot(y~x)
abline(model)

#回归诊断，依靠残差来判断模型的结构是否合适
plot(model$residuals-x)
#通过这个图，我们发现可能有一个二次项存在，所以增加二次项诊断

#回归诊断
model2 <- lm(y~x+I(x^2))
summary(model2)
#判断系数增加，二次项系数显著，一次项系数不显著

#剔除一次项之后再次回归

model3 <- update(model2,y~.-x)
summary(model3)

AIC(model,model2,model3)
#数值越小越好

