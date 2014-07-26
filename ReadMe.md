Getting and Cleaning Data Project
========================================================

Objectives
----------
For this project there are two 'tidy' datasets to create. 

+ A dataset containing complete observations of subject, activity and specific
features. Only those features representing a mean or standard deviation 
value will be collected. The specfic features will be appropriately labeled
with their corresponding subjects and activities. Activities should be 
meaningful names, not numeric codes.

+ A second dataset using the first to report the mean value of each feature for each unique combination of subject and activity.

**It was ambiguous which dataset should be uploaded. To disambiguate only the second dataset, the summary of the feature means per subject/activity, will be uploaded.**

Additionally, a R markdown file (this thing) describing the method for analyzing the files and the variables was required. 

**It was ambiguous whether 'variables' are those used in the analysis algorithm or the variables of the final summary analysis, so I included both to disambiguate.**

Instructions
------------

+ **setwd()** to the directory above the topmost directory of the downloaded Samsung data
+ **source()** the run_analysis.R file, prefixed with the path where it lives.

Algorithm | First Dataset
-------------------------------------
 
 + Load the activity code for both the training and testing sets 
 + Load the map of activity codes to names
 + Translate the activity codes into names for both the training and testing sets
 + Load the subjects for the training and testing sets
 + Load training/testing set feature names
 + Load the training/testing sets with feature names
 + Reduce the features of the training and testing sets to those representing mean and standard deviations
 + Add the activity names to the respective reduced training and testing sets
 + Add the subjects to the respective reduced training and testing sets
 + Merge the training and testing sets into a complete set
 + Write the complete set (conditionally install MASS package)

Algorithm | Second Dataset
--------------------------
+ Determine the unique combinations of subject and activty
+ For each unique combination collect the correpsonding rows in the complete, reduced dataset.
+ Calculate the column means for the features
+ Write out the summary dataset - subject, activity, feature means
  


Variables | Algorithms
---------------------

These are the computationally relevant variables used in the R algorithm. There are gobs of other variables but I used those for post-facto sanity checks.

+ **activity.names**: Map of activity codes and names

+ **complete.reducedFeatures**: Mean and standard deviation feature values for the merged testing and training observations for all subjects and activities
+ **complete.reducedFeatures.ncol**: The number of columns in the merged and reduced dataset. This will be the column dimension of the features averages in the final sumamry dataset
+ **feature.names**: Map of feature column position and names
+ **feature.meanStdIndices**: The indices of the feature set representing mean or standard deviation values
+ **featureCount.expected**: Expected number of features, according to the README
+ **massInstalled**: Is the MASS package installed? Used to conditionally                         install MASS which is used to write out the datasets
+ **meanStdGrepPattern**: The regex pattern used to tweeze out variable names representing mean and standard deviation calculation names.
+ **subjectActivity**:Subset of the merged, reduced dataset specific to a unique combination of subject and activity
+ **subjectActivityMeans**:Feature means for unique combination of subject and activity
+ **summary**: The final dataset; feature means for unique combinations of subject and activity.
+ **testing.actvityCodes**: Activity codes for testing observations
+ **testing.actvityNames**: Activity names for testing observations
+ **testing.features**: Feature values for testing observations
+ **testing.reStducedFeatures**:Mean and standard deviation feature values for testing observations for all subjects and activities
+ **training.actvityCodes**: Activity codes for training observations
+ **training.actvityNames**: Activity names for training observations
+ **training.features**: Feature values for training observations
+ **training.reducedFeatures**: Mean and standard deviation feature values for training observations for all subjects and activities
+ **uniqueSubjectActivity**:  Contains the unique combinations of subject and activity from the merged and reduce dataset
+ **uniqueSubjectActivity.nrow**: Contains the number of unique combinations of subject and activity from the merged and reduce dataset. This will be the row dimension of the final summary 

Variables | Summary Dataset
---------------------------
**Note**: All variables listed, except activity and subject, report the mean value of the description provided. It seems pointless drudgery to include that fact for every description.

+ **activity**: The name of the activity for this observation                
         
+ **fBodyAcc-mean()-X, fBodyAcc-mean()-Y,fBodyAcc-mean()-Z**:  The mean 3-axial measurements(X,Y,Z) of body acceleration signals, passed through a Fast Fourier Transform to produce frequency domain signals.
      
+ **fBodyAcc-std()-X, fBodyAcc-std()-Y, fBodyAcc-std()-Z**: The standard deviation in 3-axial measurements(X,Y,Z) of body acceleration signals, passed through a Fast Fourier Transform to produce frequency domain siignals.          

+ **fBodyAccJerk-mean()-X, fBodyAccJerk-mean()-Y, fBodyAccJerk-mean()-Z**: The mean 3-axial measurements(X,Y,Z) of Jerk measurements derived from body linear acceleration and angular velocity , passed through a Fast Fourier Transform to produce frequency domain signals.     

+ **fBodyAccJerk-std()-X, fBodyAccJerk-std()-Y, fBodyAccJerk-std()-Z**:  The standard deviation in 3-axial (X,Y,Z) Jerk measurements derived from body linear acceleration and angular velocity signals , passed through a Fast Fourier Transform to produce frequency domain signals.  

+ **fBodyAccMag-mean()**: The mean magnitude of body acceleration signals, passed through a Fast Fourier Transform to produce frequency domain signals.  

