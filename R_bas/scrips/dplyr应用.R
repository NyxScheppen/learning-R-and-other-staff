# 包的核心作用：把很多个表整理成“能被算法吃下去的表”
library(dplyr)

setwd("example_data")

exp <- read.csv("expr.csv")
phe <- read.csv("pheno.csv")

#-------预处理-------
rownames(exp) <- exp[, 1] # 更改行名
exp <- exp[, -1] # 取列

# 对phe进行处理
rownames(phe) <- phe[, 1] # 更改行名
phe <- phe[, -1] # 取列

#-------处理-------
select(exp, "sample1") # 选择需要的列

filter(phe, disease == "Tumor") # 按条件挑行

mutate(exp, change = "stable") # 新建一列

arrange(exp, sample1) # 排序

join <- inner_join(exp, phe, by = "merge") # 严格按某列合并两表

setwd("..")
