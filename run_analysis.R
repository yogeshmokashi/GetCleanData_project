library(data.table)
library(plyr)
library(reshape2)

## Make sure that working directory is set correctly.  This program assumes
## that 'test' and 'train' directories are present in working directory/data.


run_analysis <- function() {
    
    # -------------------------------------------------------------------------
    # start - Prep steps
    # -------------------------------------------------------------------------
    # Read list of all features; take subset of mean() and std() features
    featureText <- readLines(".\\data\\features.txt")
    
    featureDT <- read.table(text=featureText, strip.white=TRUE)
    colnames(featureDT) <- c("SrNo", "Feature")
    
    tobeselected <- which(grepl("-mean", featureDT$Feature) | 
                              grepl("-std", featureDT$Feature))
                        
    featureSubDT <- featureDT[tobeselected, ]
    
    # remove meanFreq() features, which got selected with 'mean' string
    toberemoved <- which(grepl("-meanFreq", featureSubDT$Feature))
    
    featureFinalDT <- featureSubDT[-toberemoved, ]
    
    # clean up of variables
    rm(featureText)
    rm(featureDT)
    rm(featureSubDT)
    
    # -------------------------------------------------------------------------
    
    # Read activity labels 
    activityLabelText <- readLines(".\\data\\activity_labels.txt")
    
    activityLabelDT <- read.table(text=activityLabelText, strip.white=TRUE)
    colnames(activityLabelDT) <- c("Activity_code", "Activity_name")
    
    # clean up of variables
    rm(activityLabelText)
    
    # -------------------------------------------------------------------------
    # end - Prep steps
    # -------------------------------------------------------------------------

    
    # -------------------------------------------------------------------------
    # start - step 1.a - build test dataset
    # -------------------------------------------------------------------------
    
    # Read features data for 'test dataset' 
    testfeatureText <- readLines(".\\data\\test\\X_test.txt")
    
    testfeatureRawDT <- read.table(text=testfeatureText, strip.white=TRUE)
    
    # extract only mean and standard deviation values
    # featureFinalDT denotes only mean and standard deviation values
    testfeatureSubDT <- testfeatureRawDT[, featureFinalDT$SrNo]
    
    colnames(testfeatureSubDT) <- featureFinalDT$Feature
    
    # clean up of variables
    rm(testfeatureText)
    rm(testfeatureRawDT)
    
    #####summary(testfeatureText) -- Length 2947 
    # -------------------------------------------------------------------------
    
    # Read activity data for 'test dataset' 
    testactivityText <- readLines(".\\data\\test\\y_test.txt")
    
    testactivityRawDT <- read.table(text=testactivityText, strip.white=TRUE)
    
    # set column name
    setnames(testactivityRawDT, 1, "Activity_code")
    
    # clean up of variables
    rm(testactivityText)
    
    # Loopup Activity code and Activity lable to have descriptive activity name
    lookup = data.frame(
                    Activity_code=activityLabelDT$Activity_code,
                    Activity_name=activityLabelDT$Activity_name)
    
    testActivityDesc = join(testactivityRawDT, lookup, by='Activity_code')
    
    # select only Descriptive Activity names for adding in TEST dataset
    testActivitySubDesc <- as.data.table(testActivityDesc$Activity_name)
    # set column name
    setnames(testActivitySubDesc, 1, "Activity_description")

    # clean up of variables
    rm(lookup)
    rm(testActivityDesc)
    
    ####summary(testactivityText) -- Length 2947
    
    # -------------------------------------------------------------------------
    
    # Read subject data for 'test dataset' 
    testsubjectText <- readLines(".\\data\\test\\subject_test.txt")
    
    testsubjectRawDT <- read.table(text=testsubjectText, strip.white=TRUE)
    
    setnames(testsubjectRawDT, 1, "Subject_number")
    
    # -------------------------------------------------------------------------
    
    # Prepare test dataset with subject, activity and features information
    finalTestDataset <- cbind(testsubjectRawDT, 
                              testActivitySubDesc, 
                              testfeatureSubDT)
    
    
    # clean up of variables
    rm(testsubjectText)
    rm(testsubjectRawDT)
    rm(testActivitySubDesc)
    rm(testfeatureSubDT)
    
    #head(finalTestDataset)
    
    ####length(testsubjectText) -- Length 2947
    
    # -------------------------------------------------------------------------
    # end - step 1.a - build test dataset
    # -------------------------------------------------------------------------


    # -------------------------------------------------------------------------
    # start - step 1.b - build train dataset
    # -------------------------------------------------------------------------
    
    # Read features data for 'train dataset' 
    trainfeatureText <- readLines(".\\data\\train\\X_train.txt")
    
    trainfeatureRawDT <- read.table(text=trainfeatureText, strip.white=TRUE)
    
    # extract only mean and standard deviation values
    # featureFinalDT denotes only mean and standard deviation values
    trainfeatureSubDT <- trainfeatureRawDT[, featureFinalDT$SrNo]
    
    colnames(trainfeatureSubDT) <- featureFinalDT$Feature
    
    #####print(summary(trainfeatureText)) #-- Length 7352 
    
    # clean up of variables
    rm(trainfeatureText)
    rm(trainfeatureRawDT)
    
    # -------------------------------------------------------------------------
    
    # Read activity data for 'train dataset' 
    trainactivityText <- readLines(".\\data\\train\\y_train.txt")
    
    trainactivityRawDT <- read.table(text=trainactivityText, strip.white=TRUE)
    
    # set column name
    setnames(trainactivityRawDT, 1, "Activity_code")
    
    ####print(summary(trainactivityText)) #-- Length 7352    
    
    # clean up of variables
    rm(trainactivityText)
    
    # Loopup Activity code and Activity lable to have descriptive activity name
    lookup = data.frame(
        Activity_code=activityLabelDT$Activity_code,
        Activity_name=activityLabelDT$Activity_name)
    
    trainActivityDesc = join(trainactivityRawDT, lookup, by='Activity_code')
    
    # select only Descriptive Activity names for adding in Train dataset
    trainActivitySubDesc <- as.data.table(trainActivityDesc$Activity_name)
    # set column name
    setnames(trainActivitySubDesc, 1, "Activity_description")
    
    # clean up of variables
    rm(lookup)
    rm(trainActivityDesc)
    
    # -------------------------------------------------------------------------
    
    # Read subject data for 'train dataset' 
    trainsubjectText <- readLines(".\\data\\train\\subject_train.txt")
    
    trainsubjectRawDT <- read.table(text=trainsubjectText, strip.white=TRUE)
    
    setnames(trainsubjectRawDT, 1, "Subject_number")
    
    ###print(length(trainsubjectText)) #-- Length 7352    
    
    # -------------------------------------------------------------------------
    
    # Prepare train dataset with subject, activity and features information
    finalTrainDataset <- cbind(trainsubjectRawDT, 
                               trainActivitySubDesc, 
                               trainfeatureSubDT)
    
    # clean up of variables
    rm(trainsubjectText)
    rm(trainsubjectRawDT)
    rm(trainActivitySubDesc)
    rm(trainfeatureSubDT)
    
    
    #head(finalTrainDataset)
    # -------------------------------------------------------------------------
    # end - step 1.b - build train dataset
    # -------------------------------------------------------------------------
    
    
    # -------------------------------------------------------------------------
    # start - step 2 - Merge training and test sets to create one data set
    # -------------------------------------------------------------------------
    
    totalDataset <- data.table(rbind(finalTrainDataset, finalTestDataset))
    
    # clean up of variables
    rm(finalTrainDataset)
    rm(finalTestDataset)
    
    #print(str(totalDataset))
    # -------------------------------------------------------------------------
    # end - step 2 - Merge training and test sets to create one data set
    # -------------------------------------------------------------------------
    
    # -------------------------------------------------------------------------
    # start - step 3 - calculate mean for feature for subjct and activity
    # -------------------------------------------------------------------------
    
    molten <- melt(totalDataset, 
                   id.vars = c("Subject_number", "Activity_description"))
    
    tidydataset <- dcast(molten, 
                         Subject_number + Activity_description ~ variable, 
                         fun = mean)
    
    # -------------------------------------------------------------------------
    # end - step 3 - calculate mean for feature for subjct and activity
    # -------------------------------------------------------------------------

    #print(tail(tidydataset))
    
    # -------------------------------------------------------------------------
    # start - Final step - Write tidy dataset to a file
    # -------------------------------------------------------------------------
    write.table(tidydataset, file = ".\\data\\output.txt", row.names = FALSE)
    # -------------------------------------------------------------------------
    # end - Final step - Write tidy dataset to a file
    # -------------------------------------------------------------------------

}