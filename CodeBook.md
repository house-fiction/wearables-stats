
Code Book - Wearables Data Set
==============================

Date: "27. Dezember 2015"

The data of this (tidy) data set represent aggregated data from the Human Activity Recognition database which was built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted Samsung S smartphone with embedded inertial sensors.

A full description of the original data set is available at the site where the data was obtained:
<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> 

Field Description
-----------------
**SUBJECT** - identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.


**ACTIVITY** - Activity name, available values are:

* WALKING

* WALKING_UPSTAIRS

* WALKING_DOWNSTAIRS

* SITTING

* STANDING

* LAYING


### Accelerometer variables (features)

The body acceleration signal obtained by subtracting the gravity from the total acceleration, features are normalized and bounded within [-1,1] 

**tBodyAcc-mean()-X** - Mean value of accelerometer signal, X direction 

**tBodyAcc-mean()-Y** - Mean value of accelerometer signal, Y direction

**tBodyAcc-mean()-Z** - Mean value of accelerometer signal, Z direction

**tBodyAcc-std()-X** - Standard deviation of accelerometer signal, X direction

**tBodyAcc-std()-Y** - Standard deviation of accelerometer signal, Y direction

**tBodyAcc-std()-Z** - Standard deviation of accelerometer signal, Z direction

 
### Gyroscope variables
The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. Features are normalized and bounded within [-1,1]

**tBodyGyro-mean()-X** - Mean value of gyroscope signal, X direction

**tBodyGyro-mean()-Y** - Mean value of gyroscope signal, Y direction

**tBodyGyro-mean()-Z** - Mean value of gyroscope signal, Z direction

**tBodyGyro-std()-X** - Standard deviation of gyroscope signal, X direction

**tBodyGyro-std()-Y** - Standard deviation of gyroscope signal, Y direction

**tBodyGyro-std()-Z** - Standard deviation of gyroscope signal, Z direction


Transformations performed to obtain the data set
------------------------------------------------

The raw data of the Human Activity Recognition database has been processed in 5 steps:

1. Training and the test date sets have been merged into one data set.

2. Extraction of the mean and standard deviation measures. 

3. Replacement of activity codes with descriptive activity names

4. Labeling the data set with descriptive variable names and creation of the first data set

5. From the data set in step 4, creates a second, final data set with the average of each variable for each activity and each subject.

**NOTE:** The file run_analysis.R in the main directory contains detailed comments about the data transformations applied.  
