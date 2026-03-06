logFC_cutoff <- 1        # log2FoldChange ≥ 1 或 ≤ -1
padj_cutoff  <- 0.05     # 校正后的 p 值

res$change <- "stable"

res$change[
  res$padj < padj_cutoff & res$log2FoldChange >  logFC_cutoff
] <- "up"

res$change[
  res$padj < padj_cutoff & res$log2FoldChange < -logFC_cutoff
] <- "down"