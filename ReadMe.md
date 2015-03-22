==================================================================
###Getting and Cleaning Data Course Project
Version 1.0
==================================================================
Origin of the data: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
Course website: https://class.coursera.org/getdata-012
Data before manipulation: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
==================================================================
###R Packages Needed:
* Dplyr
==================================================================
###Instructions for use:

1. Save and extract the zip file at the aforementioned link
2. Place run_analysis.R inside of the extracted folder "UCI HAR Dataset"
3. Source run_analysis
4. Execute the code... 	> tidy_data <- run_analysis()
	
==================================================================
###Description of the script

The data inside the zip folder that the script uses is as follows:
* 'features.txt': List of all features.
* 'activity_labels.txt': Links the class labels with their activity name.
* 'train/X_train.txt': Training set.
* 'train/y_train.txt': Training labels.
* 'test/X_test.txt': Test set.
* 'test/y_test.txt': Test labels.
* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 
* 'test/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

1. After reading in the files, the script massages the data into appropriate data types.  
2. It then combines the training and test Subject, Activity, and test data respectively into data frames
3. Next it combines the two data frames to get one large data frame 10299x563
4. Next, it searches the features array for any test measurement that contains a mean or a std deviation
5. Taking those indices, it subsets the main data frame to reduce it to 10299x81
6. Using that same indice search, it applies unique names to the columns.
7. Next, it starts looping through the data to take average of each activity performed by each subject
8. To do that, it first subsets the data by the subject, then subsets by the activity.  
9. The average of that resulting data frame is calculated and appeneded to the previous run of that loop
10. In the end, the result of the loop will be a new data frame with the size of 180x81
		* 180 because it there are 30 subjects who perform 6 activities
11. The last step is looping through the final data set and matching the activity number to the english description of the activity.