+ **fBodyAccMag-std()**: The standard deviation in magnitude of body acceleration signals, passed through a Fast Fourier Transform to produce frequency domain signals.

+ **fBodyBodyAccJerkMag-mean()**: The means of linear acceleration Jerk measurements magnitudes, passed through a Fast Fourier Transform to produce frequency domain signals. 

+ **fBodyBodyAccJerkMag-std()**:  The standard deviation in linear acceleration Jerk measurement magnitudes, passed through a Fast Fourier Transform to produce frequency domain signals. 

+ **fBodyBodyGyroJerkMag-mean()**: The means of angular velocity Jerk measurements magnitudes, passed through a Fast Fourier Transform to produce frequency domain signals.

+ **fBodyBodyGyroJerkMag-std()**: The standard deviation in angualr velocity Jerk measurements magnitudes, passed through a Fast Fourier Transform to produce frequency domain signals.

+ **fBodyBodyGyroMag-mean()**: The means of angular velocity measurements magnitudes, passed through a Fast Fourier Transform to produce frequency domain signals.

+ **fBodyBodyGyroMag-std()**: The standard deviation in angular velocity measurements magnitudes, passed through a Fast Fourier Transform to produce frequency domain signals.
        
+ **fBodyGyro-mean()-X,fBodyGyro-mean()-Y, fBodyGyro-mean()-Z**:  The mean 3-axial measurements(X,Y,Z) of angualr velocity  signals, passed through a Fast Fourier Transform to produce frequency domain signals.
        
+ **fBodyGyro-std()-X, fBodyGyro-std()-Y, fBodyGyro-std()-Z**: The standard deviation in 3-axial measurements(X,Y,Z) of angualr velocity  signals, passed through a Fast Fourier Transform to produce frequency domain signals.

+ **subject**: The subject (coded) for this observation                   
      
+ **tBodyAcc-mean()-X, tBodyAcc-mean()-Y, tBodyAcc-mean()-Z**: The mean 3-axial measurements(X,Y,Z) of body acceleration signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz.          
          
+ **tBodyAcc-std()-X, tBodyAcc-std()-Y, tBodyAcc-std()-Z**:   Standard deviation in 3-axial measurements(X,Y,Z) of body acceleration signals, passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz.  
      
+ **tBodyAccJerk-mean()-X, tBodyAccJerk-mean()-Y, tBodyAccJerk-mean()-Z**:  Mean 3-axial measurements(X,Y,Z) of body acceleration Jerk signals, passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz. 
     
+ **tBodyAccJerk-std()-X, tBodyAccJerk-std()-Y,tBodyAccJerk-std()-Z**: Standard deviation in 3-axial measurements(X,Y,Z) of body acceleration Jerk signals, passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz.

+ **tBodyAccJerkMag-mean()**: Mean magnitude measurements of body acceleration Jerk signals, passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz.

+ **tBodyAccJerkMag-std()**: Standard deviation in magnitude measurements of body acceleration Jerk signals, passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz. 

+ **tBodyAccMag-mean()**: Mean magnitude measurements of body acceleration signals, passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz.

+ **tBodyAccMag-std()**:  Standard deviation in magnitude measurements of body acceleration signals, passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz.        
       
+ **tBodyGyro-mean()-X, tBodyGyro-mean()-Y, tBodyGyro-mean()-Z**: The mean 3-axial measurements(X,Y,Z) of angular velocity signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz. to produce time domain signals
        
+ **tBodyGyro-std()-X, tBodyGyro-std()-Y, tBodyGyro-std()-Z**:  The standard deviation in 3-axial measurements(X,Y,Z) of angular velocity signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz. to produce time domain signals 

+ **tBodyGyroJerk-mean()-X,tBodyGyroJerk-mean()-Y tBodyGyroJerk-mean()-Z**:  The mean 3-axial measurements(X,Y,Z) of Jerk signals based on angular velocity signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz. to produce time domain signals.
  
+ **tBodyGyroJerk-std()-X, tBodyGyroJerk-std()-Y, tBodyGyroJerk-std()-Z**:  The standard devaition in 3-axial measurements(X,Y,Z) of Jerk signals based on angular velocity signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz. to produce time domain signals. 

+ **tBodyGyroJerkMag-mean()**: The mean magnitude of Jerk signals based on angular velocity signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz. to produce time domain signals.  

+ **tBodyGyroJerkMag-std()**: The standard deviation in magnitude of Jerk signals based on angular velocity signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz. to produce time domain signals.

+ **tBodyGyroMag-mean()**: The mean magnitude of angular velocity signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz. to produce time domain signals        
+ **tBodyGyroMag-std()**:  The standard deviation in angular velocity signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz. to produce time domain signals               

+ **tGravityAcc-mean()-X, tGravityAcc-mean()-Y, tGravityAcc-mean()-Z**: The mean 3-axial measurements(X,Y,Z) of gravity acceleration signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz to produce time domain signals.
 
+ **tGravityAcc-std()-X, tGravityAcc-std()-Y, tGravityAcc-std()-Z**: The standard deviation in 3-axial measurements(X,Y,Z) of gravity acceleration signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz.  

+ **tGravityAccMag-mean()**:  The mean magnitude of gravity acceleration signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz to produce time domain signals.   

+ **tGravityAccMag-std()**: The standard deviation in  magnitude of gravity acceleration signals passed through a low-pass Butterworth filter with a corner frequency of 0.3 Hz to produce time domain signals.          
