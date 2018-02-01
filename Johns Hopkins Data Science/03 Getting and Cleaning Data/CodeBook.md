# CodeBook

## Purpose: This codebooks describes datasets, variables, and transformation performed to generate a [tidy dataset].

## Dataset Background
> The data is from experiments performed in UCI. 
* The experiments included a group of 30 volunteers with an age 19-48 years. 
* Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. T
* The data was captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
* The obtained dataset has been randomly partitioned into two sets, 70% in the training data and 30% in the the test data. 

> [Source](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
> [Datasets](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


## Dataset Description
### For each record it is provided:
> Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
> Triaxial Angular velocity from the gyroscope. 
> A 561-feature vector with time and frequency domain variables. 
> Its activity label. 
> An identifier of the subject who carried out the experiment.

### The dataset includes the following files:
> 'README.txt'
> 'features_info.txt': Shows information about the variables used on the feature vector.
> 'features.txt': List of all features.
> 'activity_labels.txt': Links the class labels with their activity name.
> 'train/X_train.txt': Training set.
> 'train/y_train.txt': Training labels.
> 'test/X_test.txt': Test set.
> 'test/y_test.txt': Test labels.
> 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

## Feature Selection
### The features selected for this database come from the accelerometer and gyroscope 3-axial (X, Y, and Z) raw signals tAcc-XYZ and tGyro-XYZ 
> These time domain signals (prefix 't') were captured at a constant rate of 50 Hz. Then they were filtered to remove noise. 
> The acceleration signal was then separated into body and gravity acceleration signals 
> tBodyAcc-XYZ
> tGravityAcc-XYZ 

> The body linear acceleration and angular velocity were derived in time to obtain Jerk signals 
> tBodyAccJerk-XYZ 
> tBodyGyroJerk-XYZ

> The magnitude of these three-dimensional signals were calculated using the Euclidean norm 
> tBodyAccMag
> tGravityAccMag
> tBodyAccJerkMag
> tBodyGyroMag
> tBodyGyroJerkMag 

> A Fast Fourier Transform (FFT) was applied to some of these signals producing (Note the 'f' to indicate frequency domain signals)
> fBodyAcc-XYZ
> fBodyAccJerk-XYZ
> fBodyGyro-XYZ
> fBodyAccJerkMag
> fBodyGyroMag
> fBodyGyroJerkMag  

### These signals were used to estimate variables of the feature vector for each pattern:  

> tBodyAcc-XYZ
> tGravityAcc-XYZ
> tBodyAccJerk-XYZ
> tBodyGyro-XYZ
> tBodyGyroJerk-XYZ
> tBodyAccMag
> tGravityAccMag
> tBodyAccJerkMag
> tBodyGyroMag
> tBodyGyroJerkMag
> fBodyAcc-XYZ
> fBodyAccJerk-XYZ
> fBodyGyro-XYZ
> fBodyAccMag
> fBodyAccJerkMag
> fBodyGyroMag
> fBodyGyroJerkMag

### The set of variables that were estimated from these signals are: 

> mean(): Mean value
> std(): Standard deviation
> mad(): Median absolute deviation 
> max(): Largest value in array
> min(): Smallest value in array
> sma(): Signal magnitude area
> energy(): Energy measure. Sum of the squares divided by the number of values. 
> iqr(): Interquartile range 
> entropy(): Signal entropy
> arCoeff(): Autorregresion coefficients with Burg order equal to 4
> correlation(): correlation coefficient between two signals
> maxInds(): index of the frequency component with largest magnitude
> meanFreq(): Weighted average of the frequency components to obtain a mean frequency
> skewness(): skewness of the frequency domain signal 
> kurtosis(): kurtosis of the frequency domain signal 
> bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
> angle(): Angle between to vectors.

### Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

> gravityMean
> tBodyAccMean
> tBodyAccJerkMean
> tBodyGyroMean
> tBodyGyroJerkMean


## Transformation 
> Based on the following 5 steps, the tidy dataset is gradually generated. This transformation only includes "subject_test.txt", "subject_train.txt", "X_teat.txt", "X_train.txt", "y_test.txt" and "y_train.txt". Only mean and standard deviation are kept in the merged dataset. Labeling activities and refining variables names give readible ability. The final goal is to create a Tidy dataset including one subject, one activity, and one average. 

> Keep in mind! Keep checking metadata such as "readme.txt", "features_info.txt", "features.txt" and "activity_labels.txt"; The first two give you the more explanation and the last two are used in the transformation steps. 

1. Merges the training and the test sets to create one data set.
> The dimension of each dataset is the key how to merge the preliminary dataset.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
> Use "features.txt" to find out each variable with the information, mean and standard deviation and keep those variables in the dataset (part of X_test/X_train).
> Keep in mind! Each measurement means each observation in the preliminary dataset.

3. Uses descriptive activity names to name the activities in the data set.
> Use the numeric ID in "activity_labels.txt" to link back the numeric values in the dataset (y_test/y_train) and find out the activity names.  

4. Appropriately labels the data set with descriptive variable names.
> Use "features.txt" to label variable names
> Change "f" to "freq"
> Change "t" to "time"
> Change "-" to "."
> Remove "()"

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
> Group by subject and activity and then find out the average. (Cannot understand why we need to find out the means of mean and sd)

> Finally, [run_analysis.R] and [Tidy data]!