
#
#    This script will clean the data provided in the data cleaning project and
#       produce a tidy data set.
#
#       There are four basic steps
#           1) Read the training data and create one training data frame
#           2) Read the test data and create one test data frame
#           3) Combine the two data sets, add labels and translate activity ids
#               into activity names.
#           4) Extract a tidy data set that includes only variables that are
#               mean or standard deviation caclulations.

# set a working directory and use relative paths for evertything else
setwd("C:\\workingOn\\Coursera\\DataCleaning\\DataCleaningProject")

#
# Step1: Read the training data and build one data set
#

#   Read the subject identifiers, these are numeric
train_subject <- read.table(file="UCI HAR Dataset/train/subject_train.txt",
                            stringsAsFactors=TRUE, header=FALSE)

#   Read the activity codes, these are numeric
train_y <- read.table(file="UCI HAR Dataset/train/y_train.txt", header=FALSE)

#   Read the raw data
train_x <- read.table(file="UCI HAR Dataset/train/X_train.txt", header=FALSE)

#   Join together all the columns from all three files inthe order:
#       subject id, activityid, variables
trainset<-cbind(train_subject, train_y, train_x)

#
# Step 2: Read the test data and build one data set
#

#   Read the training subject ids
test_subject <- read.table(file="UCI HAR Dataset/test/subject_test.txt",
                           stringsAsFactors=TRUE, header=FALSE)

#   Read the training data activity Ids
test_y <- read.table(file="UCI HAR Dataset/test/y_test.txt",  header=FALSE)

#   Read the training data raw data
test_x <- read.table(file="UCI HAR Dataset/test/X_test.txt", header=FALSE)

#   Join together all the columns from all three files inthe order:
#       subject id, activityid, variables
testset<-cbind(test_subject, test_y, test_x)

#
#  Step 3: Build the full data set, add labels and translate activty code to
#  activity names
#

#   Build one data frame by combining the rows of the traning and test
#   data frames
fulldataset<-rbind(trainset, testset)

#   Read the feature names to use as column labels
features_labels <- read.table(file="UCI HAR Dataset/features.txt",
                              col.names=c("id","text"),
                              stringsAsFactors=FALSE,header=FALSE)
col_names<-features_labels[,2]

#   Build a vector of colum names that includes the 'Subject' and 'Activity'
#   columns.
all_col<-c("Subject", "Activity", features_labels[,2])

#   Apply the column names to the full data set
colnames(fulldataset)<-all_col


#   Read the activity lables, these will be used to translate the activity codes to text.
activity_labels <- read.table(file="UCI HAR Dataset/activity_labels.txt",
                              col.names=c("id","text"),
                              stringsAsFactors=FALSE,header=FALSE)

#   Translate the activity ids to text strings
for(i in 1:nrow(activity_labels)) {
    fulldataset[fulldataset$Activity == i, 'Activity'] <- activity_labels[i,"text"]
}

#
#  Step4: Extract a tidy data set that includes only variables that are
#               mean or standard deviation caclulations.
#

# Build a list of columns names that we are going to extract. Use RegEx and
#  ignore case to be sure we get them all.
columns_needed<-c("Subject", "Activity",
                  all_col[grep("(.*mean.*)|(*.std.*)",
                  all_col,
                  ignore.case=TRUE)])

#  Create the smaller date set with just the column needed
smaller<-fulldataset[columns_needed]

# Columns used for grouping must be factors
smaller$Subject <- as.factor(smaller$Subject)
smaller$Activity <- as.factor(smaller$Activity)

# Collapse the data set as means around subject and activity
output_df<-aggregate(smaller[,3:86],by=smaller[c("Subject", "Activity")],
                     FUN=mean)

# sort by subject and then activity
output_df<-output_df[with(output_df, order(Subject, Activity)), ]

# show output
output_df[1:180,1:4]

#   Write the result to a text file
write.table(output_df, "tidy_dataset.txt",
            row.names=FALSE)




