 

  ## Libraries needed, it is assumed that corresponding packages have been downloaded
 
  library(tidyr)
  library(data.table)
  library(plyr)
  library(dplyr)
  library(reshape2)

  ## This assumes the data has been unzipped in the same directory
  
  ## Getting the data
  ## Data with 7352 rows (Subject, activity and measures, in that order)
  
  strain<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train/subject_train.txt", sep="", header = F) #7352x1
  ytrain<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train/y_train.txt", sep="", header = F) #7352x1
  xtrain<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train/X_train.txt", sep="", header = F) #7352x561

  ## Data with 2947 rows(Subject, activity and measures, again, in that order)
  
  stest<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//subject_test.txt", sep="", header = F) #2947x1 
  ytest<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//y_test.txt", sep="", header = F)  #2947x1
  xtest<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//x_test.txt", sep="", header = F) #2947x561
  
  ## Getting descriptions
  
  features<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//features.txt", sep="", header = F)
  names<-make.names(as.character(features$V2), unique=T)
  
  ## Renaming of columns, adding the extra column to differentiate test from training
  
  strain[,2]<-rep("Train",nrow(strain))
  stest[,2]<-rep("Test",nrow(stest))
  
  colnames(xtrain)<-names
  colnames(xtest)<-names
  colnames(ytest)<-"Activity"
  colnames(ytrain)<-"Activity"
  colnames(stest)<-c("Subject","Type")
  colnames(strain)<-c("Subject","Type")
  
  ## Binding
  
  train<-cbind(strain, ytrain, xtrain)## dimensions: 7352x564
  test <-cbind(stest, ytest, xtest) ## dimensions: 2947x564
  
  ## Clean up memory
  
  rm(list=c("xtrain","xtest","ytrain","ytest","names","features", "strain", "stest"))
  
  ## Final binding
  
  final <- rbind(test,train) ## They match columns by now. Dimensions: 10,299x564
  
  ## Cleanup
  
  rm(list=c("test","train"))
  
  ## Clearing of extra columns
  
  data<- select(final, 1:3,-contains("freq"), contains("mean"), contains("std")) ## Results in 10299x76
  
  ## Clean up
  
  rm(list=c("final"))
  
  ## Ordering
  
  data<- as.data.table(data) ## Conversion to data.table
  data<- arrange(data, data$Subject, data$Type, data$Activity) #Order by Subject then Activity
  
  ## Renaming of Activity's observations
  
  data$Activity <- factor(data$Activity, labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING",
                                                    "STANDING", "LAYING"))
  
  ## Lapply is used together with the .SD subset tool to apply the mean function to each column except those columns
  ## called in "by" 
  
  datamean <- data[,lapply(.SD, mean),by=c("Subject","Type","Activity")] ## Filtering and subsetting
  
  ## Melting of the database
  
  full_report<- melt(datamean, id.vars=c("Subject","Type", "Activity"), variable.name = "Variable", value.name = "Mean")
  
  ## The resulting report presents the mean of every initial variables (mean and sd) selected, distributed by 
  ## type of Activity, by Subject and by origin of the observation (training or testing).
  
  ## To TXT
  
  write.table(full_report, "full_report.txt", row.names=FALSE)
  
  ## Final cleanup
  
  rm(list=c("full_report","datamean","data"))
  
  