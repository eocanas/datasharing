---
title: "README"
author: "Elva Ocanas"
date: "Friday, December 19, 2014"
---
Course Project #1 -- Script in R

Getting and Cleaning Data
Code: getdata-016

Original Data: 

- Human Activity Recognition Using Smartphones Dataset 
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto. 
Smartlab - Non Linear Complex Systems Laboratory 
DITEN - Universit√  degli Studi di Genova, Genoa I-16145, Italy. 
activityrecognition
www.smartlab.ws 

Data Set Information:

- The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. (From: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)

- The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. (From: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#)

Inner works of the script:
- The script grabs the files previously unzippped in the same directory.
- Two data sets (train and test) dispersed in six diferentes .txt files were merged and the means of measured variables of mean and SD calculated.
- Variables in the main data.table received proper labels.
- Descriptive names were given to the Activities column in the data set.
- The final data.table contains an observation per initial variable by Subject, Type and Activity.
- The file created for submission is named "full_report.txt" and is created in the same directory where the run_analysis.R is run from. 
- The inner work of the script is detailed in the CodeBook.md.

Assumptions:
- The identification of the variables (mean and sd) were done in accordande to the name of the variables found in features.txt, that's why the order of the variables in that document was taken as correct, measures where taken to keep the x-train and x-test documents without modification.
- meanFreq, althought carries the word "mean" was considered as another kind or measure that should not be covered by this report.
- The data is already unzipped in the same directory where the script is run.

Complete list of files:
README.md : this file
codebook.md : a file describing the inner work of the script
run_analysis.R : an R executable file

Tested under:
Windows 8.1-64bits running over Bootcamp 3.2
RStudio Version 0.98.1091 - © 2009-2014 RStudio, Inc.
R version 3.1.2 (2014-10-31) -- "Pumpkin Helmet"
Copyright (C) 2014 The R Foundation for Statistical Computing
Platform: x86_64-w64-mingw32/x64 (64-bit)
