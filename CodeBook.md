CodeBook
==================

<b>CodeBook of variables are mainly defined in features_info.txt.</b>


R script called run_analysis.R and perform following major steps. Details of steps are further explained under section <b>Transformation Details</b>.

step1 Merges the training and the test sets to create one data set.

step2 Extracts only the measurements on the mean and standard deviation for each measurement. 

step3 Uses descriptive activity names to name the activities in the data set

step4 Appropriately labels the data set with descriptive variable names. 

step5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For every step, a corresponding step#Result variable can be retrieved to analyze transformation result, whereby # is number, e.g. <b>step1Result</b> in <b>bold</b> style.

step1 Merges the training and the test sets to create one data set.


<h3>Transformation Details</h3>
<h4>step1 Merges the training and the test sets to create one data set.</h4>
features.txt and all txt files under test and train folders are read.table() and variables named as per filename. cbind <i>test</i> dataframe with <i>actvity</i> and <i>subject</i>. same cbind perform again on <i>train</i> dataframe. <i>step1Result</i> is rbind from <i>test</i> and <i>train</i> dataframe.


<h4>step2 Extracts only the measurements on the mean and standard deviation for each measurement.</h4>
<b>meanAndStdInd</b> is setup by checking out the index of std and mean in <b>features</b>
<b>step2Result</b> is subsetting from <b>step1Result</b> with <b>meanAndStdInd</b>.


<h4>step3 Uses descriptive activity names to name the activities in the data set</h4>
<b>activity_labels</b> is read in from file system. column name of descriptive activity is updated to "activity_name". <b>step3Result</b> is merge with <b>step2Result</b> and <b>activity_labels</b>.


<h4>step4 Appropriately labels the data set with descriptive variable names.</h4>
<b>step3Result</b> column names is output into a text file, manually analyzed about wordings. <br>
A new column name list is generated by <br>
1. replacing 3 dots into 1 dot <br>
2. removing 2 dots<br>
<b>step4Result</b> updated with the new column name list.<br>


<h4>step5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.</h4>
With library dplyr, <b>step4Result</b> group by <b>activity_name</b> and <b>subject</b>, and further summarize_each by mean function and become <b>step5Result</b>.  



