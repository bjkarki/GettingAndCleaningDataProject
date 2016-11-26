#Getting and Cleaning Data Course Project

##Goal

Create an R script called `run_analysis.R` that does the following:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

##Procedure

1. Download and extract the data source. The directory name will be `UCI HAR Dataset`
2. Set the parent directory of `UCI HAR Dataset` as the working directory.
3. Put `run_analysis.R` script in the working directory.
4. Run the script using `source("run_analysis.R")`.
5. The script will generate a tidy data called `tidy_data.txt` in the working directory.