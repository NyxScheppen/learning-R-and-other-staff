library(limma)

# 如果研究的是某两个或多个对象的比较的话可以用

# 差异分析
design <- model.matrix(~group_list) # 把“tumor/normal”翻译成数学语言
deg <- lmFit(expr, design)|> # 给每一个基因拟合一个线性模型
  eBayes()|> # 稳定方差估计
  topTable(coef=2, number = Inf) # 把“tumor vs normal”这一列的统计结果整理成表

# 标记上下调基因
logFC <- 1
P.Value <- 0.05

k1 <- (deg$P.Value < P.Value)&(deg$logFC < -logFC) # 显著 + 明显下调
k2 <- (deg$P.Value < P.Value)&(deg$logFC > logFC) # 显著 + 明显上调

deg$change <- ifelse(k1, "down", ifelse(k2, "up", "stable"))
