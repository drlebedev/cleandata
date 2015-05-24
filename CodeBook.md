---
title: "Code Book"
author: "Kirill Lebedev"
date: "Saturday, May 23, 2015"
output: html_document
---

## Overview

Data cleanup code generates results.txt data file from data collected from the accelerometers from the Samsung Galaxy S smartphone. 

## Source dataset

The dataset could be downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and it includes the following files:

* 'README.txt'
* 'features_info.txt': Shows information about the variables used on the feature vector.
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 
* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 
* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

## Transformations

Script 'run_analysis.R':

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

See README.md for steps and details.

## Result

Result dataset is stored in 'result/result.txt'. Default folder for data is activity_recognition folder in user home folder.

Result dataset contains following columns:

Column Number | Description | Data Type
--------------| ----------- | ---------
1 | Activity perfomed by subject | String
2 | Subject ID (Identifier of person that perfomed activity) | Number
3:68 | Mean for each variable (feature) of source data per subject/activity filtred by type (only standard deviations and means left) | Number 
