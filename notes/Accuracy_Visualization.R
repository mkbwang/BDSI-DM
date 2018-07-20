library(ggplot2)
library(reshape2)
library(dplyr)
meth_svm = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Meth_SVM.rds')
meth_svm = t(meth_svm)
meth_svm = cbind(rownames(meth_svm),meth_svm)
meth_svm = as.data.frame(meth_svm)
colnames(meth_svm)[1] = "Num_Features"
meth_svm_long = melt(meth_svm,id="Num_Features")
meth_svm_long$Num_Features = as.numeric(meth_svm_long$Num_Features)
colnames(meth_svm_long) = c("Num_Features","Drug","Accuracy")
meth_svm_long$Accuracy = as.numeric(meth_svm_long$Accuracy)

ggplot(meth_svm_long,aes(x=Num_Features,y=Accuracy,colour=Drug))+geom_line()+geom_point()+theme(text=element_text(size=14))+
  scale_x_continuous(breaks=1:6,labels=c("2","3","5","10","20","50"))+ggtitle("Test Accuracy of SVM")

# scale_x_continuous(breaks=1:6,labels=c("2","3","5","10","20","50"))

# get the median
meth_svm = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Meth_SVM.rds')
meth_svm_med = apply(meth_svm,2,median)

