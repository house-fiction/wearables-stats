# Set working directory on local computer 
setwd("D:/ORCL-Technology/03 - Business Analytics/Data Science/Johns Hopkins University (Coursera)/03 - Getting and Cleaning Data/R-WorkDir")

# Project goal is to prepare tidy data that can be used for later analysis.
# The data linked to from the course website represent data collected from the 
# accelerometers from the Samsung Galaxy S smartphone. 
# A full description is available at the site where the data was obtained:
# 
# http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
# 
# Location of the data for the project:
#         
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
# Task: Create one R script called run_analysis.R that does the following: 
# 

### Download and unzip data file Dataset.zip
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# Checking for an existing data directory 
if (!file.exists("data")) {dir.create("data")}

download.file(fileURL, destfile = "./data/Dataset.zip")
unzip("Dataset.zip", exdir = "./data")

list.files("./data/UCI HAR Dataset")
# [1] "activity_labels.txt" "features.txt"        "features_info.txt"  
# [4] "README.txt"          "test"                "train"            

# The dataset includes the following files:
#
# 'features_info.txt': Shows information about the variables used on the feature vector.
# 'features.txt': List of all features.
# 'activity_labels.txt': Links the class labels with their activity name.
# 'train/X_train.txt': Training set.
# 'train/y_train.txt': Training labels.
# 'test/X_test.txt': Test set.
# 'test/y_test.txt': Test labels.

################################################################################
# 1. Merge the training and the test sets to create one data set.
#
### Create and inspect a data frame "dfSubjTrain" for the first 10 rows
dfSubjTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", nrows = 10)
# str(dfSubjTrain)
# head(dtSubjTrain)

### Create all data frames
dfSubjTrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt",sep="",header=FALSE)
dfSubjTest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt",sep="",header=FALSE)

dfActTrain  <- read.table("./data/UCI HAR Dataset/train/y_train.txt",sep="",header=FALSE)
dfActTest  <- read.table("./data/UCI HAR Dataset/test/y_test.txt",sep="",header=FALSE)

dfDataTrain <- read.table("./data/UCI HAR Dataset/train/X_train.txt",sep="",header=FALSE)
dfDataTest <- read.table("./data/UCI HAR Dataset/test/X_test.txt",sep="",header=FALSE)

### Join two data frames (datasets) vertically using the rbind function
dfSubjects <- rbind(dfSubjTrain,dfSubjTest)
# str(dfSubjects)
# head(dfSubjects)
# tail(dfSubjects)

dfActivities <- rbind(dfActTrain, dfActTest)
# str(dfActivities)

dfData <- rbind(dfDataTrain, dfDataTest)
# str(dfData)

### Create one data set by combing all 3 data frame by columns 
dfDataSet <- cbind(dfSubjects, dfActivities, dfData)
# str(dfDataSet)

# Write dfDataSet to a file (just for testing)
# write.table(dfDataSet,file="./data/dfDataSet.txt",sep=",",row.names=F)


################################################################################
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
#
### Read features_info.txt and features.txt files of the data set. It name which of
# 516 variables are measurements for the mean and standard deviation.
dfFeatures<- read.table("./data/UCI HAR Dataset/features.txt")
# head(dfFeatures)
#   V1                V2
# 1  1 tBodyAcc-mean()-X
# 2  2 tBodyAcc-mean()-Y
# 3  3 tBodyAcc-mean()-Z
# 4  4  tBodyAcc-std()-X
# 5  5  tBodyAcc-std()-Y
# 6  6  tBodyAcc-std()-Z

### Extract only measurements for the mean and standard deviation
MeanMeasures <- grep("tBodyAcc-mean|tBodyGyro-mean",dfFeatures$V2)
# str(MeanMeasures)
StdMeasures  <- grep("tBodyAcc-std|tBodyGyro-std",dfFeatures$V2)
# str(StdMeasures)

### Create new data set with the subsetted variables only
# head(dfData[,MeanMeasures])
# head(dfData[,StdMeasures])

dfNewdata <- cbind(dfSubjects,dfActivities,dfData[,MeanMeasures],dfData[,StdMeasures])
# str(dfNewdata)
# 'data.frame':	10299 obs. of  14 variables:
# $ V1  : int  1 1 1 1 1 1 1 1 1 1 ...
# $ V1  : int  5 5 5 5 5 5 5 5 5 5 ...
# $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
# $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
# $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
# $ V121: num  -0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...
# $ V122: num  -0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...
# $ V123: num  0.1077 0.1006 0.0961 0.0855 0.0774 ...
# $ V4  : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
# $ V5  : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
# $ V6  : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
# $ V124: num  -0.985 -0.983 -0.976 -0.991 -0.985 ...
# $ V125: num  -0.977 -0.989 -0.994 -0.992 -0.992 ...
# $ V126: num  -0.992 -0.989 -0.986 -0.988 -0.987 ...

