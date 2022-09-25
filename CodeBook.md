# Getting and cleanning data project Code Book

# Steps to createthe tidydate.txt file

1- Download and extract the data from 

	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
	
	Data is extrated in directory "./UCI HAR Dataset/"
	
	The data is from UCI Machine learning repository and contains data for Human Activity Recognition Using Smartphones
	
2- Execute the run_analysis.R scrpitp

	This script will read the test and train datasets, will select the the meand and std variables and will calculate the mead 
	for all columns in the selected data frame. 
	
	Significant names are assigned to all columns at the moment of readling the files, or from the "featuers.txt" file included
	with the information
	
3- Final result is saved in file "tidydata.txt"

Variables in final data set are:

subject_id : Integer		Id of subject performing the device testing
activity_id = Integer		Id for the type of activity	
activity_name = Character	Name for each activity

Attribute Information:
For each record in the dataset it is provided the mean over the mean and std of 561 observations of the following variables grouped by subject and activity.
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- Its activity labe and name.
- An identifier of the subject who carried out the experiment.

Citation Request:
Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. 
A Public Domain Dataset for Human Activity Recognition Using Smartphones. 
21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, 
ESANN 2013. Bruges, Belgium 24-26 April 2013.
