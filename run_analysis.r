# This Script aims to produce a tidy dataset by combining the train and test data
# from the research performed in the following study:
# Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine

# Refer to Readme.md file in GitHub repository for instruction on working directory setup
# Refer to run_analysis_cb.md in GitHub repository for variable descriptions

## STEP 1: Merges the training and the test sets to create one data set

  # Read in training sets for feature result, subjects and activity label data
  x_train<-read.table("./train/x_train.txt", header = FALSE)
  subject_train<-read.table("./train/subject_train.txt", header = FALSE,col.names=("subject"))
  y_train<-read.table("./train/y_train.txt", header = FALSE,col.names=c("label"))
  
  # Combine training features, training subjects and training activity labels
  train_data<-cbind(x_train,subject_train,y_train)
  
  # Read in test sets for feature result, subject and activity label data
  x_test<-read.table("./test/x_test.txt", header = FALSE)
  subject_test<-read.table("./test/subject_test.txt", header = FALSE,col.names=("subject"))
  y_test<-read.table("./test/y_test.txt", header = FALSE,col.names=c("label"))
  
  # Combine test features, test subject and test activity labels
  test_data<-cbind(x_test,subject_test,y_test)
  
  # Merge combined train and test datasets
  merged_train_test_data<-rbind(train_data,test_data)

    
## STEP 2: Extracts only the measurements on the mean, mean(), and standard deviation, std(), for each measurement
  
  # Read in feature descriptions
  feature<-read.table("./features.txt", header = FALSE,col.names=c("feature_pos","feature_name"))
  
  # Find features matching mean and std in merged training and test set by returning indices
  measures_only<-merged_train_test_data[,c(grep("mean()|std()",feature$feature_name,value=FALSE),562:563)]
  
  
## STEP 3: Uses descriptive activity names to name the activities in the data set
  
  # Read in activity label descriptions
  activity_labels<-read.table("./activity_labels.txt", header = FALSE,col.names=c("label","activity"))  
  
  # Merge activity label descriptions to mean and std measures only
  m<-merge(measures_only,activity_labels,by.x="label",by.y="label",all=TRUE)
  # Remove label column from dataset
  m$label<-NULL
  
## STEP 4: Appropriately labels the data set with descriptive variable names. 
  
  # Find features matching mean and std in merged training and test set by returning names
  measure_names<-grep("mean()|std()",feature$feature_name,value=TRUE)
  
  # set column names of data frame to reflect descriptive variable names
  colnames(m)<-c(measure_names,"subject","activity")
  
## STEP 5: From the data set in step 4, create a second, independent tidy data set 
## with the average of each variable for each activity and each subject.
  
  # Determine aggregate means across mean and std features by activity and subject
  means_by_act_and_sub<-aggregate(m[,1:79],by=list(m[,81],m[,80]),mean,na.rm=TRUE)
  
  # Rename group by variables to reflect activity (group.1) and subject (group.2) respectively
  names(means_by_act_and_sub)[1:2] <- c("Activity","Subject")
  
  # Export aggregated tidy set as txt file
  write.table(means_by_act_and_sub,"./means_by_activity_subject.txt", row.name=FALSE)
  
## END OF SCRIPT