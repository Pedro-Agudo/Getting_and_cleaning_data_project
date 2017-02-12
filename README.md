# Getting_and_cleaning_data_project
This repository includes data sets and documentation about the Getting and Cleaning Data Course Project at Coursera

The original raw data is here:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


The goals of the project are:

create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


This repository includes the following files:

- run_analysis.R  : This is the R script that tidy up the raw data. This code includes description of the sentences.
- dataset_tidy.csv: semi-colon separated csv file with the tidy data set
- subset_tidy     : semi-colon separated csv subset from the tidy dataset including only mean and standard deviation measurements.
- subset_mean.csv : semi-colon separated csv with the average of each measurement grouped by activity and subject.
- README.md       : this file
- CodeBook.md     : code book of all variables included in the subset_tidy
