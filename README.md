# Getting-and-Cleaning-Data-Course-Project

# 1. Merges the training and the test sets to create one data set.
 
I read in each dataset that needs to be merged with read.table function (test data, train data, activity label data, and the features measured)
cbind function was used to first form a basic structure of the datasets("mergeTrain", "mergeTest")
With colname function the variables of the datasets were labeled with the names provided in the "feature" dataset
By setting "activityId" "subjectId" "varname" as a common key, "mergeTrain" and "mergeTest" data were merged by rbind function into "mergData" dataset

# 2. Extract only the measurements on the mean and standard deviation for each measurement. 

With grepl function of dplyr package, columns that have "mean" and "std" in their variable names were extracted from the "mergeData" dataset ("colnamesFinal")

# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 

The subsetted dataset ("finalData") was then mereged with "activity" data that links the type and the ID of the activity 

# 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
I simply used aggregate function to create a second, independant tidy set that shows the mean of each variables according to each subject and the activities they have executed. 
