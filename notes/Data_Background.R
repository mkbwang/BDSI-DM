library(dplyr)

gdsc = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/gdsc_screened.rds')


traindirect = '/home/wangmk/UM/Research/BDSI/train_drug/'

code = '1062'

gdsc_sub <- subset(gdsc, DRUG_ID_lib == code)[,c("CL","EFFECT")]

filename = paste(c('train_',code,'.rds'),collapse='')
fullname = paste(c(traindirect,filename),collapse='')
cl_train = paste(readRDS(fullname))
cl_test = setdiff(gdsc_sub$CL,cl_train)

gdsc_sub_train = tbl_df(gdsc_sub) %>% filter(CL %in% cl_train)
gdsc_sub_test = tbl_df(gdsc_sub) %>% filter(!(CL %in% cl_train))

sum(gdsc_sub_train$EFFECT==TRUE)
sum(gdsc_sub_train$EFFECT==FALSE)
sum(gdsc_sub_test$EFFECT==TRUE)
sum(gdsc_sub_test$EFFECT==FALSE)
nrow(gdsc_sub)


# significant genomes inspection 
gdsc = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/gdsc_screened.rds')
gene = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/gene_expression.rds')
get.t <- function(dat, labs){
  # split the data into effective and ineffective
  effect <- dat[labs]
  ineffect <- dat[!labs]
  
  # calculate the two sample means
  effect.bar <- mean(effect)
  ineffect.bar <- mean(ineffect)
  
  # calculate the two sample variances
  v.effect <- var(effect)
  v.ineffect <- var(ineffect)
  
  # calculate the sample sizes
  n.effect <- length(effect)
  n.ineffect <- length(ineffect)
  
  # calculate the sd
  s <- sqrt((v.effect/n.effect) + (v.ineffect/n.ineffect))
  
  df = ((v.effect/n.effect+v.ineffect/n.ineffect)^2)/(v.effect^2/(n.effect^2 * (n.effect-1))+v.ineffect^2/(n.ineffect^2 * (n.ineffect-1)))
  # calculate the test statistic
  T.value <- (effect.bar - ineffect.bar)/s
  return(abs(T.value)>qt(1-0.025/17737,df))
}
traindirect = '/home/wangmk/UM/Research/BDSI/train_drug/'
outdir = '/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/'
codes = c("1006","1007","1008","1011","1014","1016","1019","1026","1032","1054","1060","1062")
for (code in codes){
  gdsc_sub <- subset(gdsc, DRUG_ID_lib == code)[,c("CL","EFFECT")]
  gene_sub <- gene[as.character(gdsc_sub$CL),]
  gene_sub_full <- cbind(gene_sub, gdsc_sub['EFFECT'])
  filename = paste(c('train_',code,'.rds'),collapse='')
  fullname = paste(c(traindirect,filename),collapse='')
  cl_train = paste(readRDS(fullname))
  cl_test = setdiff(rownames(gene_sub_full),cl_train)
  gene_sub_full_train = gene_sub_full[cl_train,]
  gene_sub_full_test = gene_sub_full[cl_test,]
  outcome <- data.frame(Gene = colnames(gene_sub))
  outcome$keep <- apply(gene_sub_full_train[,-ncol(gene_sub_full_train)], 2, get.t, gene_sub_full_train$EFFECT)
  subset_id = outcome %>% filter(keep==TRUE) %>% select(Gene)
  subset_id = unname(t(subset_id[,1]))
  filename = paste(c("Significant_",code,".rds"),collapse='')
  fullname = paste(c(outdir,filename),collapse='')
  saveRDS(subset_id,fullname)
}

significant_1006 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1006.rds')
significant_1007 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1007.rds')
significant_1008 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1008.rds')
significant_1011 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1011.rds')
significant_1014 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1014.rds')
significant_1016 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1016.rds')
significant_1019 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1019.rds')
significant_1026 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1026.rds')
significant_1032 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1032.rds')
significant_1054 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1054.rds')
significant_1060 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1060.rds')
significant_1062 = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/Significant_GeneExp/Significant_1062.rds')

