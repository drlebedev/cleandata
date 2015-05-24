##
#  Init function is used to prepare data and env for clean/analyze
#   data folder could be set via init parameter "project_folder"
#   function returns unpacked data folder
##
init <- function(project_folder = "~/activity_recognition/") {

    ##
    # initlibs installs/loads packages required for data clean.
    ##
    initlibs <- function() {
        if (!("dplyr" %in% rownames(installed.packages()))) {
            install.packages("dplyr")
        }
        library(dplyr)
    }
    
    ##
    # setfolder is used to setup project directory in user home dir ("~")
    ##
    setfolder <- function() {
        if (file.exists(project_folder)) {
            unlink(project_folder, recursive=TRUE);
        } else {
            dir.create(project_folder);
        }
        setwd(project_folder);
        dir.create("src");
        dir.create("data");
        dir.create("result");
    }
    
    ##
    # getdata downloads and unzips data in current working dir
    #   src folder will contasin data.zip downloaded file
    #   data folder will contain unziped data
    ##
    getdata <- function() {
        url <-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip";
        download.file(url, "src/data.zip");
        unzip("src/data.zip", exdir = "data");
        return(list.dirs("data", recursive=FALSE)[1]);
    }
    
    initlibs();
    setfolder();
    return(getdata());
}

##
# mergedata function is used to merge data from files in one data.frame
#   result is a data frame with 563 columns, where:
#     columns 1:561 contains features from test and train data
#     column 562 contains subjects from test and train data
#     column 563 contains labels from test and train data
##
mergedata <- function(dir) {
    train_subjects <- read.csv(paste(dir, "train", "subject_train.txt", sep = "/"), 
                                 sep = "", header= FALSE);
    train_labels <- read.csv(paste(dir, "train", "y_train.txt", sep = "/"), 
                                 sep = "", header= FALSE);
    train_features <- read.csv(paste(dir, "train", "X_train.txt", sep = "/"), 
                               sep = "", header= FALSE);
    test_subjects <- read.csv(paste(dir, "test", "subject_test.txt", sep = "/"), 
                                 sep = "", header= FALSE);
    test_labels <- read.csv(paste(dir, "test", "y_test.txt", sep = "/"), 
                               sep = "", header= FALSE);
    test_features <- read.csv(paste(dir, "test", "X_test.txt", sep = "/"), 
                                 sep = "", header= FALSE);
    train <- cbind(train_features, train_subjects, train_labels);
    test <- cbind(test_features, test_subjects, test_labels);
    return(rbind(train, test));
}

##
# nameandfilter function is used to properly name dataframe columns base on data in features txt
# also it filters columns leaving only mean and standard deviation features
##
nameandfilter <- function(dir, data) {
    featureNames <- read.csv(paste(dir, "features.txt", sep = "/"), 
                             sep = "", header= FALSE);
    featureNames$name <- gsub("-", " ", featureNames[[2]]); 
    featureNames$name <- gsub("\\(\\)", " ", featureNames$name);
    names(data)[562] = "subject";
    names(data)[563] = "activity";
    names(data)[1:561] = featureNames[,3];
    columns <- c(grep("(mean[^F])|(std)", featureNames[[2]], perl = TRUE), 562, 563)
    return(data[,columns])
}

##
# nameactivity function is used to replace numeric data in activity column with activity name
##
nameactivity <- function(dir, data) {
    activityNames <- read.csv(paste(dir, "activity_labels.txt", sep = "/"), 
                             sep = "", header= FALSE);
    names(activityNames) <- c("activityID", "ActivityName");
    data <- merge(data, activityNames, by.x="activity", by.y="activityID", all = FALSE);
    data <- select(data, -activity);
    return(data)
}

##
# clean function generates tidy result dataset from parameter
##
clean <- function(data) {
    return(data %>% group_by(ActivityName, subject) %>% summarise_each(funs(mean)))
}

##
# Main entry point of script. Start run_analysis() from console to get result.txt in result folder
##
run_analysis <- function() {
    dir <- init();
    data <- mergedata(dir);
    data <- nameandfilter(dir, data);
    data <- nameactivity(dir, data);
    data <- clean(data);
    write.table(data, "result/result.txt", row.names=FALSE)    
}
