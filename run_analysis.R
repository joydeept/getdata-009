### Getting and Cleaing Data Course Project
###
###
### Instructions
###
###You should create one R script called run_analysis.R that does the following. 
###1.Merges the training and the test sets to create one data set.
###2.Extracts only the measurements on the mean and standard deviation for each measurement. 
###3.Uses descriptive activity names to name the activities in the data set
###4.Appropriately labels the data set with descriptive variable names. 
###5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
###
###
###
### Understanding the data:
### 
### There are two data sets - training and test.
###
### Each data set contains observations from 21 subjects that performed 6 activities. 
###   561 different measurements are collected in each record. Names of these measurements are in features.txt.
###   Subjects are identified by numbers from 1-30 in subject_*.txt
###   Activities are identified by numbers from 1-6 in Y_*.txt.
###   All observations are in X_*.txt.
###   
###   Common to both sets:
###   'features.txt': List of all features.
###   'activity_labels.txt': Links the class labels with their activity name.
###
###   Training set:
###   'train/X_train.txt': Training set. 'data.frame':  7352 obs. of  561 variables
###   'train/y_train.txt': Training labels. 'data.frame':  7352 obs. of  1 variable:
###   'train/subject_train.txt' 'data.frame':  7352 obs. of  1 variable:
###         Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
### 
###   Test set: 
###   'test/X_test.txt': Training set. 'data.frame':  2947 obs. of  561 variables
###   'test/y_test.txt': Training labels. 'data.frame':  2947 obs. of  1 variable:
###   'test/subject_test.txt' 'data.frame':  2947 obs. of  1 variable:
###         Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
###

tidy_data <- function () {
  
  
  ## Assuming working directory is "UCI HAR Dataset". I am not checking for file existence.
  
  #####
  ## Read domain files - features, activities
  #####
  
  features <- read.table("features.txt")
  names(features) <- c("FeatureIndex", "FeatureName")
  ## Get column indexes of mean and std deviation measurements
  ## I am using a regex to look for -mean(), -mean()-X, -mean()-Y, -mean()-Z at the end of the feature name string.
  ## Similarly for std deviation.
  means_col <- grep("-mean\\(\\)-*[XYZ]*$", features[,2])
  stddev_col <- grep("-std\\(\\)-*[XYZ]*$", features[,2])
  desired_col <- c(means_col, stddev_col)
  desired_features <- as.vector(features$FeatureName[desired_col]) 
  
  activity_names <- read.table("activity_labels.txt")
  names(activity_names) <- c("ActivityIndex", "ActivityName")
  
  #####
  ## Read measurement set and extract only desired columns
  ## Read subjects and activity labels
  ## Combine the three to form the training set data frame
  #####
  get_dataset <- function (file_measurement, file_subjects, file_labels) {

    ## Read measurements
    measurements <- read.table(file_measurement)[,desired_col] 
    ## QQQ: Is there a way to directly read only the specified column numbers?
    ## The above still reads the whole training set in memory and then extracts the column.
    ## It would be great for the read function to only load desired columns in memory.
    ## Add feature names as column names
    
    ## Read subjects
    subjects <- read.table(file_subjects)
    
    ## Read activity labels
    labels <- read.table(file_labels)
    ## Get activity names from labels
    activities <- lapply(labels, function(x) activity_names[x,2])
    
    ## Combine subject, activities and measurements
    cbind(subjects, activities, measurements)
  }

  
  #####
  ## Get the combined training and test data set
  #####
  train_set <- get_dataset("train/X_train.txt", "train/subject_train.txt", "train/Y_train.txt")
  test_set <- get_dataset("test/X_test.txt", "test/subject_test.txt", "test/Y_test.txt")
  data_set <- rbind(train_set, test_set)
  ## Name the columns in the combined data set
  names(data_set) <- c("Subject", "Activity", desired_features)
  
 
  
  #####
  ### Step 5. Second independent tidy set.
  ###
  ### I want the final tidy set to look like:
  ###
  ### SUBJECT   ACTIVITY    MEASUREMENT   MEAN    STD_DEV
  ###
  ###
  ###
  
  ### I just finished learning DPLYR and TIDYR, so I am going to use these packages for the rest of program.
  
  library(dplyr)
  library(tidyr)
  
  data_set %>%
    gather(Measurement, Value, -(c(Subject, Activity))) %>%
    group_by(Subject, Activity, Measurement) %>%
    summarize(Mean = mean(Value), StdDev = sd(Value))
  
  ### !!! So easy to do it this way!
  ###
  ### I am sure I could have used select(), filter(), etc. earlier in the program to get the initial data set more efficiently.

}



