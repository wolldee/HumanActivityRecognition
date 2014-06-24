### Human Activity Recognition data cleaning
        ### USAGE (How it works)

the fucntion can be called without any parameters then teh difault directory will be the WD. the folder containing the data set should not be renamed and should be in the working directory and pointed passing the directory as string(should not be terminated by "/").

The script requires the reshape2 package if it is not istall it will return a message an stops.

* first the features and the activity labels are loaded.
no changes are made to them

* the test &train data set is then loaded using the features as columne names with the test labels and the subjects labels.

* the test & train labels and the subject labels are added to the data set using cbind

* the columnes are the labeled using descriptive names

* both test and train data set are then merged

* the measurements on the mean and standard deviation for each measurement are extracted in a new variable

* The activity factor is then renamed using descriptive labels 

* the data set is casted expressing the mean of each variable for each subject and activity.

* the new data set is returned in a data frame as well as a txt file

