### Readme.md

Note: the scripts mentioned below: getting_data.r and run_analysis.r, both reside in the Scripts subfolder.

Assignment:
You should create one R script called run_analysis.R that does the following. 

1.    Merges the training and the test sets to create one data set.
2.    Extracts only the measurements on the mean and standard deviation for each measurement. 
3.    Uses descriptive activity names to name the activities in the data set
4.    Appropriately labels the data set with descriptive variable names. 
5.    Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

I first retrieved the data via getting_data.r, a separate file as this wasn't requested in the assignment.

The scripts reads both datasets (X and y) for the train and the test data.
Next it creates one big set for the X data and one big set for the y data.
In the next step he reads the subject data for both train and test and turns them into one dataset.
At this point the distinction between train and test data is no longer present.

I now read the column names from a file and copy them on the column names of the measurements table: x_ds.  I assign 'subject' as the subjects_ds column name.

As only mean and standard deviation columns are required, I gather the relevant column names in two variables and project only these columns of the dataset in a new variable.

I now join the three tables into a big one (ds) and give the last cryptic column name a more readable one: activitycode.

To translate all these activity codes, I read the mapping from activity_labels.txt into a dataset and give the description the header 'activity'.  I don't do this for the code column, but this one is only joined on in the next step and immediately thrown away.

The only thing left to do is, calculating the average per person and activity, which is done by the aggregate function and the result is written to the tidydataset.txt file.

The Codebook describes all columns of this dataset.