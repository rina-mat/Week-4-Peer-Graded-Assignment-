#You should create one R script called run_analysis.R that does the following.

# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names.
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.




unzip_file <- unzip("G:/R Files/R Learning From Coursera/Getting and Cleaning Data Projects/Week 4 peer graded assignment/getdata_projectfiles_UCI HAR Dataset.zip", exdir = "G:/R Files/R Learning From Coursera/Getting and Cleaning Data Projects/Week 4 peer graded assignment")
pathdata <- file.path("G:/R Files/R Learning From Coursera/Getting and Cleaning Data Projects/Week 4 peer graded assignment", "UCI HAR Dataset")
files = list.files(pathdata, recursive = TRUE) 


### 1. Here we begin how to create the data set of training and test
#Reading training tables - xtrain / ytrain, subject train

xtrain <- read.table(file.path(pathdata, "train", "X_train.txt"), header = FALSE) 
ytrain <- read.table(file.path(pathdata, "train", "Y_train.txt"), header = FALSE)
subject_train <- read.table(file.path(pathdata, "train", "subject_train.txt"), header = FALSE)

#Reading test tables - xtest/ ytest, subject test

xtest <- read.table(file.path(pathdata, "test", "X_test.txt"), header = FALSE) 
ytest <- read.table(file.path(pathdata, "test", "Y_test.txt"), header = FALSE)
subject_test <- read.table(file.path(pathdata, "test", "subject_test.txt"), header = FALSE)

# Reading the features data

features <- read.table(file.path(pathdata, "features.txt"))

#Reading activity labels data set
activity_label <- read.table(file.path(pathdata,  "activity_labels.txt"), header = FALSE)

#naming variable of test data

colnames(xtest) <- features[,2]
colnames(ytest) <- "activityLabel" 
colnames(subject_test) <- "subjectID" 

#naming variable of train data

colnames(xtrain) <- features[,2]
colnames(ytrain) <- "activityLabel" 
colnames(subject_train) <- "subjectID" 

colnames(activity_label) <- c("activityLabel", "activityType")

#creating test data table & train data table

test_data <- cbind(subject_test, ytest, xtest)
train_data <- cbind(subject_train, ytrain, xtrain)

# Objective 1 - Merging the test and train data set

merged_data <- rbind(test_data, train_data)

library(dplyr)

arranged_data <- merged_data[order(merged_data$subjectID, merged_data$activityLabel),] ## Data is arranged by SubjectID and LabelID

# Objective 2 - Extracting on the mean and standard deviation for each measurement

data_Mean_and_Std <- select(arranged_data, subjectID, activityLabel, contains("mean()"), contains("meanFreq()"), contains("std")) 

##Alternative

#colNames = colnames(arranged_data)
#selected_var = (grepl("activityLabel" , colNames) | grepl("subjectID" , colNames) | grepl("mean.." , colNames) | grepl("std.." , colNames))
#data_alt <- arranged_data[ , selected_var == TRUE]

# Objective 3 - using descriptive activity names to name the activities in the data set
dataWithActivityNames <- merge(data_Mean_and_Std, activity_label, by = "activityLabel")
dataWithActivityNames <- dataWithActivityNames[,c(2,1,82, 3:81)] #changed the position of column activityType for tidyness

# Objective 4 - Data sets "data_Mean_and_Std" and "dataWithActivityNames" are labelled with descriptive varible names 


dataLabels <- names(dataWithActivityNames)
dataLabels = gsub("mean", "Mean", gsub("std", "SD", gsub("\\()", "", dataLabels)))


# Objective 5 - createing a second, independent tidy data set with the average of each variable for each activity and each subject 


tidy_average_data <- aggregate(dataWithActivityNames[,4:82], by = list(dataWithActivityNames$subjectID, dataWithActivityNames$activityType), mean)

names(tidy_average_data)[1] <- "subjectID" 
names(tidy_average_data)[2] <- "activityType" 

## Saving Data 
submittedDataSet <- tidy_average_data
write.table(submittedDataSet, "Submitted Dataset.txt", row.names = FALSE)


