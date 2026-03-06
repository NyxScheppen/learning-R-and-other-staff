library(GEOquery)
library(tidyverse)
library(limma) # 做差异分析

# 下载包
if(!require("hgu133plus2.db"))
    BiocManager::install("hgu133plus2.db")
library(hgu133plus2.db)

# 分组划分等级
group_list <- ifelse(str_detect(
  pheno$source_name_ch1,
  "hepatocellular carcinoma"), 
                     "tumor", 
                     "normal")
group_list <- factor(group_list,
                     levels = c("normal", "tumor"))
# 处理表达矩阵
expr <- normalizeBetweenArrays(expr) # 标准化
expr <- log2(expr+1) # 减小数值范围 

# 转换id
ids <- toTable(hgu133plus2SYMBOL) # id获取

expr <- as.data.frame(expr)

expr <- expr |> 
  mutate(probe_id = rownames(expr))|> # 新增一列列名为probe_id的列
  inner_join(ids,by = "probe_id") # 将ids和expr两个表根据probe_id列合并

expr <- expr[!duplicated(expr$symbol),] # 去重

rownames(expr) <- expr$symbol # 更改行名
expr <- expr[,-(29:30)] # 去掉最后两列
