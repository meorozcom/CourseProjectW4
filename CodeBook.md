# Code Book

The run_analysis.R file performs the data collection, work with and clean a data set.

##  1. Downloading the dataset
   The data was downloaded and unzipped, the UCI VAR dataset was set as working       directory to access de files.
       
##  2. Assigning data to each variable
       feat <- "features.text"
       561 rows, 2 columns
This file includes the correct name for the variables. The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
       
       train_x <- From the folder train "X_train.txt"
       7352 rows, 561 columns
It contains the recorded features for train data.
       
       train_y <- From the folder train "y_train.txt"
       7352 rows, 1 columns
It contains train data of activities' code labels.

       test_x <- From the folder test "X_test.txt"
       2947 rows, 561 columns
It contains the recorded features for test data.

       test_y <- From the folder test "y_test.txt"
       2947 rows, 1 columns
It contains test data of activities' code labels.

       sub_test <- From the folder test "subject_test.txt"
       2947 rows, 1 column
It contains test data of the volunteer test subjects being observed.

       sub_train <- From the folder train "subject_train.txt"
       7352 rows, 1 column
It contains train data of the volunteer subjects being observed.

       act <- "activity_labels.txt"
       6 rows, 2 columns
List of activities and its codes (labels). Used for name the activities.

##  3. Merges the training and the test sets to create one data set

X (10299 rows, 561 columns) is created by merging train_x and test_x using rbind() function.

Y (10299 rows, 1 column) is created by merging train_y and test_y using rbind() function.

subj (10299 rows, 1 column) is created by merging sub_train and sub_test using rbind() function.

Mgd_Data (10299 rows, 563 column) is created by merging subj, Y and X using cbind() function.

##  4. Extracts only the measurements on the mean and standard deviation for each measurement.

Ext_Data (10299 rows, 88 columns) is created by subsetting Mgd_Data, selecting only columns: Subject, Code and the measurements on the mean (mean) and standard deviation (std) for each measurement.

##  5. Uses descriptive activity names to name the activities in the data set

Entire numbers in code column of the Ext_Data replaced with corresponding activity taken from second column of the activities variable.

##  6. Appropriately labels the data set with descriptive variable names.

Code column in Ext_Data renamed into activities from "Activity"

All Acc in column’s name replaced by Accelerometer

All Gyro in column’s name replaced by Gyroscope

All BodyBody in column’s name replaced by Body

All Mag in column’s name replaced by Magnitude

All start with character f in column’s name replaced by Frequency

All start with character t in column’s name replaced by Time

Added a line to arrange data in alphabetic order according the Activity column.

##  7. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

FinalData (180 rows, 88 columns) is created by sumarizing Ext_Data taking the means of each variable for each activity and each subject, after groupped by subject and activity.

Export FinalData into FinalData.txt file.

 
