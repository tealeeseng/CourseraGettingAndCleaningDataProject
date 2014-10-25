

# step 1 starts here, Merges the training and the test sets to create one data set.

# Loading files into data frame.
features<-read.table(file="features.txt", header=FALSE )

X_test<-read.table(file="test/X_test.txt",header=FALSE, col.names = features[[2]] )
test_subject<-read.table(file="test/subject_test.txt",header=FALSE)
test_activity<-read.table(file="test/y_test.txt",header=FALSE)

X_train<-read.table(file="train/X_train.txt",header=FALSE, col.names = features[[2]] )
train_subject<-read.table(file="train/subject_train.txt",header=FALSE)
train_activity<-read.table(file="train/y_train.txt",header=FALSE)

#column merging
train<-X_train
train<-cbind(train,train_subject,train_activity)
colnames(train)[562]<-"subject"
colnames(train)[563]<-"activity"

test<-X_test
test<-cbind(test,test_subject,test_activity)
colnames(test)[562]<-"subject"
colnames(test)[563]<-"activity"


#dataframe rows merge
step1Result<-rbind(train,test,deparse.level=2)   # step 1 result


# step 2 starts here, Extracts only the measurements on the mean and standard deviation for each measurement.
meanAndStdInd=c(1:6,41:46,81:86,121:126,161:166,201,202,214,215,227:228,240:241,253:254,266:271,345:350, 424:429,503:504,516:517,529:530,542:543,562,563)
step2Result<-step1Result[,meanAndStdInd]

#step3 starts here, Uses descriptive activity names to name the activities in the data set
activity_labels<-read.table(file="activity_labels.txt", header=FALSE )
colnames(activity_labels)[2]<-"activity_name"
step3Result <- merge(step2Result, activity_labels, by.x="activity",by.y="V1")

#step4 starts here, Appropriately labels the data set with descriptive variable names. 
step4Result<-step3Result;
colnames(step4Result)<-c("activity","tBodyAcc.mean.X","tBodyAcc.mean.Y", 
"tBodyAcc.mean.Z","tBodyAcc.std.X","tBodyAcc.std.Y", 
"tBodyAcc.std.Z","tGravityAcc.mean.X","tGravityAcc.mean.Y",
"tGravityAcc.mean.Z","tGravityAcc.std.X","tGravityAcc.std.Y", 
"tGravityAcc.std.Z","tBodyAccJerk.mean.X","tBodyAccJerk.mean.Y", 
"tBodyAccJerk.mean.Z","tBodyAccJerk.std.X","tBodyAccJerk.std.Y", 
"tBodyAccJerk.std.Z","tBodyGyro.mean.X","tBodyGyro.mean.Y", 
"tBodyGyro.mean.Z","tBodyGyro.std.X","tBodyGyro.std.Y", 
"tBodyGyro.std.Z","tBodyGyroJerk.mean.X","tBodyGyroJerk.mean.Y", 
"tBodyGyroJerk.mean.Z","tBodyGyroJerk.std.X","tBodyGyroJerk.std.Y", 
"tBodyGyroJerk.std.Z","tBodyAccMag.mean","tBodyAccMag.std", 
"tGravityAccMag.mean","tGravityAccMag.std","tBodyAccJerkMag.mean", 
"tBodyAccJerkMag.std","tBodyGyroMag.mean","tBodyGyroMag.std", 
"tBodyGyroJerkMag.mean","tBodyGyroJerkMag.std","fBodyAcc.mean.X", 
"fBodyAcc.mean.Y","fBodyAcc.mean.Z","fBodyAcc.std.X", 
"fBodyAcc.std.Y","fBodyAcc.std.Z","fBodyAccJerk.mean.X", 
"fBodyAccJerk.mean.Y","fBodyAccJerk.mean.Z","fBodyAccJerk.std.X", 
"fBodyAccJerk.std.Y","fBodyAccJerk.std.Z","fBodyGyro.mean.X", 
"fBodyGyro.mean.Y","fBodyGyro.mean.Z","fBodyGyro.std.X", 
"fBodyGyro.std.Y","fBodyGyro.std.Z","fBodyAccMag.mean", 
"fBodyAccMag.std","fBodyBodyAccJerkMag.mean","fBodyBodyAccJerkMag.std", 
"fBodyBodyGyroMag.mean","fBodyBodyGyroMag.std","fBodyBodyGyroJerkMag.mean",
"fBodyBodyGyroJerkMag.std","subject","activity_name");



#step5 starts here, From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
library(dplyr)

step4ResultByActivitySubject <- step4Result %>% group_by(activity_name, subject)
step5Result<-step4ResultByActivitySubject %>% summarise_each(funs(mean))

write.table(step5Result, file="step5Result.txt",row.name=FALSE )


