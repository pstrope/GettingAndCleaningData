# GettingAndCleaningData

This script needs to be in the same folder where the data folder "UCI HAR Dataset" resides.

To run the script do:

source("run_analysis.R")


The final output is called project_output.txt

To read the output file in R, use the following command:

data<-read.table("./project_output.txt", header=TRUE)

View(data)

The run_analysis.R script does the following:
It reads the traning and train dataset from the "UCI HAR Dataset" folder.
It then merges the data from train and test (subject_train.txt + subject_test.txt = subject_both; X_train.txt + X_test.txt = X_both; y_train.txt + y_test.txt=y_both).

It then reads the activity labels, and feature names. It selects only those features that we want (mean and std) and saves in extract_features as a logical vector.
It then assigns the entire feature names to X_both.
Then it makes a smaller dataset from X_both called X_both_small which contains the columns that are TRUE in extract_features. 
Then it creates the activity labels vector y_both2 that has the activity description (1 of the 6 activities).
Then it merges the subject_both, y_both, y_both2, and X_both_small.
 
The first three columns has no names so far, so at this point the three column names are added. Then it carries out the function melt() to melt the dataset so that it can be decast() to group the data by subject and activity_description. 

Finally the data is written to a file. 
  

