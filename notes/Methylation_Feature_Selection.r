
library(dplyr)
library(randomForest)

library(tictoc)

library(parallel)

methylation = readRDS('data/methylation_processed.rds')

gdsc = readRDS('data/gdsc_screened.rds')

meth_transpose = t(methylation)

meth_t_nona <- na.omit(meth_transpose)

cg_label = rownames(meth_t_nona)

head(gdsc)

meth_t_nona[1:6,1:6]

gdsc_sub <- subset(gdsc, DRUG_ID_lib == '1014')[,c("CL","EFFECT")]

meth_t_sub <- meth_t_nona[,as.character(gdsc_sub$CL)]

meth_t_sub_new <- rbind(meth_t_sub,t(gdsc_sub['EFFECT']))

dim(meth_t_sub_new)

effective_sub_t = meth_t_sub_new[,meth_t_sub_new['EFFECT',]==1]
ineffective_sub_t = meth_t_sub_new[,meth_t_sub_new['EFFECT',]==0]

methylation_subset_id = c()
count = 0

x <- seq_along(cg_label)
cg_split <- split(cg_label,ceiling(x/59490))

475915/59490

effective_sub = t(effective_sub_t)
ineffective_sub = t(ineffective_sub_t)

f <- function(cg_sub){
    id = c()
    count = 0
    for (cg_id in cg_sub){
        ttestout = t.test(effective_sub[,cg_id],ineffective_sub[,cg_id])
        if (ttestout$p.value < 0.05/475915){
            count = count+1
            id[count] = cg_id
        }
    }
    return(id)
}

cl <- makeCluster(8)

tic()
clusterExport(cl,"effective_sub")
toc()

tic()
clusterExport(cl,"ineffective_sub")
toc()

tic()
list_id <- parLapply(cl,cg_split,f)
toc()

2127.761/60
# time spent with 16 nodes allocated

2507.537/60
# time spend with 10 nodes allocated

2435.089/60
# time spent with 8 nodes allocated

stopCluster(cl)

length(methylation_subset_id)

saveRDS(methylation_subset_id,"data/meth_1014_subset_id.rds")
