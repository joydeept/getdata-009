# Readme for run_analysis.R

## Program instructions

Create one R script called run_analysis.R that does the following:
 
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## My understanding of the data

There are two data sets - training and test.

Each data set contains observations from 21 subjects that performed 6 activities. 

* 561 different measurements are collected in each record. 
* Names of these measurements are in features.txt.
* Subjects are identified by numbers from 1-30 in subject_*.txt
* Activities are identified by numbers from 1-6 in Y_*.txt.
* All observations are in X_*.txt.
   
Common to both sets:
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.

Training set:

* 'train/X_train.txt': Training set. 'data.frame':  7352 obs. of  561 variables
* 'train/y_train.txt': Training labels. 'data.frame':  7352 obs. of  1 variable.
* 'train/subject_train.txt' 'data.frame':  7352 obs. of  1 variable. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

Test set: 

* 'test/X_test.txt': Training set. 'data.frame':  2947 obs. of  561 variables
* 'test/y_test.txt': Training labels. 'data.frame':  2947 obs. of  1 variable:
* 'test/subject_test.txt' 'data.frame':  2947 obs. of  1 variable. Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Code

### Steps 1 - 4

* Extract column numbers for the mean and stddev columns using the grep function and a regular expressions.
* Build a "lookup" table for the activities from the activity_labels.txt file.
* Function to combine three tables to construct a table with columns "Subject", "Activity", and several mean and standard deviation measurement columns.
* Get the training and test data sets using the above function.
* Combine the two data sets into a single data set.

Along the way, I name the columns of the set appropriately. The feature column names will be used in the next step to tidy the data.

### Steps 5

I use the DPLYR and TIDYR set to gather and tidy the data set into the final data set.


