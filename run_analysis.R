##if the file doesn't exist it will download it
if (!file.exists("Data.zip")) {
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        Data <- download.file(fileURL,destfile="C:/Users/maggy/Downloads/Coursera/Data science/Getting and Cleaning data/Data.zip")}

##when downloaded it'll unzip it 
if (file.exists("Data.zip")) {
        uzp <-"C:/Users/maggy/Downloads/Coursera/Data science/Getting and Cleaning data/Data.zip" 
        unzip(uzp)}

##set the new wd
setwd("UCI HAR Dataset")

library(dplyr) ##Calls dplyr, must download it before

##obtain all the data frames for the project. I decided to put these here to avoid mistakes.
##1
feat <- read.table("features.txt", col.names = c("n","functions"))
train_x <- read.table("train/X_train.txt", col.names = feat$functions)
train_y <- read.table("train/y_train.txt", col.names = "Code")
test_x <- read.table("test/X_test.txt", col.names = feat$functions)
test_y <- read.table("test/y_test.txt", col.names = "Code")
sub_test <- read.table("test/subject_test.txt", col.names = "Subject")
sub_train <- read.table("train/subject_train.txt", col.names = "Subject")
act <- read.table("activity_labels.txt", col.names = c("Code", "Activity"))

## 1. Merges the training and the test sets to create one data set.
X <- rbind(train_x, test_x)
Y <- rbind(train_y, test_y)
subj <- rbind(sub_train, sub_test)
Mgd_Data <- cbind(subj, Y, X)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
Ext_Data <- Mgd_Data %>% select(Subject, Code, contains("mean"), contains("std"))

## 3. Uses descriptive activity names to name the activities in the data set
Ext_Data$Code <- act[Ext_Data$Code, 2]

## 4. Appropriately labels the data set with descriptive variable names.
## Better names to understand 
names(Ext_Data)[2] = "Activity"
names(Ext_Data)<-gsub("Acc", "Accelerometer", names(Ext_Data))
names(Ext_Data)<-gsub("Gyro", "Gyroscope", names(Ext_Data))
names(Ext_Data)<-gsub("BodyBody", "Body", names(Ext_Data))
names(Ext_Data)<-gsub("Mag", "Magnitude", names(Ext_Data))
names(Ext_Data)<-gsub("^t", "Time", names(Ext_Data))
names(Ext_Data)<-gsub("^f", "Frequency", names(Ext_Data))
names(Ext_Data)<-gsub("tBody", "TimeBody", names(Ext_Data))
names(Ext_Data)<-gsub("-mean()", "Mean", names(Ext_Data), ignore.case = TRUE)
names(Ext_Data)<-gsub("-std()", "StandDev", names(Ext_Data), ignore.case = TRUE)
names(Ext_Data)<-gsub("-freq()", "Frequency", names(Ext_Data), ignore.case = TRUE)
names(Ext_Data)<-gsub("angle", "Angle", names(Ext_Data))
names(Ext_Data)<-gsub("gravity", "Gravity", names(Ext_Data))

## To have the activities in order
Ext_Data <- arrange(Ext_Data, Activity)

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
FinalData <- Ext_Data %>%
        group_by(Subject, Activity) %>%
        summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.name=FALSE)