################################################################################
# 3. Use descriptive activity names to name the activities in the data set
# 

### Read activity_labels.txt file containing the necessary descriptive names 
#   for the activities.
dfActNames <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
# head(dfActNames)
#   V1                 V2
# 1  1            WALKING
# 2  2   WALKING_UPSTAIRS
# 3  3 WALKING_DOWNSTAIRS
# 4  4            SITTING
# 5  5           STANDING
# 6  6             LAYING

### Set descriptive names 

# names(dfActNames)
# [1] "V1" "V2"

# dfActNames[,2]
# [1] WALKING            WALKING_UPSTAIRS   WALKING_DOWNSTAIRS SITTING           
# [5] STANDING           LAYING

### replace all activity numbers with activity names using function
#  gsub(pattern, replacement, x)
#  with pattern = string to be matched
#  replacement = string for replacement
#  x = string or string vector
for (i in 1:6){
        dfNewdata[,2] <- gsub(i,dfActNames[i,2],dfNewdata[,2])
}

# str(dfNewdata)
# 'data.frame':	10299 obs. of  14 variables:
# $ V1  : int  1 1 1 1 1 1 1 1 1 1 ...
# $ V1  : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
# $ V1  : num  0.289 0.278 0.28 0.279 0.277 ...
# $ V2  : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
# $ V3  : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
# $ V121: num  -0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...
# $ V122: num  -0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...
# $ V123: num  0.1077 0.1006 0.0961 0.0855 0.0774 ...
# $ V4  : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
# $ V5  : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
# $ V6  : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
# $ V124: num  -0.985 -0.983 -0.976 -0.991 -0.985 ...
# $ V125: num  -0.977 -0.989 -0.994 -0.992 -0.992 ...
# $ V126: num  -0.992 -0.989 -0.986 -0.988 -0.987 ...


################################################################################
# 4. Label the data set with appropriate descriptive variable names. 
#  
### Rename first 2 column headers using the function colnames()
colnames(dfNewdata) <- c("SUBJECT","ACTIVITY")

# str(dfNewdata)
# 'data.frame':	10299 obs. of  14 variables:
# $ SUBJECT : int  1 1 1 1 1 1 1 1 1 1 ...
# $ ACTIVITY: chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
# $ NA      : num  0.289 0.278 0.28 0.279 0.277 ...
# $ NA      : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
# $ NA      : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...

### Subset column names of the measures and convert to character data type
str(as.character(dfFeatures[MeanMeasures,2]))
# chr [1:6] "tBodyAcc-mean()-X" "tBodyAcc-mean()-Y" "tBodyAcc-mean()-Z" ...

str(as.character(dfFeatures[StdMeasures,2]))
# chr [1:6] "tBodyAcc-std()-X" "tBodyAcc-std()-Y" "tBodyAcc-std()-Z" ...

### Rename all column header
colnames(dfNewdata) <- c("SUBJECT"
                        ,"ACTIVITY"
                        ,as.character(dfFeatures[MeanMeasures,2])
                        ,as.character(dfFeatures[StdMeasures,2])
                        )
### Verify new data set
str(dfNewdata)
# 'data.frame':	10299 obs. of  14 variables:
# $ SUBJECT           : int  1 1 1 1 1 1 1 1 1 1 ...
# $ ACTIVITY          : chr  "STANDING" "STANDING" "STANDING" "STANDING" ...
# $ tBodyAcc-mean()-X : num  0.289 0.278 0.28 0.279 0.277 ...
# $ tBodyAcc-mean()-Y : num  -0.0203 -0.0164 -0.0195 -0.0262 -0.0166 ...
# $ tBodyAcc-mean()-Z : num  -0.133 -0.124 -0.113 -0.123 -0.115 ...
# $ tBodyGyro-mean()-X: num  -0.0061 -0.0161 -0.0317 -0.0434 -0.034 ...
# $ tBodyGyro-mean()-Y: num  -0.0314 -0.0839 -0.1023 -0.0914 -0.0747 ...
# $ tBodyGyro-mean()-Z: num  0.1077 0.1006 0.0961 0.0855 0.0774 ...
# $ tBodyAcc-std()-X  : num  -0.995 -0.998 -0.995 -0.996 -0.998 ...
# $ tBodyAcc-std()-Y  : num  -0.983 -0.975 -0.967 -0.983 -0.981 ...
# $ tBodyAcc-std()-Z  : num  -0.914 -0.96 -0.979 -0.991 -0.99 ...
# $ tBodyGyro-std()-X : num  -0.985 -0.983 -0.976 -0.991 -0.985 ...
# $ tBodyGyro-std()-Y : num  -0.977 -0.989 -0.994 -0.992 -0.992 ...
# $ tBodyGyro-std()-Z : num  -0.992 -0.989 -0.986 -0.988 -0.987 ...


