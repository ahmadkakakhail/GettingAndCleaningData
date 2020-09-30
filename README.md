
Getting and Cleaning Data - Course Project
==========================================

* This is the course project for the Getting and Cleaning Data Coursera course.
* The included R script, `runAnalysis.R`, conducts the following:


1. Downloads the dataset from web and stores it in the working directory if it does not already exist in the working directory.
2. Read both the train and test datasets and merges them into x(measurements), y(activity) and subject, respectively.
3. Load the data(x's) features, activity info and extract columns named 'mean'(`-mean`) and 'standard'(`-std`). It also modifies column names to descriptive. (`-mean` to `Mean`, `-std` to `Std`, and remove symbols like `-`, `(`, `)`)
4. Extract data by selected columns(from step 3), and merge x, y(activity) and subject data. It also replaces y(activity) column to it's name by refering activity label (loaded step 3).
5. Generate 'Tidy Dataset' that consists of the average (mean) of each variable for each subject and each activity. The result is shown in the file `tidyDataset.txt`.