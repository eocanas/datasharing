
---
title: "CodeBook"
date: "Friday, December 19, 2014"
---


--------------------------------
  Description of the variables 
--------------------------------



All the observations on the xtrain and xtest original databases come from the lectures of accelerometer and gyroscope of a specific cell phone model in the X, Y and Z axis. Some of the raw signals were already processed and are marked by an abbreviation at the end of the column names. The processed data includes the mean, the sd, the max, the min, etc. From those proccessed measurements the mean and the standard deviation where isolated and manipulated to create the report.
The complete set of variable's names is found in the "feature.txt" 

From the original set, 73 variables were isolated, given unique names using make.names 


   -- Variables Names:   

tBodyAcc-mean()-X	
tBodyAcc-mean()-Y	
tBodyAcc-mean()-Z	
tBodyAcc-std()-X	
tBodyAcc-std()-Y	
tBodyAcc-std()-Z	
tGravityAcc-mean()-X	
tGravityAcc-mean()-Y	
tGravityAcc-mean()-Z	
tGravityAcc-std()-X	
tGravityAcc-std()-Y	
tGravityAcc-std()-Z	
tBodyAccJerk-mean()-X	
tBodyAccJerk-mean()-Y	
tBodyAccJerk-mean()-Z	
tBodyAccJerk-std()-X	
tBodyAccJerk-std()-Y	
tBodyAccJerk-std()-Z	
tBodyGyro-mean()-X	
tBodyGyro-mean()-Y	
tBodyGyro-mean()-Z	
tBodyGyro-std()-X	
tBodyGyro-std()-Y	
tBodyGyro-std()-Z	
tBodyGyroJerk-mean()-X	
tBodyGyroJerk-mean()-Y	
tBodyGyroJerk-mean()-Z	
tBodyGyroJerk-std()-X	
tBodyGyroJerk-std()-Y	
tBodyGyroJerk-std()-Z	
tBodyAccMag-mean()	
tBodyAccMag-std()	
tGravityAccMag-mean()	
tGravityAccMag-std()	
tBodyAccJerkMag-mean()	
tBodyAccJerkMag-std()	
tBodyGyroMag-mean()	
tBodyGyroMag-std()	
tBodyGyroJerkMag-mean()	
tBodyGyroJerkMag-std()	
fBodyAcc-mean()-X	
fBodyAcc-mean()-Y	
fBodyAcc-mean()-Z	
fBodyAcc-std()-X	
fBodyAcc-std()-Y	
fBodyAcc-std()-Z	
fBodyAccJerk-mean()-X	
fBodyAccJerk-mean()-Y	
fBodyAccJerk-mean()-Z	
fBodyAccJerk-std()-X	
fBodyAccJerk-std()-Y	
fBodyAccJerk-std()-Z	
fBodyGyro-mean()-X	
fBodyGyro-mean()-Y	
fBodyGyro-mean()-Z	
fBodyGyro-std()-X	
fBodyGyro-std()-Y	
fBodyGyro-std()-Z	
fBodyAccMag-mean()	
fBodyAccMag-std()	
fBodyBodyAccJerkMag-mean()	
fBodyBodyAccJerkMag-std()	
fBodyBodyGyroMag-mean()	
fBodyBodyGyroMag-std()	
fBodyBodyGyroJerkMag-mean()	
fBodyBodyGyroJerkMag-std()	
angle(tBodyAccJerkMean),gravityMean)	
angle(tBodyGyroMean,gravityMean)	
angle(tBodyGyroJerkMean,gravityMean)	
angle(X,gravityMean)	
angle(Y,gravityMean)	
angle(Z,gravityMean)	


---------
  Data 
---------

The original data is as follows:

.\ getdata-projectfiles-UCI HAR Dataset\ UCI HAR Dataset\ test

  --"subject_test"
  
    -Subject ID (1:30 )
    
  -- "X_test"
  
    - Raw and processed initial data
    
  -- "y_test"
  
    - Activity (1:6) Description found in \ getdata-projectfiles-UCI HAR Dataset\ UCI HAR Dataset\ activity_labels.txt 
    ("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING", "STANDING", "LAYING")

