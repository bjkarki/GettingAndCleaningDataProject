#CodeBook

This is a code book  that describes the data, the variables and any transformations or work that was performed to clean up the data.


###The Data

Original data source for the project: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Full description of the data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


Please refer to the **README.txt** in the original data source for the background on data collection as well as various datasets present within the original data source.

- The observation and variables of the final tidy data are present in `X_train.txt`, `y_train.txt`, `subject_train.txt`, `X_test.txt`, `y_test.txt` and `subject_test.txt` files.

- The `feature.txt` contains the variable names for the **X** data.

- The `activity_labels.txt` links the class labels (in **y** data) with their activity name.

- The **subject** data identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.


###The Variables

The variable/features for the database comes from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. The raw signals were manipulated and varied to obtain 561 different variables.


###The Transformation

The transformation of the data can be broken down into 5 parts:

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set.

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

###Script File 

The script file performs the 5 part transformation using following steps:

- Loads `data.table` and `reshape2` libraries

- Addresses the test & train dataset seperately. The **X**, **y** and **subject** data for each set were merged using `cbind()`. Finally, the test and train data were merged using `rbind()`.

- The **features** contains the names for **X** data. Since only the measurement on the mean and standard deviation for each measurement is required, **features** was used to obtain the required subset of the data. This includes all measurement identified by the labels `mean()` and `std()`.

- Implements **activity_label** to use descriptive activity names to name the activities in the data set.

- Uses `melt()` and `dcast()` function to process the intermediate data to obtain the final independent tidy data set with the average of each variable for each activity and each subject.
