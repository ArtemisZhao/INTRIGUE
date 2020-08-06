library(ggplot2)
du = read.table("output/unbias_dat.intrigue.bf", head=T)
db = read.table("output/bias_dat.intrigue.bf", head=T)
bf_comp_unbias = du[,2]-du[,3]
bf_comp_bias = db[,2]-db[,3]
df = data.frame (Setting = factor(rep(c("w/o publication bias", "with publication bias"), each = length(bf_comp_bias))), bf = c(bf_comp_unbias, bf_comp_bias))
pdf(file="results/model_cmp_meta.pdf", width=8, height=5, bg="white")
ggplot(df, aes(x=bf, fill=Setting)) + geom_density(alpha=.3) + xlab(expression(paste(log[10],"[",BF[irr_vs_rep],"]")))+ggtitle("META") + theme(plot.title = element_text(hjust = 0.5))
dev.off()
du = read.table("output/unbias_dat.cefn.intrigue.bf", head=T)
db = read.table("output/bias_dat.cefn.intrigue.bf", head=T)
bf_comp_unbias = du[,2]-du[,3]
bf_comp_bias = db[,2]-db[,3]
df = data.frame (Setting = factor(rep(c("w/o publication bias", "with publication bias"), each = length(bf_comp_bias))), bf = c(bf_comp_unbias, bf_comp_bias))
pdf(file="results/model_cmp_cefn.pdf", width=8, height=5, bg="white")
ggplot(df, aes(x=bf, fill=Setting)) + geom_density(alpha=.3) + xlab(expression(paste(log[10],"[",BF[irr_vs_rep],"]")))+ggtitle("CEFN") +theme(plot.title = element_text(hjust = 0.5))
dev.off()

