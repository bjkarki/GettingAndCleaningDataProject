# Setting up the working directory
if(!file.exists("Final_Project")) {
        message("Setting up the working directory")
        dir.create("Final_Project")
}
setwd("Final_Project")

# Download "UCI HAR Dataset" if not available 
if(!file.exists("UCI HAR Dataset")) {
        message("Downloading the required dataset")
        fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        zipFile <- "UCI_HAR_Dataset.zip"
        download.file(fileUrl, zipFile, method="curl")
        unzip(zipFile)
        unlink(zipFile)
        rm(zipFile, fileUrl)
}

# Check if the required packages are installed
message ("installing & loading required library")
if(!require("data.table")) {
        install.packages("data.table")
}

if(!require("reshape2")) {
        install.packages("reshape2")
}

# load the package
library(data.table)
library(reshape2)

# Load features, activity_labels
features <- read.table("UCI HAR Dataset/features.txt")
features <- features[,2]

activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
activity_labels <- activity_labels[,2]

# Only mean and std are required from all the feautre list
required_features <- grepl("mean\\(\\)|std\\(\\)", features)

#Train data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
# 4. Appropriately label the data set with descriptive variable names.
names(X_train) <- features
# 2. Extract only the mean and standard deviation for each measurement.
X_train <- X_train[,required_features]

y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
# 3. Descriptive activity names to name the activities in the data set
y_train[,2] <- activity_labels[y_train[,1]]
# 4. Appropriately label the data set with descriptive variable names.
names(y_train) <- c("activityid","activitylabel")

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
# 4. Appropriately label the data set with descriptive variable names.
names(subject_train) <- "subject"

#Column bind the train data
train_data <- cbind(subject_train,y_train,X_train)
rm(subject_train, y_train, X_train)

#Test data
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
# 4. Appropriately label the data set with descriptive variable names.
names(X_test) <- features
# 2. Extract only the mean and standard deviation for each measurement.
X_test <- X_test[,required_features]

y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
# 3. Descriptive activity names to name the activities in the data set
y_test[,2] <- activity_labels[y_test[,1]]
# 4. Appropriately label the data set with descriptive variable names.
names(y_test) <- c("activityid","activitylabel")

subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
# 4. Appropriately label the data set with descriptive variable names.
names(subject_test) <- "subject"

#Column bind the test data
test_data <- cbind(subject_test,y_test,X_test)
rm(subject_test,y_test,X_test)

# 1. Merge the train and the test sets to create one data set
requiredData <- rbind(train_data,test_data)
rm(train_data,test_data)
rm(activity_labels,features,required_features)

# 5. Create an independent tidy data set with the average of each variable for each activity and each subject

## Reshaping data using melt
id.vars <- c("subject","activityid","activitylabel")
measure.vars <- setdiff(names(requiredData),id.vars)
meltData <- melt(requiredData,id.vars = id.vars,measure.vars = measure.vars)
rm(id.vars,measure.vars)

## Getting the average for each subject and activity using dcast function
tidyData <- dcast(meltData, subject + activitylabel ~ variable, mean)

## Removing pre-existing tidy file
if (file.exists("UCI HAR Dataset/tidy_data.txt")) {
        message("removing pre-existing 'tidy_data.txt' file")
        unlink("UCI HAR Dataset/tidy_data.txt")
}

## Writing the tidy_data.txt file
write.table(tidyData,file = "UCI HAR Dataset/tidy_data.txt",row.names = FALSE)
message("'tidy_data.txt' file created under the directory 'UCI HAR Dataset'")
rm(meltData)
setwd("..")