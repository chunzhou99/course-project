# course-project
＃Labling all the measurements with descriptive variable names is a requirement under the Step 4, but it seems easy to use actitivity names as column names, and the data set is more understandable. Therefore, Step 4 is partly accomplished before Step1--merging the training and the test sets.

# In Step2, when columns with mean and standard deviation for each measurement are directly picked up, it shows "duplicate column name", because the column names are not legitimate for R, which means it should be transformed to valid ones at first. However, after the transformation, "mean()" and "std()" in the original table are transformed into "mean.." and "std..".. Only these two kind of variable are chosen, according to README.txt. The data frame created at this stage has 68 columns. The first two columns are subjects' serial numbers and activities, and the rest are measurements.

#Step 3 and Step 4 actually fulfiled at the same time.

#Step 5 requres the means of the variables,the first two columns specify subjects and activites, which should be exclued when we calculate the means.
