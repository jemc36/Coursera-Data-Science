# Programming Assignment 3 
setwd("C:/Users/ychang/Desktop/Other/GitHub/Coursera/Johns Hopkins Data Science/02 R Programming/Programming Assignment 3")
outcare <- read.csv("outcome-of-care-measures.csv", head=T, colClasses="character")

# convert to numeric values for comparing outcome: heart attack, heart failure, or pneumonia
cols <- c(11,17,23)
outcare[, cols] <- apply(outcare[, cols], 2, function(x) as.numeric(as.character(x)))

# 4. Ranking hospitlas in all states
rankall <- function(outcome, num="best"){
  # Read outcome data
  bestout <- outcare[, c(2,7,11,17,23)] 
  
  ## Check that outcome is valid
  outcomedata <- c("heart attack", "heart failure", "pneumonia")
  outcomerep <- rep(outcome, length(outcomedata))
  
  if (sum(outcomerep == outcomedata)==1) {
    
  ## For each state, find the hospital of the given rank
  ## Return a data frame with the hospital names and the (abbreviated) state name

    hospnamdata <- data.frame()
    splitstate <- split(bestout, bestout$State)
  
    for(i in 1:length(splitstate)){  
    onestate <- splitstate[[i]]
    
    if(outcome == outcomedata[1]){
      nnastate <- onestate[!is.na(onestate[,3]), ]
      sortstate <- nnastate[order(nnastate[,3], nnastate[,1]), ]
      Rank <- seq(1,length(sortstate[,3]), by=1)
      
    } else if (outcome == outcomedata[2]){
      nnastate <- onestate[!is.na(onestate[,4]), ]
      sortstate <- nnastate[order(nnastate[,4], nnastate[,1]), ]
      Rank <- seq(1,length(sortstate[,4]), by=1)
      
    } else {
      nnastate <- onestate[!is.na(onestate[,5]), ]
      sortstate <- nnastate[order(nnastate[,5], nnastate[,1]), ]
      Rank <- seq(1,length(sortstate[,5]), by=1)
      
    }
    
    sortstate$Rank <- Rank  
    numtype <- c("best","worst", as.character(nrow(sortstate)))
    if(num <= as.numeric(numtype[3])) {hospnam <-sortstate[which(sortstate[, 6]==num), c(1,2)]
    } else if(num==numtype[1]) {hospnam <-sortstate[which.min(sortstate[, 6]), c(1,2)]
    } else if(num==numtype[2]) {hospnam <-sortstate[which.max(sortstate[, 6]), c(1,2)]
    } else if(num > as.numeric(numtype[3])) {hospnam <- data.frame("NA", sortstate[1,2])
    }
    
    rownames(hospnam) <- NULL
    colnames(hospnam)[1] <- "hospital"
    colnames(hospnam)[2] <- "state"
    hospnamdata <- rbind(hospnamdata, hospnam)
    
   }
    
    return(hospnamdata)
    
  } else {
    stop("invalid outcome")  
  } 
}


# Demo
# head(rankall("heart attack", 20), 10)
# tail(rankall("pneumonia", "worst"), 3)
# tail(rankall("heart failure"), 10)

# method 2: lapply & do.call
