# README - run_analysis.R

## Files
This repo contains the following files:
* run_analysis.R - script which creates a tidy data set
* codebook.md - the codebook for the final tidy data set
* README.md - this file

## Steps of the *run.analysis.R* script

* Downloads the UCI HAR Dataset
* Read the following data sets: x_train, y_train, x_test, y_test, subjects_test, subjects_train, features and activityLabels
* Merges all the files together to create one data set
* set readable and understandable names for all the columns
* Extracts only the mean and standard deviation of each meausurement
* Calculates the mean of each variable per subject and per activity
* creates a tidy data set which is written to a new txt file names tidy_data.txt

## Running the script
Follow the following steps to run te script:

* open up rstudio
* set your preferred working directory
* load the run_analysis.R script into rstudio
* source the script into rstudio
* run the script by calling the function *tidyData()*

## Source
The file downloaded by the script can be found here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
