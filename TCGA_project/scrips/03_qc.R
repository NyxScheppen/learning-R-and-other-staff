# 创建deseq2对象
# 基因表达计数，每个样本的分组，比较的是 group 这个变量
dds <- DESeqDataSetFromMatrix(
  countData = expr,
  colData   = data.frame(group = group_list),
  design    = ~ group
)

# 去掉低表达基因
dds <- dds[rowSums(counts(dds)) > 10, ]

# 做分析
dds <- DESeq(dds) # 样本间 size factor 标准化，离散度估计，负二项模型拟合
res <- results(dds) # 拿到差异分析结果

