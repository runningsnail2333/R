x <- c(98,83,65,72,79,76,75,94,91,77,63,86,89,69,75,78,91,70,73,65,74,76,NA) 
pinjunshu <- mean(x)
print(pinjunsh)
zhongshu<- median(x,na.rm = TRUE)
print(zhongshu)

getmode <- function(v) {
  + uniqv <- unique(v)
  + uniqv[which.max(tabulate(match(v,uniqv)))]
}

v <- c(1,2,2,2,2,3,4,5,6)
result <- getmode(v)