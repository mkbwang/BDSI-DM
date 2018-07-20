result = readRDS('/home/wangmk/UM/Research/BDSI/Data_Results/RF/CNV_RF_1062.rds')
sum(result$test_pred==result$EFFECT)/nrow(result)
sum(result$EFFECT==FALSE)/nrow(result)
