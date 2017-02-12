# Code Book for tidy subset


## Information about the raw data:

The raw data includes a number of text files with the data of a study about  human activity recorded using smartphones.



The study evaluates 6 activities for 30 subjects. 


The activities are:
1. WALKING
2. WALKING_UPSTAIRS
3. WALKING_DOWNSTAIRS
4. SITTING
5. STANDING
6. LAYING



There are a number of text files:


- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

- ' subject_train.txt': Each row identifies the subject who performed the activity for each window sample. 


=================================================================================================================


### PART I: get the raw data

The first part of the code (run_analysis.R) extracts raw data. 

### PART II: Tidying data and assign labels and names

In this part we modify the train set and assign names to variables. Then we proceed the same way with the test set.
Finally, we merge both datasets, train and test. 

2. Working the data: tidying train and test sets.

2. a. TRAIN SET:
2. a. 1. get the files. subject, labels and train
2. a. 2. merge data: subjects, labels and features
2. a. 3. Assign names to features and labels 

2. b. TEST SET:
2. b. 1. get the files
2. b. 2. merge data: subjects, labels and features
2. b. 3. Assign names to features and labels

2. c. merge TRAIN and TEST SETS

The result is a data set named dataset_tidy. This dataset is exported to csv and zipped: "dataset_tidy.zip" is in this repo. 
To get the names of the variables, we generate a data frame from features.txt, and then process the variable V2, which contains the names:

The processing includes the substitution of some characters:

- "()" for ""
- "-" for "_"_
- "," for "_"_
- "(" for "_"_
- ")" for ""



Variables are:
- subject: this is an integer variable. Later we transform it to factor in order to summarize the data and average the rest of the variables. 
The next variables are numeric:
- tBodyAcc_mean_X
- tBodyAcc_mean_Y
- tBodyAcc_mean_Z
- tGravityAcc_mean_X
- tGravityAcc_mean_Y
- tGravityAcc_mean_Z
- tBodyAccJerk_mean_X
- tBodyAccJerk_mean_Y
- tBodyAccJerk_mean_Z
- tBodyGyro_mean_X
- tBodyGyro_mean_Y
- tBodyGyro_mean_Z
- tBodyGyroJerk_mean_X
- tBodyGyroJerk_mean_Y
- tBodyGyroJerk_mean_Z
- tBodyAccMag_mean
- tGravityAccMag_mean
- tBodyAccJerkMag_mean
- tBodyGyroMag_mean
- tBodyGyroJerkMag_mean
- fBodyAcc_mean_X
- fBodyAcc_mean_Y
- fBodyAcc_mean_Z
- fBodyAcc_meanFreq_X
- fBodyAcc_meanFreq_Y
- fBodyAcc_meanFreq_Z
- fBodyAccJerk_mean_X
- fBodyAccJerk_mean_Y
- fBodyAccJerk_mean_Z
- fBodyAccJerk_meanFreq_X
- fBodyAccJerk_meanFreq_Y
- fBodyAccJerk_meanFreq_Z
- fBodyGyro_mean_X
- fBodyGyro_mean_Y
- fBodyGyro_mean_Z
- fBodyGyro_meanFreq_X
- fBodyGyro_meanFreq_Y
- fBodyGyro_meanFreq_Z
- fBodyAccMag_mean
- fBodyAccMag_meanFreq
- fBodyBodyAccJerkMag_mean
- fBodyBodyAccJerkMag_meanFreq
- fBodyBodyGyroMag_mean
- fBodyBodyGyroMag_meanFreq
- fBodyBodyGyroJerkMag_mean
- fBodyBodyGyroJerkMag_meanFreq:
- tBodyAcc_std_X
- tBodyAcc_std_Y
- tBodyAcc_std_Z
- tGravityAcc_std_X
- tGravityAcc_std_Y
- tGravityAcc_std_Z
- tBodyAccJerk_std_X
- tBodyAccJerk_std_Y
- tBodyAccJerk_std_Z
- tBodyGyro_std_X
- tBodyGyro_std_Y
- tBodyGyro_std_Z
- tBodyGyroJerk_std_X
- tBodyGyroJerk_std_Y
- tBodyGyroJerk_std_Z
- tBodyAccMag_std
- tGravityAccMag_std
- tBodyAccJerkMag_std
- tBodyGyroMag_std
- tBodyGyroJerkMag_std
- fBodyAcc_std_X
- fBodyAcc_std_Y
- fBodyAcc_std_Z
- fBodyAccJerk_std_X
- fBodyAccJerk_std_Y
- fBodyAccJerk_std_Z
- fBodyGyro_std_X
- fBodyGyro_std_Y
- fBodyGyro_std_Z
- fBodyAccMag_std
- fBodyBodyAccJerkMag_std
- fBodyBodyGyroMag_std
- fBodyBodyGyroJerkMag_std
The next variable is a factor variable:
- activity




### PART III:  Extracts only the measurements on the mean and standard deviation for each measurement

Here we extract all variable names containing "mean" or "std", and create a subset with this variables. 

The subset is called "data_subset" and corresponds with the "data_subset.csv" file of this repo.


### PART IV:  Uses descriptive activity names to name the activities in the data set

in this part we include the activity names to the data set.

### PART V:  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

In this part we aggregate and summarize the data using aggregate function. 

The result is exported to csv, separated with semi-colon, and is in this repo under the name "subset_mean.csv"


