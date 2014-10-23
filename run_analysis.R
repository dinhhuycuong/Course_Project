#Course Project
##Set working directory
MasterWD <- paste(getwd(),"UCI HAR Dataset", sep = '/');
TrainWD <- paste(MasterWD,"train", sep = '/');
TestWD <- paste(MasterWD,"test", sep = '/');

## Read features and activity labels
setwd(MasterWD)
activity_label <- read.table("activity_labels.txt", sep = "",
			col.names = c("activity_code", "activity_description"))
features <- read.table("features.txt", sep = "\t")

## Read train data
setwd(TrainWD)
TrainData <- read.table("X_train.txt", sep = "",
		col.names = t(features))
TrainSubject <- read.table("subject_train.txt", sep = "",
		col.names = "subject")
TrainActivity <- read.table("y_train.txt", sep = "",
		col.names = "activity_code")
TrainData <- data.frame(TrainSubject, TrainActivity, TrainData)

## Read test data
setwd(TestWD)
TestData <- read.table("X_test.txt", sep = "",
		col.names = t(features))
TestSubject <- read.table("subject_test.txt", sep = "",
		col.names = "subject")
TestActivity <- read.table("y_test.txt", sep = "",
		col.names = "activity_code")
TestData <- data.frame(TestSubject, TestActivity, TestData)

##1. Merges the training and the test sets to create one data set.
AllData <- rbind(TrainData,TestData)


##2. Extracts only the measurements on the mean and standard deviation for each measurement.
Mean_STD_Data <- AllData[,c(grep("mean",colnames(AllData)),grep("std",colnames(AllData)))]
Mean_STD_Data <- data.frame(AllData[,c("subject", "activity_code")],
			Mean_STD_Data)

##3. Uses descriptive activity names to name the activities in the data set
Mean_STD_Data <- merge(Mean_STD_Data, activity_label, by = "activity_code")

##4. Appropriately labels the data set with descriptive variable names: variable names were already added when read train and test data.
##5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Second_Set <- Mean_STD_Data[,colnames(Mean_STD_Data) != "activity_description"]
Second_Set <- aggregate(Second_Set, list(Second_Set$activity_code, Second_Set$subject),
		FUN=mean, na.rm=TRUE, simplify = TRUE)
Second_Set <- merge(Second_Set, activity_label, by = "activity_code")

Second_Set <- data.frame(Second_Set$activity_description,
			Second_Set[,colnames(Second_Set) != "activity_description"])
Second_Set <- data.frame(Second_Set$subject,
			Second_Set[,colnames(Second_Set) != "subject"])
Second_Set$activity_code <- NULL
Second_Set$Group.1 <- NULL
Second_Set$Group.2 <- NULL
Second_Set[,c("activity_code", "Group.1", "Group.2")] <- NULL
setwd(MasterWD)
write.table(Second_Set,"second_set.txt", sep = "\t", row.names=FALSE)
