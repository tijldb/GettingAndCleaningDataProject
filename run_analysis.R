# Tijl De Backer
# debacker.tijl@gmail.com
# 
# Course:
# Getting and Cleaning Data
#
# Assignment

# You should create one R script called run_analysis.R that does the following. 

# 0. First check if the data is available (if X_train.txt exists, all are supposed to)
if (!file.exists('X_train.txt')) {
	source('getting_data.R')
}

# 1. Merges the training and the test sets to create one data set.

# read training set
x_train<-read.table('X_train.txt',header=FALSE)
y_train<-read.table('y_train.txt',header=FALSE)

# read test set
x_test<-read.table('X_test.txt',header=FALSE)
y_test<-read.table('y_test.txt',header=FALSE)

# union training and test (once for X and once for y)
x_ds <- rbind(x_train, x_test)
y_ds <- rbind(y_train, y_test)

# read both subject tables and union them
subject_train <- read.table('subject_train.txt',header=FALSE)
subject_test <- read.table('subject_test.txt',header=FALSE)
subject_ds <- rbind(subject_train, subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 

# read features and assign the feature names to the column names of x_ds (answer to question 4)
colnames <- read.table('features.txt')
names(x_ds) <- colnames[,2]
names(subject_ds)[1] = 'subject'	

# select columns to filter
mean_cols <- grep('mean()',colnames$V2,fixed=TRUE)
std_cols <- grep('std()',colnames$V2,fixed=TRUE)

# double checking the columns filter
names(x_ds)[sort(c(mean_cols,std_cols))]

# project only the relevant columns
x_mean_std <- x_ds[,sort(c(mean_cols,std_cols))]

# merge all three datasets on position
ds<- cbind(subject_ds,y_ds,x_mean_std)

# 3. Uses descriptive activity names to name the activities in the data set
activity_ds <- read.table('UCI HAR Dataset/activity_labels.txt')
names(activity_ds)[2] = 'activity'
ds <- merge(activity_ds, ds, sort=FALSE)[2:69]

# 4. Appropriately labels the data set with descriptive variable names. 

# descriptive activity names have been set in the first part of 2

# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

# create tidy dataset
# tidy_ds <- aggregate(ds,by=list(subject=ds$Subject,activity=ds$activity),FUN=mean)[,c(1:2,5:70)]
ds$subject <- as.factor(ds$subject)
tidy_ds <- aggregate(. ~ activity + subject,ds,mean)

# write data sets in files
write.table(tidy_ds,"tidydataset.txt",row.names=FALSE)
# write.table(ds,"fulldataset.txt",row.names=FALSE) ' Not required

