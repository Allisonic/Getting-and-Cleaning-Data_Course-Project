#set up work directory
setwd("C:\\Users\\SZXP0196\\Desktop\\Rdata\\UCI HAR Dataset")
#read train sets into the file
train.label<-read.table("C:\\Users\\SZXP0196\\Desktop\\Rdata\\UCI HAR Dataset\\train\\y_train.txt")
train.set<-read.table("C:\\Users\\SZXP0196\\Desktop\\Rdata\\UCI HAR Dataset\\train\\x_train.txt")
train.subject<-read.table("C:\\Users\\SZXP0196\\Desktop\\Rdata\\UCI HAR Dataset\\train\\subject_train.txt")
train_F<-data.frame(train.subject,train.label)
#read test sets into the file
test.label<-read.table("C:\\Users\\SZXP0196\\Desktop\\Rdata\\UCI HAR Dataset\\test\\y_test.txt")
test.set<-read.table("C:\\Users\\SZXP0196\\Desktop\\Rdata\\UCI HAR Dataset\\test\\x_test.txt")
test.subject<-read.table("C:\\Users\\SZXP0196\\Desktop\\Rdata\\UCI HAR Dataset\\test\\subject_test.txt")
test_F<-data.frame(test.subject,test.label)
#merge the training and test sets
alldata_F<-rbind(train_F,test_F)
alldata_BR<-rbind(train.set,test.set)
#extract the measurements on the mean and standard deviation
feature<-read.table("features.txt")
slct.feature<-grep("mean|std",feature$V2)
alldata_B<-alldata_BR[,slct.feature]
#label the variables with dscriptive names
names(alldata_B)<-feature[slct.feature,2]
names(alldata_F)<-c("Subject","Activity")
#name the activities in the data set
activitynames<-read.table("activity_labels.txt")
alldata_F$Activity<-activitynames[alldata_F$Activity,2]
#generate the full data set with subject and activities
alldata<-cbind(alldata_F,alldata_B)
#calculate the mean of each variable for each activity and subject
alldata_ave<-aggregate(alldata[,3:66],list(alldata$Subject,alldata$Activity),FUN=mean)
colnames(alldata_ave)[1:2]<-c("Subject","Activity")
#output the tidy data set
write.table(alldata_ave,file="alldate_ave.txt")