run_analysis <- function (directory = getwd()){
    
    if(!library(reshape2, logical.return=TRUE)){
        print("reshape2 package is needed to continue.")
        return
    }
    
    dataDir <- "/UCI HAR Dataset"
    trainDataDir <- "/train"
    testDataDir <- "/test"
    ## Loading necessary files
    
    features <- read.table(paste(directory, dataDir, "/features.txt", sep=""))
    activLab <- read.table(paste(directory, dataDir, "/activity_labels.txt", sep=""))
    ## Loading test data
    testData <- read.table(paste(directory, dataDir, testDataDir, "/X_test.txt", sep=""), col.names = features$V2)
    testLab  <- read.table(paste(directory, dataDir, testDataDir, "/y_test.txt", sep=""))
    subjTest <- read.table(paste(directory, dataDir, testDataDir, "/subject_test.txt", sep=""))
    ## Loading train data
    trainData <- read.table(paste(directory, dataDir, trainDataDir, "/X_train.txt", sep=""), col.names = features$V2)
    trainLab  <- read.table(paste(directory, dataDir, trainDataDir, "/y_train.txt", sep=""))
    subjTrain <-read.table(paste(directory, dataDir, trainDataDir, "/subject_train.txt", sep=""))
    
    ##binding subject and Activity and giving descriptive name to variables
    
    testData <- cbind(testData, subjTest$V1)
    names(testData)[length(names(testData))] <- "subject"
    testData <- cbind(testData, testLab$V1)
    names(testData)[length(names(testData))] <- "Activity"
    
    trainData <- cbind(trainData, subjTrain$V1)
    names(trainData)[length(names(trainData))] <- "subject"
    trainData <- cbind(trainData, trainLab$V1)
    names(trainData)[length(names(trainData))] <- "Activity"
    
    ## Merging both data sets
    
    test_N_Train <- merge(trainData, testData, all=TRUE)
    
    ## Extracting only the measurements on the mean and standard deviation for each measurement
    
    test_N_Train_mean_std <- test_N_Train[,grep("mean|std", features$V2, ignore.case=T)]
    
    ## Naming the activity using the activity name
    
    test_N_Train$Activity <- factor(test_N_Train$Activity, activLab$V1, activLab$V2)
    
    test_N_Train$subject <- as.factor(test_N_Train$subject)
    ## creating a new data set with the mean of each variable for each subject and each activity
    molt_test_N_Train <- melt(test_N_Train, c("subject", "Activity"), measure.var=names(test_N_Train)[1:561])
    
    av_by_act_N_subj <- dcast(molt_test_N_Train, subject + Activity ~ variable, mean, margins=names(test_N_Train)[1:561])
    ## Writing the new data set to a csv file
    filename <- paste(directory, "/av_var_by_act_N_sub.csv", sep="")
    write.csv(av_by_act_N_subj, file=filename, quote=TRUE, dec=".", row.names=TRUE,col.names=TRUE)
    #returning the new data set
    av_by_act_N_subj
}