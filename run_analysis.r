
train_tb_fn <- "UCI HAR Dataset/train/X_train.txt"
train_tbl_fn <- "UCI HAR Dataset/train/y_train.txt"
test_tb_fn <- "UCI HAR Dataset/test/X_test.txt"
test_tbl_fn <- "UCI HAR Dataset/test/y_test.txt"
feature_fn <- "UCI HAR Dataset/features.txt"
activity_fn <- "UCI HAR Dataset/activity_labels.txt"

library(dplyr)

#Read train table
train_tb <-  read.table(train_tb_fn)
train_tbl <- read.table(train_tbl_fn)
train_tb <- cbind(train_tb, train_tbl)

#Read test table
test_tb <- read.table(test_tb_fn)
test_tbl <- read.table(test_tbl_fn)
test_tb <- cbind(test_tb, test_tbl)

#Read variable names
feature <- read.table(feature_fn)

#Read activity lable
activity_lb <- read.table(activity_fn)

#merge training and test
m_tb <- rbind(train_tb, test_tb)

##ANS Q1
m_tb


#select mean & std
#find index of variable which contains mean/Mean/std
sel <-  grep("*(([Mm]ean)|(std))", feature[,2])
m_tbs <- m_tb[,sel]


##ANS Q2
m_tbs

# get name by activity index
activity_ch <- activity_lb[m_tb[,ncol(m_tb)],2]
m_tbs <- cbind(m_tbs, activity_ch)

##ANS Q3
m_tbs


#given variable names
names(m_tbs) <- feature[sel,2]
colnames(m_tbs)[ncol(m_tbs)] = "Activity"
#ANS Q4
names(m_tbs)

g_tbs <- group_by(m_tbs, Activity)
g_sum <- summarise_each(g_tbs, funs(mean))

#ANS Q5
write.table(g_sum, file = "sum.txt", row.name=FALSE)
