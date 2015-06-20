==================================================================
Cleaning Data Course Project
==================================================================

Raw data was collected from:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data transformation and cleaning have been done as follwos:


1. Observational data was combined with subject identifiers and Activity identifies. For both the training data set and test data set. 
2. The rows in resulting training and test data sets were combined to form one large data set.
3. Columns names where applied using the list of features provided and 
 Activity identifiers where translated to activity names using the list of activities provided.
4. The large data set was reduce to a final set containing only variables with names that include “mean” or “std”, regardless of upper or lower case. 
This includes the mean of angular calculations.  
 
For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 86-feature vector with means and standard deviations. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

- 'DataCleaningProject_tidy_dataset' 


This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. 

