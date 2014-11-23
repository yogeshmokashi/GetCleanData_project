---
title: "README.md"
author: "YM"
date: "Sunday, November 23, 2014"
output: html_document
---

### Code file names: 

1. run_analysis.R 
2. CodeBook.md

* run_analysis.R: This is only R code used to perform analysis.  One has to run
```
run_analysis()
```
after sourcing run_analysis.R at command prompt. 

* CodeBook.md: This file provides more information about code variables and steps taken to perform analysis. 

### Output file names: 

This program generates output file named 'output.txt' in 'your_working_directory_path/data' directory. 

### Prerequisits:

1. Make sure that working directory is set properly. 
2. This code expects that following directory / files are present in working directory: 
    + data directory
    + data/test directory - - with all necessary data files as in source data
    + data/train directory - - with all necessary data files as in source data
    + data/activity_labels.txt
    + data/features.txt


### Steps to run code for analysis:

1. Download source data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
2. Extract data files and directories as per structure mentioned in prerequisits above.
3. Set working directory, as per your path. 
```
setwd("C:\\<your_working_directory_path>")
```
4. Source run_analysis.R file. 
```
source('C:/<your_code_path>/run_analysis.R')
```
5. At command prompt, call function run_analysis() with no parameters. 
```
run_analysis()
```
6. Check for output file - output.txt in 'your_working_directory_path/data' directory. 

      
*end of document*
