tidyData <- function() {
  ## download the data in working directory
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  
  if(!file.exists("datasets.zip")) {
    download.file(fileURL, destfile = "/datasets.zip")
    unzip("datasets.zip")
    dateDownloaded <- date()
  }
  
  ## reading test data
  x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
  subjects_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
  
  ## reading train data
  x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
  subjects_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
  
  ## reading add. data
  features <- read.table("./UCI HAR Dataset/features.txt")
  activityLabels <- read.table("./UCI HAR Dataset/activity_labels.txt")
  
  ## Merges the training and the test sets
  mergeTest <- cbind(subjects_test, y_test, x_test)
  mergeTrain <- cbind(subjects_train, y_train, x_train)
  
  ## set column names
  colnames(mergeTest) <- c("subjects", "activities", as.character(features$V2))
  colnames(mergeTrain) <- c("subjects", "activities", as.character(features$V2))
  
  ## merge test and training sets
  trainTest <- rbind(mergeTest, mergeTrain)
  
  ## Extracts only the measurements on the mean and standard deviation for each measurement
  mstdTT <- trainTest[ ,c("subjects", "activities", grep("*mean*", names(trainTest), value = TRUE),
                                                    grep("*std*", names(trainTest), value = TRUE))]
  
  ## Uses descriptive activity names to name the activities in the data set
  mstdTT$activities = as.factor(mstdTT$activities)
  levels(mstdTT$activities) <- activityLabels$V2
  mstdTT$activities = tolower(mstdTT$activities)
  
  ## Appropriately labels the data set with descriptive variable names
  names(mstdTT) = gsub("^t", "time ", names(mstdTT))
  names(mstdTT) = gsub("^f", "frequency ", names(mstdTT))
  names(mstdTT) = gsub("BodyBody", "body ", names(mstdTT))
  names(mstdTT) = gsub("Body", "body ", names(mstdTT))
  names(mstdTT) = gsub("Gravity", "gravity ", names(mstdTT))
  names(mstdTT) = gsub("Gravity", "gravity ", names(mstdTT))
  names(mstdTT) = gsub("Acc", "accelerometer", names(mstdTT))
  names(mstdTT) = gsub("Gyro", "gyrometer", names(mstdTT))
  names(mstdTT) = gsub("Mag", " magnitude", names(mstdTT))
  names(mstdTT) = gsub("Jerk", " jerk", names(mstdTT))
  names(mstdTT) = gsub("[-]", " ", names(mstdTT))
  names(mstdTT) = gsub("[()]", "", names(mstdTT))
  
  ##From the data set in step 4, creates a second, independent tidy data set with the average 
  ## of each variable for each activity and each subject
  
  tidyDataMean <- group_by(mstdTT, subjects, activities)
  tidyDataMean <- summarize_all(tidyDataMean, mean)
  
  if(!file.exists("tidy_data.txt")) {
    return(write.table(tidyDataMean, row.names = FALSE, file = "tidy_data.txt"))
  } else {
    print("tidy_data.txt already exists in this directory")
  }
}
