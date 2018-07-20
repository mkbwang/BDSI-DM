library(devtools)
library(svglite)
#devtools::install_github("cancerrxgene/gdscIC50", build_vignettes=TRUE)
#devtools::install_github("cancerrxgene/gdscdata", build_vignettes = FALSE)
library(gdscdata)
library(dplyr)
# above is installing packages

data("gdsc_nlme_stats")
summary(gdsc_nlme_stats)
gdsc_nlme_stats <- tbl_df(gdsc_nlme_stats)
drugset_id <- c("505_a_5","506_e_6","508_b_5","505_b_5"
                ,"505_e_16", "506_a_5", "506_b_6", "505_a_6", "506_c_6", "506_d_6",
                "506_f_6", "505_a_16", "506_f_16", "507_b_6", "508_b_6",
                 "507_b_5", "507_c_5", "507_d_5", "506_f_5", "506_g_5",
                 "505_c_5", "506_h_5", "508_c_5", "505_d_5", "506_i_5",
                 "506_j_16", "507_e_16", "508_d_16", "508_e_16", "508_f_16",
                "505_e_5", "506_j_5", "507_e_5", "508_g_5", "508_g_16", "505_f_5",
                "506_k_5", "507_f_5", "508_h_5", "505_f_16", "506_k_16", "507_f_16",
                "508_h_16")
gdsc_useful <- gdsc_nlme_stats %>% select(CL,DRUG_ID_lib,DRUGSET_ID,maxc,IC50) %>% filter(DRUGSET_ID %in% drugset_id)
gdsc_useful <- gdsc_useful %>% mutate(rel_IC50=exp(IC50)/maxc)
gdsc_useful <- gdsc_useful %>% filter(rel_IC50>8 | rel_IC50<0.2) %>% mutate(effective= rel_IC50<0.2)
#above is cleaning the data


gdsc_useful %>% summarise(cluniq = n_distinct(CL))
gdsc_useful %>% summarise(drugcount = n_distinct(DRUG_ID_lib))
gdsc_useful %>% filter(effective==0) %>% summarise(counteffective=n())
#above is looking into basic statistics of data

gdsc_useful <- readRDS('/home/wangmk/UM/Research/BDSI/gdsc_useful.rds')
gdsc_useful <- unique(gdsc_useful)
saveRDS(gdsc_useful,file="/home/wangmk/UM/Research/BDSI/gdsc_useful.rds")
#above is removing duplicates