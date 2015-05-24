#First read in the downloaded files (train and test) and merge them together
#Read the subjects and merge

library("reshape2")
a1<-read.table("./UCI HAR Dataset/train/subject_train.txt", sep="\t")
b1<-read.table("./UCI HAR Dataset/test/subject_test.txt", sep="\t")
subject_both<-rbind(a1,b1)


#Read the data and merge
a1<-read.table("./UCI HAR Dataset/train/X_train.txt")
b1<-read.table("./UCI HAR Dataset/test/X_test.txt")
X_both<-rbind(a1,b1)

#Read the activity label rows
a1<-read.table("./UCI HAR Dataset/train/y_train.txt")
b1<-read.table("./UCI HAR Dataset/test/y_test.txt")
y_both<-rbind(a1,b1)

#Descriptopn of activity
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]

#Description of variables, and select only those that have mean() or std() in it
features <- read.table("./UCI HAR Dataset/features.txt")[,2]
extract_features<-grepl("mean\\(|std\\(", features, perl=TRUE)

#Put in the feature names
names(X_both)=features
#Make smaller data table with only mean and std data
X_both_small<-X_both[,extract_features]

#Make rows of activity labels to match the total rows in y_both
y_both2<-activity_labels[y_both[,1]]

# Putting together the subject, activity, and data
test<-cbind(subject_both, y_both, y_both2, X_both_small)
#Put column names for the first three columns
names(test)[1]="subject"
names(test)[2]="activity_label"
names(test)[3]="activity_description"

#Measurable IDs
id_meas<-names(X_both_small)
#Non-measurable IDs
id_id<-c(names(test)[1], names(test)[2], names(test)[3])
#Melt the dataset
testmelt<-melt(test, id_id, id_meas)
#Dcast, grouping by subject and activity description
dtest1<-dcast(testmelt, subject+activity_description ~ variable, mean)
write.table(dtest1, "project_output.txt", row.name=FALSE)
