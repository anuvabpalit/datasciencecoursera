if(!file.exists("./asgnmt_data")){dir.create("./asgnmt_data")}
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(Url,destfile="./asgnmt_data/asgnmt_dataset.zip")


# Unziping dataSet to /asgnmt_data directory
unzip(zipfile="./asgnmt_data/asgnmt_dataset.zip",exdir="./asgnmt_data")




# Reading trainings tables:
x_train <- read.table("./asgnmt_data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./asgnmt_data/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./asgnmt_data/UCI HAR Dataset/train/subject_train.txt")

# Reading testing tables:
x_test <- read.table("./asgnmt_data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./asgnmt_data/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./asgnmt_data/UCI HAR Dataset/test/subject_test.txt")

# Reading feature vector:
features <- read.table('./asgnmt_data/UCI HAR Dataset/features.txt')

# Reading activity labels:
activityLabels = read.table('./asgnmt_data/UCI HAR Dataset/activity_labels.txt')


# Assigning Column Names

colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"
      
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"


# Putting all data into a single set

single_train <- cbind(y_train, subject_train, x_train)
single_test <- cbind(y_test, subject_test, x_test)
setAllInOne <- rbind(single_train, single_test)
      
colnames(activityLabels) <- c('activityId','activityType')

colNames <- colnames(setAllInOne)

#Vector creation in ordet to define ID, mean and standard deviation

mean_and_std <- (grepl("activityId" , colNames) | 
                 grepl("subjectId" , colNames) | 
                 grepl("mean.." , colNames) | 
                 grepl("std.." , colNames) 
                )

# Required subset creation

setForMeanAndStd <- setAllInOne[ , mean_and_std == TRUE]

# Naming the activities in the data set using descriptive activity names

setWithActivityNames <- merge(setForMeanAndStd, activityLabels,
                              by='activityId',
                              all.x=TRUE)

# Making second tidy data set

secTidySet <- aggregate(. ~subjectId + activityId, setWithActivityNames, mean)
secTidySet <- secTidySet[order(secTidySet$subjectId, secTidySet$activityId),]

write.table(secTidySet, "tidy.txt", row.name=FALSE)

