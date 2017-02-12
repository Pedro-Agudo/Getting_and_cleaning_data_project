##############################################################################
#
# This code is for Getting and Cleaning Data Course Project 
#
##############################################################################



##############################################################################
#
# PART I: get the raw data
#
##############################################################################

# 1. Setting directory and files


#1.a Check if working directory exists and create one
if (!file.exists("run_analysis")) {
    dir.create("run_analysis")
}


setwd("./run_analysis")

#1.b download and unzip files 


file_url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(file_url,destfile = "dataset.zip", method="curl")


unzip("dataset.zip")

#remove unnecessary variables
 rm(file_url)



##############################################################################
#
# PART II, IV: tidying the data and assign labels and names.
#
##############################################################################





# INDEX:

# 2. Working the data: tidying train and test sets.
# 2a. TRAIN SET:
# 2a_1. get the files
# 2a_2. merge data: subjects, labels and features
# 2a_3. Assign names to features and labels 

# 2b. TEST SET:
# 2b_1. get the files
# 2b_2. merge data: subjects, labels and features
# 2b_3. Assign names to features and labels

# 2c. merge TRAIN and TEST SETS


#2a.1--------------------------------------------------------------------
#there is a UCI HAT Dataset directory. Now we get txt files and
#convert to data frames
list.files("./UCI HAR Dataset/train")
 

#get subject data set 
train_subject <- read.table("./UCI HAR Dataset/train/subject_train.txt",
                            sep=" ")

#get activity types
train_labels<- read.table("./UCI HAR Dataset/train/y_train.txt",
                         sep=" ")

#first obtain a sample of X_train, it's a large dataset
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt",
                      header = FALSE,
                      nrows=5
                      )

#obtain the class for every column
classes<-sapply(train_x,class)

#now we can specify the class of every column, making it easier for
#the read.table function
train_x <- read.table("./UCI HAR Dataset/train/X_train.txt",
                      header = FALSE,
                      colClasses = classes)

#2a.2--------------------------------------------------------------------
#merge train, subjects and names
train_set<-cbind(train_subject,train_labels,train_x)

#remove data frames and variables from memory
rm(train_labels,train_subject, train_x, classes)

#2a.3 now that we have the train dataset, we're gonna get names for columns

#features list names
features<- read.table("./UCI HAR Dataset/features.txt",
                         sep=" ")

#now we're gonna tidy up the names:

features$V2<-gsub("\\()","", features$V2) 
features$V2<-gsub("-","_", features$V2)
features$V2<-gsub(",","_", features$V2)
features$V2<-gsub("\\(","_", features$V2)
features$V2<-gsub("\\)","", features$V2)

#we create a vector with names for the first 2 columns "subject" and labels"
names_part_1<-as.data.frame(c("subject","labels"),stringsAsFactors = FALSE)
names(names_part_1)<-"name"
names_part_2<-as.data.frame(features$V2,stringsAsFactors = FALSE)
names(names_part_2)<-"name"
#next is a data frame with the names of the columns of train_set
names_set<-rbind(names_part_1,names_part_2)
#remove data frames:
rm(features, names_part_1,names_part_2)

names(train_set)<-as.character(names_set$name)



###############################################################################


#2b.1--------------------------------------------------------------------
#there is a UCI HAT Dataset directory. Now we get txt files and
#convert to data frames
list.files("./UCI HAR Dataset/test")


test_subject <- read.table("./UCI HAR Dataset/test/subject_test.txt",
                            sep=" ")

test_labels<- read.table("./UCI HAR Dataset/test/y_test.txt",
                          sep=" ")

#first obtain a sample of X_test, it's a large dataset
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt",
                      header = FALSE,
                      nrows=5
)

#obtain the class for every column
classes<-sapply(test_x,class)

#now we can specify the class of every column, making it easier for
#the read.table function
test_x <- read.table("./UCI HAR Dataset/test/X_test.txt",
                      header = FALSE,
                      colClasses = classes)

#2a.2--------------------------------------------------------------------
#merge test, subjects and names
test_set<-cbind(test_subject,test_labels,test_x)

#remove data frames and variables from memory
rm(test_labels,test_subject, test_x, classes)

#apply names created for train set also to test set


names(test_set)<-as.character(names_set$name)


##########################################################################

#2c. MERGE


dataset<-rbind(train_set,test_set)
rm(train_set,test_set)

# Export tidy data set


write.csv(dataset, "dataset_tidy.csv",
          sep = ";", 
          col.names = TRUE,
          row.names = FALSE
          )


#now we compress to zip file because GitHub doesn't permit files bigger than 
# 25Mb.
zip("dataset_tidy.zip","dataset_tidy.csv")


##############################################################################
#
# PART III:  Extracts only the measurements on the mean and standard deviation 
#           for each measurement
#
##############################################################################

#extract variable names containing "mean" or "std"
names_mean<-names_set[grep("mean",names_set$name),]
names_std<-names_set[grep("std",names_set$name),]

names_subset<-c("subject","labels",names_mean,names_std)
#remove unnecessary variables
rm(names_mean,names_std)

#get subset from dataset where columns contain "mean" or "std"
data_subset<-dataset[,names_subset]

rm(names_set,names_subset)

##############################################################################
#
# PART V:  Uses descriptive activity names to name the activities in the 
#            data set
#
##############################################################################


str(data_subset)

#get activity names
activity <- read.table("./UCI HAR Dataset/activity_labels.txt",
                           sep=" ")
names(activity)<-c("labels","activity")

#join activity name to data set
data_subset<-merge(x=data_subset,y=activity,by.x="labels", by.y="labels")

#remove old "labels" column
data_subset<-subset(data_subset,select=-labels)

rm(activity)


# Esport tidy data set


write.csv(data_subset, "subset_tidy.csv",
          sep = ";", 
          col.names = TRUE,
          row.names = FALSE
)


##############################################################################
#
# PART V:  From the data set in step 4, creates a second, independent tidy 
# data set with the average of each variable for each activity and each 
# subject.
#
##############################################################################

library(plyr)

#aggregate  
data_subset_summary<-aggregate(
    data_subset[2:80], #apply aggregation to subset excluding grouping variables
    by=list(
           subject=as.factor(data_subset$subject), 
           activity=as.factor(data_subset$activity)
           ), 
    FUN=mean)
#data_subset_summary contains averages of all variables grouped by subject
#and activity.


#write subset to csv:
write.csv(data_subset_summary, "subset_mean.csv",
          sep = ";", 
          col.names = TRUE,
          row.names = FALSE
)



##############################################################################

