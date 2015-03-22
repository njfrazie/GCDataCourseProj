run_analysis <- function() {
#This function assumes you are in the UCI HAR Dataset folder
  
  library(dplyr)
  
  #Read in data sources-------------------------
  activities <- read.table("activity_labels.txt")
  features <- read.table("features.txt")
  
  testData <- read.table("./test/X_test.txt")
  testSubjects <- read.table("./test/subject_test.txt")
  testActivity <- read.table("./test/y_test.txt")
  
  trainData <- read.table("./train/X_train.txt")
  trainSubjects <- read.table("./train/subject_train.txt")
  trainActivity <- read.table("./train/y_train.txt")
  #--------------------------------------------#
  #|
  #|
  #Massage Data--------------------------------#
  testSubjects <- as.numeric(testSubjects$V1)
  testActivity <- as.numeric(testActivity$V1)
  trainSubjects <- as.numeric(trainSubjects$V1)
  trainActivity <- as.numeric(trainActivity$V1)
  
  features <- data.frame(lapply(features,as.character), stringsAsFactors=FALSE)
  activities <- data.frame(lapply(activities,as.character), stringsAsFactors=FALSE)
  activities$V1 = as.numeric(activities$V1)
  #--------------------------------------------#
  #|
  #|
  #Merge the Test/Train subjects,data, and activities together, then merge the total test and train data frames together
  tmp <- data.frame(testSubjects,testActivity)
  testMstr <- data.frame(Subjects = tmp[,1],Activity=tmp[,2],testData)
  
  tmp2 <- data.frame(trainSubjects,trainActivity)
  trainMstr <- data.frame(Subjects = tmp2[,1],Activity=tmp2[,2],trainData)
  
  df <- rbind(testMstr,trainMstr)
  #--------------------------------------------#
  #|
  #|  
  #Filter df for means and stdv.  Apply col names-----#
  
  #Strip out indices for features with mean in the title
  a <- grep("mean",features$V2,fixed=TRUE)
  #Strip out indices for features with std in the title
  b <- grep("std",features$V2,fixed=TRUE)
  #Combine and sort a and b in order
  indices <- sort(c(a,b))
  #Take just the feature names of the filtered indices
  names <- features[indices,2]
  
  indices <- indices+2  #shifts on account of Subjects and Activities columns
  indices <- as.numeric(c("1","2",indices))  #includes the subjects and activities columns to the indices array
  
  #Filter out the just the features that we want
  df <- df[,indices]
  
  #Name the columns appropriately 
  names <- c("Subject","Activity",names)
  colnames(df) <- names
  #---------------------------------------------------#
  #|
  #|
  #Take the mean of each measurement by Subject and by Activity---#
  tidy_data <- data.frame()
  tmp <- df
  
  for (i in 1:length(unique(df$Subject))) {
    tmp_sub <- subset(tmp,Subject==i)
    
    for (j in 1:6) {
      tmp_act <- subset(tmp_sub, Activity == j)
      
      act <- tmp_act %>% group_by(Subject) %>% summarise_each(funs(mean))
      tidy_data <- rbind(tidy_data,act)
    }
  }
  #--------------------------------------------# 
  #|
  #|  
  #Apply real names to the Activities----------#
  test <- tidy_data
  for ( x in 1:nrow(tidy_data)) {
    for (y in 1:nrow(activities)) {
      if (tidy_data$Activity[x] == activities[y,1]){
        tidy_data$Activity[x] <- activities[y,2]
      }
    }
  }
  #--------------------------------------------#
  tidy_data
  
}