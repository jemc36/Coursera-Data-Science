# Programming Assignment 3 
setwd("C:/Users/ychang/Desktop/Other/GitHub/Coursera/Johns Hopkins Data Science/02 R Programming/Programming Assignment 3")
outcome <- read.csv("outcome-of-care-measures.csv", head=T, colClasses="character")

source("best.R")
source("rankhospital.R")
source("rankall.R")

# 1. "MUSC MEDICAL CENTER"
best("SC", "heart attack")

# 2. "MAIMONIDES MEDICAL CENTER"
best("NY", "pneumonia")

# 3. "YUKON KUSKOKWIM DELTA REG HOSPITAL" 
best("AK", "pneumonia")

# 4. "WAYNE MEMORIAL HOSPITAL"
rankhospital("NC", "heart attack", "worst")

# 5. "YAKIMA VALLEY MEMORIAL HOSPITAL"
rankhospital("WA", "heart attack", 7)

# 6. "SETON SMITHVILLE REGIONAL HOSPITAL"
rankhospital("TX", "pneumonia", 10)

# 7. "BELLEVUE HOSPITAL CENTER"
rankhospital("NY", "heart attack", 7)

# 8. "CASTLE MEDICAL CENTER"
r <- rankall("heart attack", 4)
as.character(subset(r, state == "HI")$hospital)

# 9. "BERGEN REGIONAL MEDICAL CENTER"
r <- rankall("pneumonia", "worst")
as.character(subset(r, state == "NJ")$hospital)

# 10. "RENOWN SOUTH MEADOWS MEDICAL CENTER"
r <- rankall("heart failure", 10)
as.character(subset(r, state == "NV")$hospital)

