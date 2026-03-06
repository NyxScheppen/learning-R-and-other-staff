# 在生物信息学里
# 行 = 基因
# 列 = 样本

setwd("example_data")

exp <- read.csv("expr.csv") # 读取
phe <- read.csv("pheno.csv")

#---------- 预处理----------

rownames(exp) <- exp[, 1] # 更改行名
exp <- exp[, -1] # 取列
rownames(phe) <- phe[, 1] # 更改行名
phe <- phe[, -1] # 取列

# ----------基础操作----------

dim(exp) # 求行列数
exp[rownames(exp) == "geneA", ] # 取行
exp[order(exp$sample4), ] # 排序
head(exp, 2) # 取前 n 行

#----------质量控制QC----------

# 筛选低表达基因
keep <- rowSums(exp > 0) >= 1 # 该基因至少 1 个样本中是活跃的
df2 <- exp[keep,]

keep <- rowSums(exp > 0) > ncol(exp) * 0.2 # 该基因在20%的样本里都表达
df3 <- exp[keep,]

keep <- rowMeans(exp) > 1 # 平均表达量
df4 <- exp[keep,]

# 挑选tumor样本
tumor_samples <- rownames(phe)[phe$disease == "Tumor"]
expr_tumor <- exp[, tumor_samples]

# 其实可以直接
# tcga_sub <- tcga_data[, group_list == "Tumor"]

# 清除坏样本
bad_samples <- c("sample1")
expr_clean <- exp[, !colnames(exp) %in% bad_samples]
pheno_clean <- phe[!rownames(phe) %in% bad_samples, ]

setwd("..")