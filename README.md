Course_Project
==============
Steps:

1. Set working directory

2. Read features and activity labels

3. Read train data, descriptive variable names are added using feature data frame as header

4. Read test data, descriptive variable names are added using feature data frame as header

5. Merges the training and the test sets to create one data set.

6. Extracts only the measurements on the mean and standard deviation for each measurement using grep function.

7. Uses descriptive activity names to name the activities in the data set by merging the dataset with activity labels data frame

8. Appropriately labels the data set with descriptive variable names: variable names were already added when read train and test data.

9. Creates a second data set with the average of each variable for each activity and each subject by aggregate function by activity code (numeric). Aggregate function doesn't work for column containing strings.

10. Export the second datset using write.table, sep = tab, row.names = False.
