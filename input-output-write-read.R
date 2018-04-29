x <- readline()
username #这种情况readline只能输入一次

x <- scan()
3.1
2.3
....#这种情况支持多次输入

output <- file("output.txt")
cat(1:100,sep="\t",file=output)
close(output)
#这个代码会在当前的工作目录下创建一个output.txt的文档，里面是1-100以制表符去分开

output <- file("output.txt")
input <- scan(file = output)#把output当做是input的输入
close(input)#关闭input
head(input)#可以看前面几行()



#字符串的读取
output <- file("output.txt")
writeLines(as.character(1:12),con=output)
input <- readLines(output)
input

##数据表格的读取，用到的是本地的数据iris数据。需要先把它写入到本地的数据中~
head(iris)#chakan
write.table(iris,file="iris.csv",sep = ",")#write down csv document use iris
data <- read.table(file="iris.csv",sep = "\t")#write into local document, use tab divide
head(data)#watch

