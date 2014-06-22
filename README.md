HumanActivityRecognition
========================

Name: Frantz Woldy AMAZAN

Getting and cleaning data Project

R script getting and cleaning data from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

         - USAGE

The fucntion can be called without any parameters then teh difault directory will be the WD. the folder containing the data set should not be renamed and should be in the working directory and pointed passing the directory as string(should not be terminated by "/").


* The function requires the reshape2 package if it is not istall it will return a message an stops.

* It returns the new data set in a dataframe and writes it in a txt file.

