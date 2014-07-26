## -----------------------------------------------------------------------------------
##
## For this project there are two 'tidy' datasets to create
##
## (1)  A dataset containing complete observations of subject, activity and specific
##      features. Only those features representing a mean or standard deviation 
##      value will be collected. The specfic features will be appropriately labeled
##      with their corresponding subjects and activities. Activities should be 
##      meaningful names, not numeric codes.
##
##  (2) A dataset using (1) to report the mean value of each feature for each 
##      combination of subject and activity.
##
##
##  ---- To create the first dataset ----
##  
##  (a) Load the activities for both the training and testing sets. 
##  (b) Load the map of activity codes to names.
##  (c) Translate the activity codes into names or both the training and testing sets
##  (d) Load the subjects for the training and testing sets
##  (e) Load training/testing set feature names
##  (f) Load the training/testing sets with feature names
##  (g) Reduce the features of the training and testing sets to just means and standard deviations
##  (h) Add the activity names to the respective reduced training and testing sets
##  (i) Add the subjects to the respective reduced training and testing sets
##  (j) Merge the training and testing sets into a complete set
##  (k) Write out the complete set (conditionally install MASS package)
##
##  ---- To create the second dataset ----
##
##  (a) Determine the unique combinations of subject and activty
##  (b) For each unique combination collect the correpsonding rows in the complete,
##      reduced dataset.
##  (c) Calculate the column means for the features
##  (d) Write out the summary dataset - subject, activity, feature means
##
## -----------------------------------------------------------------------------------
##
##  Variables
##
##  activity.names:         Map of activity codes and names
##
##  complete.reducedFeatures:
##                          Mean and standard deviation feature values for the merged
##                          testing and training observations for all subjects and activities
##  complete.reducedFeatures.ncol:
##                          The number of columns in the merged and reduced dataset.
##                          This will be the column dimension of the features averages 
##                          in the final sumamry dataset
##
##  feature.names:          Map of feature column position and names
##  feature.meanStdIndices: The indices of the feature set representing mean or 
##                          standard deviation values
##
##  featureCount.expected:  Expected number of features, according to the README
##
##  massInstalled:          Is the MASS package installed? Used to conditionally
##                          install MASS which is used to write out the datasets
##
##  meanStdGrepPattern:     The regex pattern used to tweeze out variable names representing
##                          mean and standard deviation calculation names.
##
##  subjectActivity:        Subset of the merged, reduced dataset specific to a unique
##                          combination of subject and activity
##  subjectActivityMeans:   Feature means for unique combination of subject and activity
##
##  summary:                The final dataset; feature means for unique combinations of
##                          subject and activity.
##
##  testing.actvityCodes:   Activity codes for testing observations
##  testing.actvityNames:   Activity names for testing observations
##  testing.features:       Feature values for testing observations
##  testing.reducedFeatures:Mean and standard deviation feature values for testing 
##                          observations for all subjects and activities
##
##  training.actvityCodes:  Activity codes for training observations
##  training.actvityNames:  Activity names for training observations
##  training.features:      Feature values for training observations
##  training.reducedFeatures: Mean and standard deviation feature values for training 
##                          observations for all subjects and activities
##
##  uniqueSubjectActivity:  Contains the unique combinations of subject and activity
##                          from the merged and reduce dataset
##  uniqueSubjectActivity.nrow:  
##                          Contains the number of unique combinations of subject and 
##                          activity from the merged and reduce dataset. This will be 
##                          the row dimension of the final summary dataset.
## -----------------------------------------------------------------------------------


# ***Assumption***: the data is accessible from the working directory, per directions

featureCount.expected <- 561 # per README

# Load training/testing activity codes
training.activityCodes  <- read.table('UCI HAR Dataset/train/y_train.txt', 
                            col.names = 'code')

testing.activityCodes   <- read.table('UCI HAR Dataset/test/y_test.txt', 
                            col.names= 'code')


# Load activity map (code->name)
activity.names      <- read.table('UCI HAR Dataset/activity_labels.txt',
                             sep=' ',
                             col.names=c('code','name'),
                             strip.white=TRUE)

# Translate activity codes into names
training.activityNames  <- activity.names$name[match(training.activityCodes$code, activity.names$code)]
testing.activityNames   <- activity.names$name[match(testing.activityCodes$code, activity.names$code)]

# Load subjects
training.subjects   <- read.table('UCI HAR Dataset/train/subject_train.txt', 
                            col.names=c('subject'))
testing.subjects    <- read.table('UCI HAR Dataset/test/subject_test.txt', 
                            col.names =c('subject'))

# Load feature names (position, name), use to label the features
feature.names       <- read.table('UCI HAR Dataset/features.txt',
                            sep=' ',
                            col.names=c('position','name'),
                            strip.white=TRUE)

# Load training/testing sets, labeled with feature names
training.features   <- read.table('UCI HAR Dataset/train/X_train.txt', 
                            col.names = feature.names[,'name'], 
                            check.names=FALSE)

