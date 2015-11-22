# UCI HAR Tidy Dataset
Version 1.0
<br>
Faisal Samir
<br>
Coursera - Getting and Cleaning Data 015

## Introduction
The goal of this project is to collect data on human activity recognition using smartphones, which is publicly available in a dataset in the University of California, Irvine's archives, then transform the data into a particular form.
The data is to be cleaned by combining the disjoint datasets, selecting information only regarding the mean and standard deviation of the variables, giving activities descriptive names, labeling the variables with descriptive names, and creating a tidy dataset with the means of each variable per activity per subject.
<br>
<br>
The files submitted relevant to the project include:
<br>

* "getdata-project-tidydataset.txt": The tidy dataset text file produced after cleaning.
* "run_analysis.R": The R script which contains the commands needed to produce the dataset, as well as explanatory annotations.
* "CodeBook.md": A codebook which describes the variables contained in the dataset in detail.
* "README.md": This file, which explains the process of creating the aforementioned files and the reasoning behind the choices made for the project.

## Preparation
The data was obtained by downloading the .zip folder containing all of the relevant files directly from UCI's archives.
The files were then extracted into a folder named "UCI HAR Dataset" in my working directory.
The R script provided reflects that all files were read from this folder, and provided the .zip folder is extracted into the working directory, other users running the script should not come across any errors.
<br>
<br>
The "plyr" and "dplyr" R packages were installed to make use of the "mapvalues", "mutate", "arrange", "group\_by", and "summarise\_each" functions.

## Merging Datasets
The files containing the measurement variables were loaded into R ("X\_test.txt", "X\_train.txt"), along with those of the activity variable ("y\_test.txt", "y\_train.txt") and the subject variable ("subject\_test.txt", "subject\_train.txt").
Complete test and train datasets were first created by combining the "subject", "y", and "X" datasets for each respective test and train subset.
The test and train datasets were then merged to form a single dataset containing all relevant information about the HAR experiments.

## Labeling Variables
The subject and activity variables were manually given the names "Subject" and "Activity" respectively.
The "features.txt" file was used to create the variables names for the remainder of the dataset, by extracting the file's second column and assigning the elements to be the column names.
These names briefly and aptly describe the measurement denoted by each variable, and a full description is given in the codebook included in this project's portfolio.
<br>
<br>
A typing error which includes the string "Body" in some variable names twice, such as "fBodyBodyAccJerkMag-mean()" was left unaltered for the sake of consistency with the original dataset.

## Selecting Variables
The dataset was then modified to only include variables pertaining to the means and standard deviations of the measurements.
This was achieved by using a function to recognize the "mean()" and "std()" strings in the variable names and using an index of those strings to choose only the columns containing those variables, along with the subject and activity variables.
This results in the use of 68 variables consisting of the subject, activity, mean, and standard deviation variables.
<br>
<br>
The reason that variables strictly containing "mean()" and "std()" were chosen is that according to the "features_info.txt" file provided in UCI's .zip folder indicates that these are the variables that contain the means and standard deviations of the measurements.
Other variables may include "mean" in their names, but these are means of frequencies or means of calculations made in the experiments, not means of measurements, and so they are not included in the dataset.

## Describing Activities
The activity variable was modified to display descriptive names such as "LAYING", "SITTING", "WALKING", etc. rather than a number from 1 to 6.
To do so, the "activity_labels.txt" file was used to match each number with the appropriate name.
The activity column was then mutated from one of numbers to one of names.

## Aggregating Means
The dataset was first arranged in order of increasing subject number and by alphabetical activty name order.
Then, the dataset was grouped by subject and by activity.
A function was then applied to the dataset to find the mean of each variable per activity per subject.
The result is a dataset consisting of 180 observations, containing the means of each variable for each of the 6 activites as performed by each of the 30 subjects.

## Adherence to Tidy Data Principles
The dataset created is in compliance with the tidy data principles as proposed by Hadley Wickham in his paper, found at <a href="http://vita.had.co.nz/papers/tidy-data.pdf">this link</a>.
<br>
Accordingly, in tidy data:
<br>

* Each variable forms a column.
* Each observation forms a row.
* Each type of observational unit forms a table.
<br>
<br>
<br>
The dataset created by this project adheres to these statements as follows:
<br>

* The variables are all formed by columns, with no overlap between multiple variables in a single column and no variables in rows.
* Every observation, that is a single subject performing a single activity, is stored in a single row, with no overlap between multiple observations in a single row and no observations in columns.
* The only type of observational unit in this case is the aggregated means of means and standard deviations of measurements in the original datasets. Thus, only a single table is required to contain the dataset.
___

<br>
<br>
Faisal Samir - June 2015