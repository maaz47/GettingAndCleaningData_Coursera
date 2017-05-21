setwd("C://Users//maaz//Desktop//R//GetnCleanData Week 4//DataSet//UCI HAR Dataset")
xTest <- read.table("test//X_test.txt")
yTest <- read.table("test//Y_test.txt")
subjectTest <- read.table("test//subject_test.txt")

xTrain <- read.table("train//X_train.txt")
yTrain <- read.table("train//Y_train.txt")
subjectTrain <- read.table("train//subject_train.txt")

features <- read.table("features.txt")
activity <- read.table("activity_labels.txt")

X <- rbind(xTest,xTrain)
y <- rbind(yTest,yTrain)
subject <- rbind(subjectTest,subjectTrain) 

index<-grep("mean\\(\\)|std\\(\\)", features[,2])
X <- X[,index]

Y <- activity[y[,1],2]

names <- features[index,2]
names(X) <- names
names(subject) <- "SubjectId"
names(Y) <- "Activity"

library(dplyr)
CleanedData <- cbind(subject,Y,X)
head(CleanedData[,c(1:4)])
CleanedData<-rename(CleanedData,Activity = Y)

CleanedData <- data.table(CleanedData)
TidyData <- CleanedData[, lapply(.SD, mean), by = 'SubjectId,Activity']

write.table(TidyData, file = "Tidy.txt", row.names = FALSE)

head(TidyData[,c(1:4)])