testing.features    <- read.table('UCI HAR Dataset/test/X_test.txt',
                            col.names = feature.names[,'name'], 
                            check.names=FALSE)


# Reduce features to just those representing mean and standard deviation
# ***Assumption***: the columns of interest contain 'mean()' or 'std()'
#
meanStdGrepPattern <- 'mean\\(\\)|std\\(\\)'
feature.meanStdIndices <- grep(meanStdGrepPattern, feature.names[,'name'])

training.reducedFeatures <-training.features[,feature.meanStdIndices]
testing.reducedFeatures <-testing.features[,feature.meanStdIndices]

# Add the activity names to the reduced training/testing sets
training.reducedFeatures   <- cbind(activity=training.activityNames, training.reducedFeatures)
testing.reducedFeatures    <- cbind(activity=testing.activityNames, testing.reducedFeatures)

# Add the subject to the reduced training/testing sets
training.reducedFeatures   <- cbind(subject=training.subjects, training.reducedFeatures)
testing.reducedFeatures    <- cbind(subject=testing.subjects, testing.reducedFeatures)

# Merge the reduced training/testing sets into one complete set
complete.reducedFeatures    <-merge(training.reducedFeatures, testing.reducedFeatures, all=TRUE)
complete.reducedFeatures.ncol <-ncol(complete.reducedFeatures)

# Write out the first dataset, first check to see if MASS is installed
massInstalled <-require(MASS)
if (!massInstalled){
    install.packages('MASS')
}
write.matrix(complete.reducedFeatures, 'Tidy1.txt')


# Now the analysis set
#

# Determine unique subject activity, the unique permutations of subject and activity
uniqueSubjectActivity <- complete.reducedFeatures[!duplicated (complete.reducedFeatures[c('subject', 'activity')]), c('subject', 'activity')]
uniqueSubjectActivity.nrow = nrow(uniqueSubjectActivity)

# For each unique subject activity, take the average of the features
# Not the most elegant solution but I ran out of time -- get the hammer!
summary <- data.frame(matrix(ncol=complete.reducedFeatures.ncol, nrow=uniqueSubjectActivity.nrow))
names(summary) =  names(complete.reducedFeatures)
for (i in 1:nrow(uniqueSubjectActivity)){
    subjectActivity <- complete.reducedFeatures[complete.reducedFeatures$activity == uniqueSubjectActivity$activity[i] & complete.reducedFeatures$subject == uniqueSubjectActivity$subject[i],]
    subjectActivityMeans <- colMeans(subjectActivity[3:complete.reducedFeatures.ncol])
    summary[i,] <- c(subject = as.character(uniqueSubjectActivity$subject[i]), activity=as.character(uniqueSubjectActivity$activity[i]), subjectActivityMeans)
}
write.matrix(summary, 'Tidy2.txt')
# These are the mean calculated feature names + 'subject' and 'activity'.
write.matrix(sort(names(summary)), 'Tidy2Variables.txt')


# Some sanity checks to make sure I'm not running of the rails.

#training.features.nrow <- nrow(training.features)
# training.features.ncol <- ncol(training.features)
# training.nActivityCodes <-nrow(training.activityCodes)
# training.reducedFeatures.nrow <-nrow(training.reducedFeatures)
# training.reducedFeatures.ncol <-ncol(training.reducedFeatures)
# 
# testing.features.nrow <- nrow(testing.features)
# testing.features.ncol <- ncol(testing.features)
# testing.nActivityCodes <-nrow(testing.activityCodes)
# testing.reducedFeatures.nrow <-nrow(testing.reducedFeatures)
# testing.reducedFeatures.ncol <-ncol(testing.reducedFeatures)
# 
# complete.reducedFeatures.nrow <-nrow(complete.reducedFeatures)
# 
# print (c('Feature count - expected: ', featureCount.expected))
# print (c('Feature names count : ', nrow(feature.names)))
# print (c('Activity names count : ', nrow(activity.names)))
# 
# print (c('Training # rows : ', training.features.nrow))
# print (c('Training # cols : ', training.features.ncol))
# print (c('Training # activity codes : ', training.nActivityCodes))
# print (c('Training # reduced nrows : ', training.reducedFeatures.nrow))
# print (c('Training # reduced ncols : ', training.reducedFeatures.ncol))
# 
# print (c('Testing # rows : ', testing.features.nrow))
# print (c('Testing # cols : ', testing.features.ncol))
# print (c('Testing # activity codes : ', testing.nActivityCodes))
# print (c('Testing # reduced nrows : ', testing.reducedFeatures.nrow))
# print (c('Testing # reduced ncols : ', testing.reducedFeatures.ncol))
# 
# print (c('Complete # reduced nrows : ', complete.reducedFeatures.nrow))
# print (c('Complete # reduced ncols : ', complete.reducedFeatures.ncol))
# print (c('Unique subject/activity permuations #  nrows : ', uniqueSubjectActivity.nrow))

