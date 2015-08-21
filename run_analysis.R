##read all the relevent documents which were downloaded in my laptop
trainx<-read.table("/Users/cz/Downloads/UCI HAR Dataset/train/X_train.txt")
trainy<-read.table("/Users/cz/Downloads/UCI HAR Dataset/train/Y_train.txt")
trains<-read.table("/Users/cz/Downloads/UCI HAR Dataset/train/subject_train.txt")
testx<-read.table("/Users/cz/Downloads/UCI HAR Dataset/test/X_test.txt")
testy<-read.table("/Users/cz/Downloads/UCI HAR Dataset/test/Y_test.txt")
tests<-read.table("/Users/cz/Downloads/UCI HAR Dataset/test/subject_test.txt")
features<-read.table("/Users/cz/Downloads/UCI HAR Dataset/features.txt")

##check all the tables dimensions
dim(trainx)
dim(trainy)
dim(trains)
dim(features)
dim(testx)
dim(testy)
dim(tests)

##features contains all the name of measurements.descriptive variable names will be added at first. 
head(features)
class(features$V2)
##V2 are factors,can not be used as column names directly
title<-as.character(features$V2)
colnames(trainx)<-title

##testx's column names will be changed as trainx
  colnames(testx)<-title
  
##change the rest tables' column names. not necessary, but easy to read 
colnames(trains)<-"subject"
colnames(trainy)<-"activity"
colnames(tests)<-"subject"
colnames(testy)<-"activity"

##bind all the tables together
trainset<-cbind(trains,trainy,trainx)
testset<-cbind(tests,testy,testx)
whole<-rbind(trainset,testset)

##not necessary, but it shows the difference after validate the column names
names(whole)

library(dplyr)
##can not directly "select" certain columns, because the column names are not legitimate 
valid_column_names <- make.names(names=names(whole), unique=TRUE, allow_ = TRUE)
names(whole) <- valid_column_names
names(whole)

##"mean()" and "std()" in the original table are transformed into "mean.." and "std..".according to README.txt, only these two kind of variable are qualified
meanstd<-select(whole,contains("subject"),contains("activity"),contains("mean..",ignore.case = FALSE),contains("std..",ignore.case = FALSE))

dim(meanstd)
meanstd[1:6,1:6]
##there are 68 columns. 66 are for means and stds, and the first two are "subject" and "activity". "subject is not necessary for step 4, but it is useful for the finall task.

##activity_labels.txt contains all the six activity names, which should be used to replace the contains of the second column of "meanstd"
activitylables<-gsub("6","LAYING",gsub("5","STANDING",gsub("4","SITTING",gsub("3","WALKING_DOWNSTAIRS",gsub("2","WALKING_UPSTAIRS",gsub("1","WALKING",meanstd$activity))))))
meanstd$activity<-activitylables
##the talbe of "meanstd" now meets the requirements in the first 4 steps of the project

##every measurements for different subjects' activities are listed in "meanstd". the first two columns specify subjects and activites, which should be exclued when we calculate the means.
subject_activity_mean<-aggregate(x = meanstd[,c(3:68)], by = list(c(meanstd$subject),c(meanstd$activity)), FUN = "mean"))

write.table(subject_activity_mean,file="tidy_data.txt",row.name=FALSE) 
