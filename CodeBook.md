---
title: "CodeBook.md"
author: "YM"
date: "Sunday, November 23, 2014"
output: html_document
---

### Data sources

1. Download source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Extract data files and directories 

### Analysis steps taken on raw data

1. Prep steps - following 2 preparatory steps are taken: 
    + Read features data lables from 'features.txt' file
    + Read activity labels from 'activity_labels.txt' file
    

    a. Read features data lables
    
        'featureFinalDT' variable stores subset of mean() and std() features, along with their order(or index) number. 
        'featureFinalDT' has 2 columns namely - "SrNo" and "Feature".  
        "SrNo" column stores order(or index) number of given feature.  It is used to subset test and train datasets later, as we have to consider only mean and stand deviation features.   
        "Feature" column stores labels for mean and standard deviation features. Examples of features are given below: 
        + tBodyAcc-mean()-X
        + tBodyAcc-mean()-Y
        + tBodyAcc-mean()-Z
        + tBodyAcc-std()-X 
        + tBodyAcc-std()-Y
        + tBodyAcc-std()-Z
            
    
    b. Read activity labels
    
        'activityLabelDT' variables stores mapping between activity code and activity name.  It has 2 columns namely - "Activity_code" and "Activity_name".  Contents of 'activityLabelDT' are as given below: 
        + 1 WALKING
        + 2 WALKING_UPSTAIRS
        + 3 WALKING_DOWNSTAIRS
        + 4 SITTING
        + 5 STANDING
        + 6 LAYING 

      

2. step 1.a - build test dataset

    'testfeatureSubDT' variable stores features data read from 'test/X_test.txt' file.  Subset it taken by using SrNo in featureFinalDT variable (given above).  Subset has only mean and standard deviation data. 
    
    'testActivitySubDesc' variable stores activity description data.  It is done by doing look up against activityLabelDT, as it has both activity code and description (given above).  Raw data for activities is read from 'test/y_test.txt' file. 
    
    'testsubjectRawDT' variable stores subject numbers data; it is read from 'test/subject_test.txt' file. 
    
    Final TEST dataset 'finalTestDataset' is prepared by binding columns from 'testsubjectRawDT', 'testActivitySubDesc' and 'testfeatureSubDT'. 
    
          
    
3. step 1.b - build train dataset

    'trainfeatureSubDT' variable stores features data read from 'train/X_train.txt' file.  Subset it taken by using SrNo in featureFinalDT variable (given above).  Subset has only mean and standard deviation data. 
    
    'trainActivitySubDesc' variable stores activity description data.  It is done by doing look up against activityLabelDT, as it has both activity code and description (given above).  Raw data for activities is read from 'train/y_train.txt' file. 
    
    'trainsubjectRawDT' variable stores subject numbers data; it is read from 'train/subject_train.txt' file. 
    
    Final TRAIN dataset 'finalTrainDataset' is prepared by binding columns from 'trainsubjectRawDT', 'trainActivitySubDesc' and 'trainfeatureSubDT'.

      

4. step 2 - Merge training and test sets to create one data set

    'totalDataset' variable stores combined Train and Test dataset, from variables 'finalTrainDataset' and 'finalTestDataset'.  Train and Test data is combined by binding rows of given data sets.



5. step 3 - calculate mean for feature for subjct and activity

    'tidydataset' variable stores mean values for meand and standard deviation, after grouping data based on subject and activity.
    
      

6. Final step - Write tidy dataset to a file

    Finally 'tidydataset' variable is written to text file 'your_working_directory/data/output.txt'.
      
      

*end of document* 