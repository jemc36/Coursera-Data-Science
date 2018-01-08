# Programming Assignment 1 Air Pollution
setwd("C:/Users/ychang/Desktop/Other/Johns-Hopkins-Data-Science/Coursera-Data-Science/02-R Programming/Programming Assignment 1")

# Part 3
corr <- function(directory, threshold=0){
    directory <- list.files(pattern = "*")
    datname <- c(list.files(path=directory, full.names = T))
    polall <- data.frame()
    correlall <- c()
  
  for (i in 1:length(datname)){
    poldata <- read.csv(datname[i], header=T)
    poldata <- poldata[complete.cases(poldata), ]
    
      if(nrow(poldata) >= threshold){
         correl <- cor(poldata$sulfate, poldata$nitrate)
         correlall <- c(correlall, correl)
      }
  }
  return(correlall)  
}

# Demo
# cr <- corr("specdata", 150)
# head(cr)
# summary(cr)
# 
# cr <- corr("specdata", 400)
# head(cr)
# summary(cr)
# 
# cr <- corr("specdata", 5000)
# summary(cr)
# length(cr)
# 
# cr <- corr("specdata")
# summary(cr)
# length(cr)

