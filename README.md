# GettingAndCleaningData

This script needs to be in the same folder where the data folder "UCI HAR Dataset" resides.

To run the script do:

source("run_analysis.R")


The final output is called project_output.txt

To read the output file in R, use the following command:

data<-read.table("./project_output.txt", header=TRUE)

View(data)


