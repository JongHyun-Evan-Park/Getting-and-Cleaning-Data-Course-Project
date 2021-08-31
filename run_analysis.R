# Getting and Cleaning Data - Course project 
# run_analysis

# 1. Merge the training and the test sets to create one data set.

# 1) Download file and unzip
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists("UCIDATA")){
        dir.create("UCIDATA")
}

download.file(fileUrl, destfile = "UCIDATA/RAWDATA.zip")

unzip(zipfile="./UCIDATA/RAWDATA.zip",exdir="./UCIDATA")

#-----------------------------------------#

# 2) Read in each tables that needs to be merged together

pathdata <- file.path("./UCIDATA","UCI HAR Dataset") # check the list of downloaded files
files <- list.files(pathdata, recursive=TRUE); files

xtrain <- read.table(file.path(pathdata,"train","X_train.txt"), header=FALSE)
ytrain <- read.table(file.path(pathdata,"train","y_train.txt"), header=FALSE)
subject_train = read.table(file.path(pathdata, "train", "subject_train.txt"),header = FALSE)

xtest <- read.table(file.path(pathdata,"test","X_test.txt"),header=FALSE)
ytest <- read.table(file.path(pathdata,"train","X_train.txt"), header=FALSE)
subject_test = read.table(file.path(pathdata, "test", "subject_test.txt"),header = FALSE)

features <- read.table(file.path(pathdata,"features.txt"))
activity <- read.table(file.path(pathdata,"activity_labels.txt"))

str(ytrain)
str(xtrain)
str(subject_train)

#------------------------------------#

# 3) getting ready to merge datasets by setting the common keys         

features[,2]
varname<- features[,2]
colnames(xtrain) <- varname
colnames(ytrain) <- "activityId"
colnames(subject_train) <- "subjectId"

colnames(xtest) <- varname
colnames(ytest) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activity) <- c("activityId","activityType")

#------------------------------------#

# 4) Merge and extract the measurements on the mean and standard deviation

library(dplyr)

mergeTrain <- cbind(ytrain,subject_train,xtrain)
mergeTest <- cbind(ytest,subject_test,xtest)
mergeData <- rbind(mergeTrain,mergeTest)

colnamesFinal <- colnames(mergeData)
colnamesFinal <- grepl("activityId|subjectId|mean..|std..",colnamesFinal)

finalData <- mergeData[,colnamesFinal==TRUE]
finalData %>% merge(activity,by="activityId",all = TRUE)
View(finalData)        

#-------------------------------------#

# 5) creates a second, independent tidy data set with the average of each variable for each activity and each subject.

TidyDataset <- aggregate(. ~subjectId + activityId, finalData, mean)

write.table(TidyDataset,file.path(pathdata,"TidyDatset.txt"), row.name=FALSE)
