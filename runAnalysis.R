# Library for Preparing The Data
library(reshape2)


# Extracting the data from the web
dataDir <- "./gacdData"
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataFilename <- "gacdData.zip"
dataDF <- paste(dataDir, "/", "gacdData.zip", sep = "")
dataDir2 <- "./data"

if (!file.exists(dataDir)) {
    dir.create(dataDir)
    download.file(url = dataUrl, destfile = dataDF)
}
if (!file.exists(dataDir2)) {
    dir.create(dataDir2)
    unzip(zipfile = dataDF, exdir = dataDir2)
}

# Merges Train Test Dataset
# Training Data

x_train <- read.table(paste(sep = "", dataDir2, "/UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste(sep = "", dataDir2, "/UCI HAR Dataset/train/Y_train.txt"))
s_train <- read.table(paste(sep = "", dataDir2, "/UCI HAR Dataset/train/subject_train.txt"))

# Testing Data
x_test <- read.table(paste(sep = "", dataDir2, "/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste(sep = "", dataDir2, "/UCI HAR Dataset/test/Y_test.txt"))
s_test <- read.table(paste(sep = "", dataDir2, "/UCI HAR Dataset/test/subject_test.txt"))

# Merges Training and Testing Data
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
s_data <- rbind(s_train, s_test)


# Loading Features & Activity Information
# Feature Info
feature <- read.table(paste(sep = "", dataDir2, "/UCI HAR Dataset/features.txt"))

# Activity Labels
a_label <- read.table(paste(sep = "", dataDir2, "/UCI HAR Dataset/activity_labels.txt"))
a_label[,2] <- as.character(a_label[,2])

# Extracting Feature Columns and Names with the name of "Mean and Std"
selectedCols <- grep("-(mean|std).*", as.character(feature[,2]))
selectedColNames <- feature[selectedCols, 2]
selectedColNames <- gsub("-mean", "Mean", selectedColNames)
selectedColNames <- gsub("-std", "Std", selectedColNames)
selectedColNames <- gsub("[-()]", "", selectedColNames)


# Extracting Data by Columns & Using Their Descriptive Names
x_data <- x_data[selectedCols]
allData <- cbind(s_data, y_data, x_data)
colnames(allData) <- c("Subject", "Activity", selectedColNames)

allData$Activity <- factor(allData$Activity, levels = a_label[,1], labels = a_label[,2])
allData$Subject <- as.factor(allData$Subject)


# Tidy Dataset Generation
meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)