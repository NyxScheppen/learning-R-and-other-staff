library(pheatmap)
library(survival)
library(forestplot)

# 画热图
cg <- rownames(deg)[deg$change != "stable"]
diff <- expr[cg,]
annotation_col <- data.frame(group = group_list)
rownames(annotation_col) <- colnames(diff)
pheatmap(diff,
         annotation_col = annotation_col,
         scale = "row",
         show_rownames = F,
         show_colnames = F,
         color = colorRampPalette(c("navy","white","red"))(50),
         fontsize = 10,
         fontsize_row = 3,
         fontsize_col = 3)

# 关闭视图
dev.off()