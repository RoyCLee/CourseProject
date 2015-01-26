##  run_analysis.R

##  Roy Lee
##  25 JAN 2015
##  Getting and Cleaning Data
##  Course Project

##  See README.md for documentation.

feature_names <- read.table("features.txt", stringsAsFactor = FALSE,
    col.names = c("Number", "Name"))

subject_test <- read.table("test/subject_test.txt")
y_test <- read.table("test/y_test.txt")
X_test <- read.table("test/X_test.txt")
test <- cbind(subject_test, y_test, X_test)
colnames(test) <- c("Subject", "Activity_Num", feature_names$Name)

subject_train <- read.table("train/subject_train.txt")
y_train <- read.table("train/y_train.txt")
X_train <- read.table("train/X_train.txt")
train <- cbind(subject_train, y_train, X_train)
colnames(train) <- c("Subject", "Activity_Num", feature_names$Name)

test_and_train <- rbind(test, train)

activity_labels <- read.table("activity_labels.txt", stringsAsFactor = FALSE,
    col.names = c("Activity_Num", "Activity"))

features <- merge(test_and_train, activity_labels, by.x = "Activity_Num",
    by.y = "Activity_Num", all.x = TRUE)

features_activity <- aggregate(features[, grep("mean[(][)]|std[(][)]",
    colnames(features))], list(features$Activity), mean)
features_subject <- aggregate(features[, grep("mean[(][)]|std[(][)]",
    colnames(features))], list(features$Subject), mean)
features_means <- rbind(features_activity, features_subject)
names(features_means)[names(features_aggregates) == "Group.1"] <-
    "Activity_or_Subject"

write.table(features_means, "features_means.txt")

##  End
