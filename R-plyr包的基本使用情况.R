data(tips,package = "reshape2")#从reshape2中调用tip的数据

library(plyr)#导入plyr包
head(tips)#查看一下tips的表格
aggregate(x=tips$tip,
          by=list(tips$sex),
          FUN=mean)#从这个tips的表格中，找到小费这一栏，
#然后再找到性别，不同性别给的不同的小费的数目

#但是对于plyr包来说，其中ddply的函数也可以很好的解决这个问题

ddply(.data = tips,
      .variables = "sex",
      .fun = function(x){
        mean(x$tip)
      })#数据从tips导入，变量是性别，用的函数是计算tip。

#如果是需要计算相对值的话，ddply是很好算的，aggregate有一定的局限性

#可以先定义一个计算相对值的函数
ratio_function <- function(x){
  sum(x$tip)/sum(x$total_bill)}
ddply(tips,.(sex),ratio_function)


#接下来是adply的一个应用例子，iris是R包自带的一个鸢尾花的数据，
#包含150种鸢尾花的信息，每50种取自三个鸢尾花种之一（setosa,versicolour或virginica)。
#每个花的特征用下面的5种属性描述萼片长度(Sepal.Length)、萼片宽度(Sepal.Width)、花瓣长度(Petal.Length)、花瓣宽度(Petal.Width)、类(Species)。

data1 <- as.matrix(iris[,-5])
result1 <- adply(.data = data1,
                 .margins=2, # 2表示按列来分组，1表示按行来分组
                 .fun = function(x){
                   each(max,min,median,sd)(x)#each line caculate max min....
                 })
result1



#接下来是应用了ldply的函数例子,用到的是前面的iris数据集，对其中的sepal.length和width做回归分析
model <- function(x){ lm(Sepal.Length ~ Sepal.Width, data = x)}
#这一步就是创建一个函数，进行回归分析，用DLply进行分析
result2 <- dlply(.data = iris,
                 .variables = "Species",
                 .fun = model)

result3 <- ldply(.data= result2,
                 .fun = coef)



#plyr包的一些其他函数，比如说each函数，可以将其他函数进行打包
x <- rnorm(10)
each(max,min,sd)(x)
x


colwise(mean,is.numeric)(iris)


#案例分析
load('data/Knicks.rda')
head(data)
#求每个赛季的胜率
ddply(data, .(season),
      function(x) sum(x$win == "w")/length(x$win))


#求每个赛季的客场胜率

daply(data,.(season,visiting),function(x) sum(x$win == "1")/length(x$win))
#这个结果会出来一个矩阵

#算每个赛季的平均得分

ddply(data,.(season), function(x) each(mean)(x$points))
ddply(data,.(season), function(x) colwise(mean,"points")(x))

#算每个赛季的本方和对手的得分
ddply(data, .(season),
      function(x) colwise(mean,c("pionts","opp"))(x))

