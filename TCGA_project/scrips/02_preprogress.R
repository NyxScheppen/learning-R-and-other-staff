library(tidyverse)
library(DESeq2)

# 处理获得的样本信息
expr <- assay(tcga_data) # 表达矩阵
pheno <- as.data.frame(colData(tcga_data))

# 分组划分等级
group_list <- ifelse(
  pheno$sample_type == "Solid Tissue Normal",
  "normal",
  "tumor"
)
group_list <- factor(group_list, levels = c("normal", "tumor"))