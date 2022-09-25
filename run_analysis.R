# Getting and Cleaning data Project

# R version 4.2.1 (2022-06-23 ucrt) -- "Funny-Looking Kid"
# Copyright (C) 2022 The R Foundation for Statistical Computing
# Platform: x86_64-w64-mingw32/x64 (64-bit)

# M. Bravo

# One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
  
#   http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

# Here are the data for the project:
  
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  

# You should create one R script called run_analysis.R that does the following. 

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation 
#    for each measurement. 
# 3. Uses descriptive activity names to name the activities in the 
#    data set
# 4. Appropriately labels the data set with descriptive variable 
#    names. 

# From the data set in step 4, creates a second, independent 
# tidy data set with the average of each variable for each 
# activity and each subject.

library("data.table")
library("dplyr")
library("stringr")

# Read the data file into data frames


testdataX <-data.table::fread("./UCI HAR Dataset/test/X_test.txt",
                              sep=" ", header = FALSE)
testdataY <-data.table::fread("./UCI HAR Dataset/test/y_test.txt",
                              sep=" ", header = FALSE,
                              col.names = c("activity_id"))
testsubject <- data.table::fread("./UCI HAR Dataset/test/subject_test.txt",
                              sep=" ", header = FALSE,
                              col.names = c("subject_id"))

traindataX <-data.table::fread("./UCI HAR Dataset/train/X_train.txt",
                              sep = " ", header = FALSE)
traindataY <-data.table::fread("./UCI HAR Dataset/train/y_train.txt",
                              sep = " ", header = FALSE,
                              col.names = c("activity_id"))
trainsubject <- data.table::fread("./UCI HAR Dataset/train/subject_train.txt",
                              sep = " ", header = FALSE,
                              col.names = c("subject_id"))
# read activity labels

activitylabels <- data.table::fread("./UCI HAR Dataset/activity_labels.txt",
                        sep = " ", header = FALSE,
                        col.names = c("activity_id","activity_name"))

# assign variable names to data tables

featuresdata <- data.table::fread("./UCI HAR Dataset/features.txt", 
                        sep=" ", header = FALSE, 
                        col.names = c("feature_id", "feature_name"))

colnames( testdataX) <- featuresdata[, feature_name]
colnames( traindataX) <- featuresdata[, feature_name]

# select columns with mean or std in variable name

mean_std_col <- featuresdata[ str_detect( feature_name, "mean\\(") |
                              str_detect( feature_name, "std\\("), 
                              feature_name]
testdataX <- select( testdataX, mean_std_col)
traindataX <- select( traindataX, mean_std_col)

# merge all the tables, first columns, then rows

tidydata <- rbind( cbind( testsubject, testdataY, testdataX),
                   cbind( trainsubject, traindataY, traindataX))

# creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.

td2 <- as.data.frame( apply( tidydata, 2, function(x) 
                        tapply( x, list( tidydata$subject_id, 
                                         tidydata$activity_id ), 
                                mean)
              ))

# assign descriptive activity names

td2 <- merge( td2, activitylabels, 
              by = "activity_id", all.x = TRUE)

write.table( td2, "./UCI HAR Dataset/tidydata.txt")
