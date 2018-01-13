# Programming Assignment 3 
setwd("C:/Users/ychang/Desktop/Other/GitHub/Coursera/Johns Hopkins Data Science/02 R Programming/Programming Assignment 3")
outcare <- read.csv("outcome-of-care-measures.csv", head=T, colClasses="character")
head(outcare)
ncol(outcare)
names(outcare)

# 1. Plot the 30-day mortality rates for heart attack
# convert to numeric for histogram
outcare[, 11] <- as.numeric(outcare[, 11])
hist(outcare[, 11])

## convert to numeric values for comparing outcome: heart attack, heart failure, or pneumonia
cols <- c(11,17,23)
outcare[, cols] <- apply(outcare[, cols], 2, function(x) as.numeric(as.character(x)))


# 2. Finding the best hospital in a state
best <- function(state, outcome){

## Read outcome data
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
          lowha <- min(onestate[, 3], na.rm=T)
          hospnam <- onestate[which(onestate[, 3] == lowha), 1]
        
        } else if (outcome == outcomedata[2]){
          lowhf <- min(onestate[, 4], na.rm=T)
          hospnam <- onestate[which(onestate[, 4] == lowhf), 1]
        } else {
          lowp <- min(onestate[, 5], na.rm=T)
          hospnam <- onestate[which(onestate[, 5] == lowp), 1]
        }

  ## alphabetical order when the death rate is the same      
      if(length(hospnam)>1){
          sorthos <- sort(hospnam)
          return(sorthos[1])
      } else return(hospnam)

        
    } else if(sum(staterep == statedata)==1 & sum(outcomerep == outcomedata)==0){
          stop("invalid outcome")  
    } else if(sum(staterep == statedata)==0 & sum(outcomerep == outcomedata)==1){
          stop("invalid state")
    } else{
          stop("invalid state, invalid outcome")
    }
}



# Demo
# best("TX", "heart attack")
# best("TX", "heart failure")
# best("MD", "heart attack")
# best("MD", "pneumonia")
# best("BB", "heart attack")
# best("NY", "hert attack")