.\ getdata-projectfiles-UCI HAR Dataset\ UCI HAR Dataset\ train

  --"subject_test"
  
    -Subject ID (1:30 )
    
  -- "X_test"
  
    - Raw and processed initial data
    
  -- "y_test"
  
    - Activity (1:6) Description found in \ getdata-projectfiles-UCI HAR Dataset\ UCI HAR Dataset\ activity_labels.txt 
    ("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING", "STANDING", "LAYING")


-------------------
  Transformations
-------------------

In order to transform the data the following libraries were used:

```r
  library(tidyr)
  library(data.table)
  library(plyr)
  library(dplyr)
  library(reshape2)
```
The script runs under the assumption that the data has been unzipped in the same directory.
The next step is to get the information, I used the number of rows to match data.
 
 - Data with 7352 rows (Subject, activity and measures, in that order):

```r 
  strain<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train/subject_train.txt", sep="", header = F) #7352x1
  ytrain<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train/y_train.txt", sep="", header = F) #7352x1
  xtrain<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//train/X_train.txt", sep="", header = F) #7352x561
```
 - Data with 2947 rows(Subject, activity and measures, again, in that order):

```r 
  stest<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//subject_test.txt", sep="", header = F) #2947x1 
  ytest<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//y_test.txt", sep="", header = F)  #2947x1
  xtest<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//test//x_test.txt", sep="", header = F) #2947x561
```  
The original data has no column names, in order to solve that, we need the data from "features.txt".

```r  
  features<-read.table("getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset//features.txt", sep="", header = F)
  names<-make.names(as.character(features$V2), unique=T)
```r

Following that, I renamed the columns and added the extra column to differentiate test from training, since they are two different sources of data and should not be confused.

```r
  strain[,2]<-rep("Train",nrow(strain))
  stest[,2]<-rep("Test",nrow(stest))
  
  colnames(xtrain)<-names
  colnames(xtest)<-names
  colnames(ytest)<-"Activity"
  colnames(ytrain)<-"Activity"
  colnames(stest)<-c("Subject","Type")
  colnames(strain)<-c("Subject","Type")
```  
There was a first bind, by column, now there is no confusion to which data came from train or test.

```r
  train<-cbind(strain, ytrain, xtrain)## dimensions: 7352x564
  test <-cbind(stest, ytest, xtest) ## dimensions: 2947x564
```

Along the script there are several cleanups to free the memory, all of them similar to this:

```r
  rm(list=c("xtrain","xtest","ytrain","ytest","names","features", "strain", "stest"))
```

A final binding, by column, get this closer to a result. Both "train" and "test" get together to fomr a 10299x564 data.frame. 

```r  
  final <- rbind(test,train) ## They match columns by now. Dimensions: 10,299x564
```

The function select gets rid of all the columns we no longer need, leaving only the 73 variables mentioned in the list of this document.

```r
  data<- select(final, 1:3,-contains("freq"), contains("mean"), contains("std")) ## Results in 10299x76
```

In order to use the data.table library we need to convert the data.frame to a data.table. The arrange function can be used to order the data by Subject, then by Type, then by Activity 

```r
  data<- as.data.table(data) ## Conversion to data.table
  data<- arrange(data, data$Subject, data$Type, data$Activity) #Order by Subject then Activity
```  
Once the data.table is ordered we can apply the descriptive names to the Activity variable.

```r
  data$Activity <- factor(data$Activity, labels = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING",
                                                   "STANDING", "LAYING"))
```
  
Lapply is used along the .SD subset tool to apply the mean function to each column except those columns called in "by" ("Subject","Type","Activity")

```r
  datamean <- data[,lapply(.SD, mean),by=c("Subject","Type","Activity")] ## Filtering and subsetting
``` 

To create the full_report the function ```{r}melt``` was used to transform each column value into individual observations.

```r  
  full_report<- melt(datamean, id.vars=c("Subject","Type", "Activity"), variable.name = "Variable", value.name = "Mean")
```  

The resulting report presents the mean of every initial variables (mean and sd) selected, distributed by type of Activity, by Subject and by type of observation (training or testing).
  
The last step (aside from the las cleanup) is to generate the required .txt file with the data proccessed.

```r 
  write.table(full_report, "full_report.txt", row.names=FALSE)
``` 
