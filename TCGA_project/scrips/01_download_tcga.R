# TCGA = 官方、统一流程、质量可控的癌症样本数据库

if (!require("BiocManager"))
  install.packages("BiocManager")

BiocManager::install("TCGAbiolinks")

library(TCGAbiolinks)
library(SummarizedExperiment)
library(tidyverse)

# 查询数据库
# 需要的数据：肝癌的 RNA-seq 基因表达数据，用 STAR 算的原始 counts
query <- GDCquery(
  project = "TCGA-LIHC",
  data.category = "Transcriptome Profiling",
  data.type = "Gene Expression Quantification",
  workflow.type = "STAR - Counts"
)

# 下载
GDCdownload(query, directory = "00_raw_data", method = "client")

# 整合成R能用的对象
tcga_data <- GDCprepare(
  query,
  directory = "00_raw_data"
)