################################################################################
# 5. Creates a second, independent tidy data set from the data set in step 4, with 
#    the average of each variable for each activity and each subject
# 

### Compute the mean values by using the aggregate() function
# S3 method for class 'data.frame'
# aggregate(x, by, FUN, ...)
# x   = an R object = columns 3...14 of dfNewdata = head(dfNewdata[,3:14],)
# by  = list of grouping elements = list(dfNewdata$SUBJECT, dfNewdata$ACTIVITY)
# FUN = function to compute the summary statistics = "mean"

TidyData <- aggregate(x   = dfNewdata[,3:14]
                     ,by  = list(dfNewdata$SUBJECT, dfNewdata$ACTIVITY)
                     ,FUN = "mean"
                      )
# str(TidyData)
# 'data.frame':	180 obs. of  14 variables:
# $ Group.1           : int  1 2 3 4 5 6 7 8 9 10 ...
# $ Group.2           : chr  "LAYING" "LAYING" "LAYING" "LAYING" ...
# $ tBodyAcc-mean()-X : num  0.222 0.281 0.276 0.264 0.278 ...
# $ tBodyAcc-mean()-Y : num  -0.0405 -0.0182 -0.019 -0.015 -0.0183 ...
# $ tBodyAcc-mean()-Z : num  -0.113 -0.107 -0.101 -0.111 -0.108 ...
# $ tBodyGyro-mean()-X: num  -0.01655 -0.01848 -0.02082 -0.00923 -0.02189 ...
# $ tBodyGyro-mean()-Y: num  -0.0645 -0.1118 -0.0719 -0.093 -0.0799 ...
# $ tBodyGyro-mean()-Z: num  0.149 0.145 0.138 0.17 0.16 ...
# $ tBodyAcc-std()-X  : num  -0.928 -0.974 -0.983 -0.954 -0.966 ...
# $ tBodyAcc-std()-Y  : num  -0.837 -0.98 -0.962 -0.942 -0.969 ...
# $ tBodyAcc-std()-Z  : num  -0.826 -0.984 -0.964 -0.963 -0.969 ...
# $ tBodyGyro-std()-X : num  -0.874 -0.988 -0.975 -0.973 -0.979 ...
# $ tBodyGyro-std()-Y : num  -0.951 -0.982 -0.977 -0.961 -0.977 ...
# $ tBodyGyro-std()-Z : num  -0.908 -0.96 -0.964 -0.962 -0.961 ...

### Rename the first 2 column names
colnames(TidyData)[1:2] <-c ("SUBJECT","ACTIVITY")


### Verify Tidy Data Set
# str(TidyData)
# 'data.frame':	180 obs. of  14 variables:
# $ SUBJECT           : int  1 2 3 4 5 6 7 8 9 10 ...
# $ ACTIVITY          : chr  "LAYING" "LAYING" "LAYING" "LAYING" ...
# $ tBodyAcc-mean()-X : num  0.222 0.281 0.276 0.264 0.278 ...
# $ tBodyAcc-mean()-Y : num  -0.0405 -0.0182 -0.019 -0.015 -0.0183 ...
# $ tBodyAcc-mean()-Z : num  -0.113 -0.107 -0.101 -0.111 -0.108 ...
# $ tBodyGyro-mean()-X: num  -0.01655 -0.01848 -0.02082 -0.00923 -0.02189 ...
# $ tBodyGyro-mean()-Y: num  -0.0645 -0.1118 -0.0719 -0.093 -0.0799 ...
# $ tBodyGyro-mean()-Z: num  0.149 0.145 0.138 0.17 0.16 ...
# $ tBodyAcc-std()-X  : num  -0.928 -0.974 -0.983 -0.954 -0.966 ...
# $ tBodyAcc-std()-Y  : num  -0.837 -0.98 -0.962 -0.942 -0.969 ...
# $ tBodyAcc-std()-Z  : num  -0.826 -0.984 -0.964 -0.963 -0.969 ...
# $ tBodyGyro-std()-X : num  -0.874 -0.988 -0.975 -0.973 -0.979 ...
# $ tBodyGyro-std()-Y : num  -0.951 -0.982 -0.977 -0.961 -0.977 ...
# $ tBodyGyro-std()-Z : num  -0.908 -0.96 -0.964 -0.962 -0.961 ...

### Write to file in *.txt foramt =  TidyDataSet.txt
write.table(TidyData,file="TidyDataSet.txt",sep=",",row.names=F)
