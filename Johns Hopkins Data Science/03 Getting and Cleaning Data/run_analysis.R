# Getting and Cleaning Data Course Project
install.packages("dplyr")
library(dplyr)

# 1. Merges the training and the test sets to create one data set; ignores the "Inertial Signals" folder for now
readdata <- function(folder){
    ordir <<- "C:/Users/ychang/Desktop/Other/Johns Hopkins Data Science/Getting and Cleaning Data/data/UCI HAR Dataset/"
    dir <- paste(ordir, folder, sep="")
    setwd(dir)
    mydata <- 0
    filelist <- list.files(pattern = ".*.txt")
    datalist <- lapply(filelist, function(x)read.table(x, header=F, sep=""))
    mydata <<- do.call("cbind", datalist)
    print(filelist)
}

readdata("test")
test <- mydata
readdata("train")
train <- mydata

## the order of the files: subject, X, y
alldata <- rbind(test, train)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
setwd(ordir)
features <- read.table("features.txt") %>%
    mutate(var=paste("V", V1, sep=""))

## subsets the values with "mean" or "std"
usefeatures <- features[grep("mean|std", features$V2),3]

xdata <- alldata[, 2:562] %>%
  select(usefeatures)

meansd <- cbind(alldata[,1], alldata[,563], xdata)

# 3. Uses descriptive activity names to name the activities in the data set
## Merge y_test/y_train with activity by group
activity <- read.table("activity_labels.txt")
colnames(activity)[1:2] <- c("group","activity")

labeldata <- merge(activity, meansd, by.x="group", by.y="y") %>%
    select(-group)

# 4. Appropriately labels the data set with descriptive variable names.
varname <- as.character(features[grep("mean|std", features$V2),2])

## Refine variable names: letter, number, point
varname <- gsub("-"=".", varname)
varname <- gsub("^f","freq", varname)
varname <- gsub("^t","time", varname)
varname <- gsub("\\(\\)", "", varname)

colnames(labeldata)[3:81] <- varname

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
finaltidy <- labeldata %>%
    group_by(subject,activity) %>%
    summarise_all(funs(mean))

## output tidydata
write.csv(finaltidy, file = "tidydata.csv",row.names=FALSE)
