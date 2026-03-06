# GEO = 全世界实验室“已经做过的表达实验”的大仓库

library(GEOquery)

gse <- getGEO("GSE84402", destdir = ".", AnnotGPL = F, getGPL = F) # 下载基本数据

eset <- gse[[1]]

expr <- exprs(eset)      # 表达矩阵
pheno <- pData(eset)     # 样本信息
feature <- fData(eset)  # 基因注释

saveRDS(expr, "data/processed/expression.rds")
saveRDS(pheno, "data/processed/pheno.rds")