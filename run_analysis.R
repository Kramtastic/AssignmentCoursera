## Please ensure you set the working directory of the files before running analysis
testSet <- read.csv("./test/subject_test.txt", header = FALSE)
names(testSet) <- c("subjectid")
trainSet <- read.csv("./train/subject_train.txt", header = FALSE)
names(trainSet) <- c("subjectid")

actTestSet <- read.csv("./test/y_test.txt", header = FALSE)
names(actTestSet) <- c("actid")
actTrainSet <- read.csv("./train/y_train.txt", header = FALSE)
names(actTrainSet) <- c("actid")

testSet <- cbind(testSet, actTestSet)
trainSet <- cbind(trainSet, actTrainSet)

actLabels <- read.fwf("./activity_labels.txt", c(1, 20))
names(actLabels) <- c("actid", "actname")

meanSdFunction <- function(file) {
    measurement <- read.table(file)
    measurementMean <- apply(measurement, c(1), mean)
    measurementSd <- apply(measurement, c(1), sd)
    cbind(measurementMean, measurementSd)
}
testSet <- cbind(testSet, meanSdFunction("./test/Inertial Signals/body_acc_x_test.txt"))
testSet <- cbind(testSet, meanSdFunction("./test/Inertial Signals/body_acc_y_test.txt"))
testSet <- cbind(testSet, meanSdFunction("./test/Inertial Signals/body_acc_z_test.txt"))
testSet <- cbind(testSet, meanSdFunction("./test/Inertial Signals/body_gyro_x_test.txt"))
testSet <- cbind(testSet, meanSdFunction("./test/Inertial Signals/body_gyro_y_test.txt"))
testSet <- cbind(testSet, meanSdFunction("./test/Inertial Signals/body_gyro_z_test.txt"))
testSet <- cbind(testSet, meanSdFunction("./test/Inertial Signals/total_acc_x_test.txt"))
testSet <- cbind(testSet, meanSdFunction("./test/Inertial Signals/total_acc_y_test.txt"))
testSet <- cbind(testSet, meanSdFunction("./test/Inertial Signals/total_acc_z_test.txt"))
names(testSet) <- c("subjectid", "actid", "mean_bodyaccx", "sd_bodyaccx","mean_bodyaccy", "sd_bodyaccy","mean_bodyaccz", "sd_bodyaccz", "mean_bodygyrox", "sd_bodygyrox","mean_bodygyroy", "sd_bodygyroy","mean_bodygyroz", "sd_bodygyroz", "mean_totalaccx", "sd_totalaccx","mean_totalaccy", "sd_totalaccy","mean_totalaccz", "sd_totalaccz")

trainSet <- cbind(trainSet, meanSdFunction("./train/Inertial Signals/body_acc_x_train.txt"))
trainSet <- cbind(trainSet, meanSdFunction("./train/Inertial Signals/body_acc_y_train.txt"))
trainSet <- cbind(trainSet, meanSdFunction("./train/Inertial Signals/body_acc_z_train.txt"))
trainSet <- cbind(trainSet, meanSdFunction("./train/Inertial Signals/body_gyro_x_train.txt"))
trainSet <- cbind(trainSet, meanSdFunction("./train/Inertial Signals/body_gyro_y_train.txt"))
trainSet <- cbind(trainSet, meanSdFunction("./train/Inertial Signals/body_gyro_z_train.txt"))
trainSet <- cbind(trainSet, meanSdFunction("./train/Inertial Signals/total_acc_x_train.txt"))
trainSet <- cbind(trainSet, meanSdFunction("./train/Inertial Signals/total_acc_y_train.txt"))
trainSet <- cbind(trainSet, meanSdFunction("./train/Inertial Signals/total_acc_z_train.txt"))
names(trainSet) <- c("subjectid", "actid", "mean_bodyaccx", "sd_bodyaccx","mean_bodyaccy", "sd_bodyaccy","mean_bodyaccz", "sd_bodyaccz", "mean_bodygyrox", "sd_bodygyrox","mean_bodygyroy", "sd_bodygyroy","mean_bodygyroz", "sd_bodygyroz", "mean_totalaccx", "sd_totalaccx","mean_totalaccy", "sd_totalaccy","mean_totalaccz", "sd_totalaccz")

dataSet <- rbind(testSet, trainSet)
cleanDataSet <- merge(dataSet, actLabels, by.x="actid")

library(plyr)
head(cleanDataSet)

ddply(cleanDataSet, .(actname, subjectid), summarize,
      avg_mean_bodyaccx=mean(mean_bodyaccx),
      avg_sd_bodyaccx=mean(sd_bodyaccx),
      avg_mean_bodyaccy=mean(mean_bodyaccy),
      avg_sd_bodyaccy=mean(sd_bodyaccy),
      avg_mean_bodyaccz=mean(mean_bodyaccz),
      avg_sd_bodyaccz=mean(sd_bodyaccz),
      avg_mean_bodygyrox=mean(mean_bodygyrox),
      avg_sd_bodygyrox=mean(sd_bodygyrox),
      avg_mean_bodygyroy=mean(mean_bodygyroy),
      avg_sd_bodygyroy=mean(sd_bodygyroy),
      avg_mean_bodygyroz=mean(mean_bodygyroz),
      avg_sd_bodygyroz=mean(sd_bodygyroz),
      avg_mean_totalaccx=mean(mean_totalaccx),
      avg_sd_totalaccx=mean(sd_totalaccx),
      avg_mean_totalaccy=mean(mean_totalaccy),
      avg_sd_totalaccy=mean(sd_totalaccy),
      avg_mean_totalaccz=mean(mean_totalaccz),
      avg_sd_totalaccz=mean(sd_totalaccz))

?ddply
