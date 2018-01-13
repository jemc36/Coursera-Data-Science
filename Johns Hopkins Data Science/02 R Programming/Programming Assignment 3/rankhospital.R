# Programming Assignment 3 
setwd("C:/Users/ychang/Desktop/Other/GitHub/Coursera/Johns Hopkins Data Science/02 R Programming/Programming Assignment 3")
outcare <- read.csv("outcome-of-care-measures.csv", head=T, colClasses="character")

# convert to numeric values for comparing outcome: heart attack, heart failure, or pneumonia
cols <- c(11,17,23)
outcare[, cols] <- apply(outcare[, cols], 2, function(x) as.numeric(as.character(x)))


# 3. Ranking gospitals by outcome in a state
rankhospital <- function(state, outcome, num="best"){
  # Read outcome data
  bestout <- outcare[, c(2,7,11,17,23)] 
  
  ## Check that state and outcome are valid
  statedata <- unique(c(bestout[, 2]))
  staterep <- rep(state, length(statedata))
  outcomedata <- c("heart attack", "heart failure", "pneumonia")
  outcomerep <- rep(outcome, length(outcomedata))
  
  if (sum(staterep == statedata)==1 & sum(outcomerep == outcomedata)==1) {
    
    ## Return hospital name in that state with lowest 30-day death rate
    splitstate <- split(bestout, bestout$State)
    onestate <- splitstate[[state]]
    
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
    if(num <= as.numeric(numtype[3])) {hospnam <-sortstate[which(sortstate[, 6]==num), 1]
    } else if(num==numtype[1]) {hospnam <-sortstate[which.min(sortstate[, 6]),1]
    } else if(num==numtype[2]) {hospnam <-sortstate[which.max(sortstate[, 6]),1]
    } else if(num > as.numeric(numtype[3])) {hospnam <- "NA"
    }
    
    return(hospnam)
    
  } else if(sum(staterep == statedata)==1 & sum(outcomerep == outcomedata)==0){
    stop("invalid outcome")  
  } else if(sum(staterep == statedata)==0 & sum(outcomerep == outcomedata)==1){
    stop("invalid state")
  } else{
    stop("invalid state, invalid outcome")
  }
}

# Demo
# rankhospital("TX", "heart failure", 4)
# rankhospital("MD", "heart attack", "worst")
# rankhospital("MN", "heart attack", 5000)


