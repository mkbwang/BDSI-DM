library(dplyr)
gdsc = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/gdsc_screened.rds')
gdsc_sub = subset(gdsc, DRUG_ID_lib == '1011')[,c("CL","EFFECT")]
train_id = readRDS('/home/wangmk/UM/Research/BDSI/train_drug/train_1011.rds')

tbl_df(gdsc_sub) %>% filter((CL %in% train_id))  %>% group_by(EFFECT) %>% summarise(count=n()) 
