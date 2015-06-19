
setwd("C:\\workingOn\\Coursera\\DataCleaning\\DataCleaningProject\\UCI HAR Dataset")



train_subject <- read.table(file="train/subject_train.txt",stringsAsFactors=TRUE, header=FALSE)
train_x <- read.table(file="train/X_train.txt", header=FALSE)
train_y <- read.table(file="train/y_train.txt", header=FALSE)
trainset<-cbind(train_subject, train_y, train_x)

test_subject <- read.table(file="test/subject_test.txt",stringsAsFactors=TRUE, header=FALSE)
test_x <- read.table(file="test/X_test.txt", header=FALSE)
test_y <- read.table(file="test/y_test.txt",  header=FALSE)
testset<-cbind(test_subject, test_y, test_x)

fulldataset<-rbind(trainset, testset)

features_labels <- read.table(file="features.txt", col.names=c("id","text"), stringsAsFactors=FALSE,header=FALSE)
col_names<-features_labels[,2]
all_col<-c("Subject", "Activity", features_labels[,2])

colnames(fulldataset)<-all_col

activity_labels <- read.table(file="activity_labels.txt", col.names=c("id","text"), stringsAsFactors=FALSE,header=FALSE)

for(i in 1:nrow(activity_labels)) {
    fulldataset[fulldataset$Activity == i, 'Activity'] <- activity_labels[i,"text"]
}


cols_needed<-c("Subject", "Activity", all_col[grep("(.*mean.*)|(*.std.*)", all_col, ignore.case=TRUE)])

final_dataset<-fulldataset[cols_needed]

write.table(final_dataset, "C:/workingOn/Coursera/DataCleaning/DataCleaningProject/mean_std.txt", row.names=FALSE)



#body_acc_x_train<- read.table(file="train/Inertial Signals/body_acc_x_train.txt", header=FALSE)