# getcleandata

# This repository contains the following files submitted for the Getting & Cleaning Data course project:
* run_analysis.r => contains the R code script used to run the steps to create the tidy dataset
* means_by_activity_subject.txt => contains the tidy dataset in text file format, produced by perfoming the data merging, cleansing and manioulation steps as outlined below under instructions performed (as shown in the R code script)
* means_by_activity_subject_cb.pdf => code book for means_by_activity_subject.txt

# Steps followed in producing the tidy dataset
* Training and the test sets merged to create one data set - merge was performed by executing cbind on the 3 datasets (x_...,subject_...,y_...) for test and train first, and then conducting a rbind on the 2 resultant sets. All tables were read in using read.table with header set to false.
*Only the measurements on the mean and standard deviation for each measurement was extracted by utilising the grep functionality and the ./features.txt file. 
* Descriptive activity names were assigned to each of the activities in the data set by merging the contents of the ./activities_label.txt file with the dataset.
* Descriptive variable names were assigned by assigning the vector of the applicable feature names in the ./features.txt file to the dataset column names. 
* And finally, a tidy data set with the average of each variable for each activity and each subject was produced by utilising the dataframe aggregate functionality. means_by_activity_subject.txt was exported by write.table with row.name set to false.

# Before testing the run_analysis.r script it is important to ensure the following:
* working directory should contain all datasets as available from (this should have been unzipped in this directory) https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
* the test and train datasets should be in subfolders within the working directory as the read.table code references it as:
./train/x_train.txt
./train/subject_train.txt
./train/y_train.txt
./test/x_test.txt
./test/subject_test.txt
./test/y_test.txt
