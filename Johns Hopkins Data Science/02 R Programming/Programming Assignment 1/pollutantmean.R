# Programming Assignment 1 Air Pollution
setwd("C:/Users/ychang/Desktop/Other/Johns-Hopkins-Data-Science/Coursera-Data-Science/02-R Programming/Programming Assignment 1")

# Part 1
pollutantmean <- function(directory, pollutant, id = 1:332){
    directory <- list.files(pattern = "*")
    datname <- c(list.files(path=directory, full.names = T))
    poldata <- data.frame()
    
    for (i in id){
        poldata <- rbind(poldata, read.csv(datname[i], header=T))
    } 
    
    if(pollutant == "sulfate"){
      print(mean(poldata$sulfate, na.rm = T))   
    }
    
    if(pollutant == "nitrate"){
      print(mean(poldata$nitrate, na.rm = T))
    }
    
}

# Demo
# pollutantmean("specdata", "sulfate", 1:10)
# pollutantmean("specdata", "nitrate", 70:72)
# pollutantmean("specdata", "nitrate", 23)

