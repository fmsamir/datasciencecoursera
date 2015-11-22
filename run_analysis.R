## The following script retrieves data from the UCI HAR Dataset. The test and
## train datasets are combined, data on the mean and standard deviation of each
## measurement are extracted, descriptive activity names are added, and
## descriptive variable names are added as labels. A tidy dataset is then
## created with means for each variable for each activity and each subject, and
## subsequently written to a txt file.

# The plyr and dplyr packages are loaded to make use of certain functions.
library(plyr)
library(dplyr)

# The data files are loaded into R.
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt")
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt")
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")
activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# The subject and activity data are added as columns to the left of the data
# containing the other variables.
testcomplete <- cbind(subjecttest, ytest, xtest)
traincomplete <- cbind(subjecttrain, ytrain, xtrain)

# The test and training data are merged to form a single dataset.
har <- rbind(testcomplete, traincomplete)

# The variable names are extracted from the "features" data and used to label
# the columns of the dataset.
varnames <- as.character(features[, 2])
colnames(har) <- c("Subject", "Activity", varnames)

# The grep function finds columns which contain the strings "mean()" and
# "std()" and an index is created with these column numbers. The index is then
# used to select the columns and drop all others to form a new dataset.
mean <- grep("\\bmean()\\b", varnames) + 2
std <- grep("\\bstd()\\b", varnames) + 2
index <- sort(c(1, 2, mean, std))
mshar <- har[, index]

# The mapvalues functions uses the "activity_labels" data to reassign the
# Activity column to carry meaningful names rather than representative numbers.
acthar <- mapvalues(mshar$Activity, activities[, 1], 
                    as.character(activities[, 2]))
basehar <- mutate(mshar, Activity = acthar)

# The dataset is rearranged based in ascending order of subject number, then
# activity name.
sorthar <- arrange(basehar, Subject, Activity)

# The data is grouped by subject and by activity, then the mean function is
# applied to all other variables for each group, giving the aggregate means
# for the measurements per group in a tidy dataset.
grouphar <- group_by(sorthar, Subject, Activity)
tidyhar <- summarise_each(grouphar, funs(mean))

# The tidy dataset is written to a txt file.
write.table(tidyhar, "./getdata-project-tidydataset.txt", row.names = FALSE)