---
title: "CODEBOOK: Getting Clean Data Project"
output: html_document
---

### This Codebook describes the variables, the data, and any transformations or work performed to clean up the data.


## Study Design 

+ The data comes from accelerometers on Samsung Galaxy S II smartphone. It recorded various accelerometers measurements of 30 persons during different prescribed activities.More information on the experiments can be found <a href = https://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones> here </a>.
+ The data for the project is downloaded from  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
+ The zip file has been saven in the working directory by run_analysis.R (analysis script).
+ The file is unzipped in the working directory and creates the subdirectory "UCI HAR Dataset" which contains all the raw data and "README.txt" which describes the dataset.
+ The raw data is separated into test and training datasets. Within each of the test and training datasets the data are separated into files for features data, measurement data, the activity label, and the test subject IDs. 
 
## Codebook
The variables and processes will be outlined by the requirement steps for run_Analysis.R

### 1.Merges the training and the test sets to create one data set.

The files for the test and training datasets raw data, activity labels and test subjects are imported into the following dataframes <ul>
<li> xtest </li>   
<li> ytest </li>
<li> subject_test</li> 
<li> xtrain </li>
<li> ytrain </li>
<li>subject_train </li>
<li> features </li>
<li>activity_label</li>
</ul>

The test and train datasets are matched together by common attribute: "subjectID. Created dataframe that contains the merged datasets-

+  merged_data   
The merged data is then ordered by "Subject ID" and "activity_label". Hence the rearrangd dataframe is

+  arranged_data     


### 2.Extracts only the measurements on the mean and standard deviation for each measurement.

This step imports the variable names for measurement data. It finds only the columns that contain variables that are the mean and standard deviation of measurements and subsequently subsets the combined data to only these variables.

+ data_Mean_and_Std - subset of arranged_data with only the columns of variables that includes mean and standard deviations of measurements 


### 3. Uses descriptive activity names to name the activities in the data set

The activity labels dataset is imported which contains the descriptive names of the activities linked with the numeric code for the activity. This is joined with the combine_labels dataset and the output is a single variable dataset with descriptive activity labels for each row of the dataset.

+ activity_label - imported dataset with linking numeric coded activity with descriptive name 
+ dataWithActivityNames- Merged "data_Mean_and_Std" and "activity_label" by numeric coded activityLabel. Thus a dataset is created that contains  descriptively named activities for each row of the dataset.  

### 4. Appropriately labels the data set with descriptive variable names.

The measurement variable names for the mean and standard deviation variables are extracted from the features dataset and used to name the columns of the dataWithActivityNames data subset. The names are modified slightly for readability. 
+ dataLabels - Variable labels for the dataMeanStd dataset. mean() and std() are changed to Mean and SD for readability. Hyphens are left in the variable names for readability.  


### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Here a dataset is output that gives the Mean for each measurement variable for each Subject+Activity combination. 

+ tidy_average_data: Outputs a dataset sorted by subject and activity with the mean for measurement variable for each combination of subject and activity. 

Finally, the tidy dataset is written and saved in a text file.
+ Final Tidy Data.txt: The analysed tidy data is saved in this text file.  





