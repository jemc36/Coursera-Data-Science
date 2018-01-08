# Programming Assignment 1 Air Pollution
setwd("C:/Users/ychang/Desktop/Other/Johns-Hopkins-Data-Science/Coursera-Data-Science/02-R Programming/Programming Assignment 1")

# Part 2
complete <- function(directory, id = 1:332){
  directory <- list.files(pattern = "*")
  datname <- c(list.files(path=directory, full.names = T))
  polall <- data.frame()
  
  for (i in id){
    poldata <- read.csv(datname[i], header=T)
    nobs <- nrow(poldata[complete.cases(poldata), ])
    id <- poldata$ID[1]
    
    polall <- rbind(polall, data.frame(id, nobs))
  } 

  print(polall)
  
}

# Demo
# complete("specdata", 1)
# complete("specdata", c(2, 4, 8, 10, 12))
# complete("specdata", 30:25)
# complete("specdata", 3)
