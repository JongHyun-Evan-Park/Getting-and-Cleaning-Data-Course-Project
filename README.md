# Getting-and-Cleaning-Data-Course-Project

# First I merged the training and the test sets to create one data set.
# To do so, I read in each dataset that needs to be merged by read.table function  (test data, train data, labels of each features measured)
# Then I managed to provide the common key from the yet to be combined datasets that links each other with grepl function (dplyr package)
# Using the keys, I created a big chunk of dataset that includes all of the datasets provided
# I simply used aggregate function to create a second, independant tidy set that shows the mean of each variables according to each subject and the activities they have executed. 


