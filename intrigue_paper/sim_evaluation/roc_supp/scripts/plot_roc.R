library(pROC)
pdf(file = "results/roc_rep_cefn_supp.pdf", width=8.3, height=8.2, bg="white", pointsize=16)
d1 = read.table("results/cefn_rep_K2.roc.dat")
d2 = read.table("results/cefn_rep_K3.roc.dat")
d3 = read.table("results/cefn_rep_K5.roc.dat")
d4 = read.table("results/cefn_rep_K10.roc.dat")

roc(response=d1$V3, predict=d1$V2, plot=T, col="brown", main="reproducible signals (CEFN)")
roc(response=d2$V3, predict=d2$V2, plot=T, col="darkgreen", add=T)
roc(response=d3$V3, predict=d3$V2, plot=T, col="cyan", add=T)
roc(response=d4$V3, predict=d4$V2, plot=T, col="purple", add=T)
dev.off()


pdf(file = "results/roc_irr_cefn_supp.pdf", width=8.3, height=8.2, bg="white", pointsize=16)
d1 = read.table("results/cefn_irr_K2.roc.dat")
d2 = read.table("results/cefn_irr_K3.roc.dat")
d3 = read.table("results/cefn_irr_K5.roc.dat")
d4 = read.table("results/cefn_irr_K10.roc.dat")

roc(response=d1$V3, predict=d1$V2, plot=T, col="brown", main="irreproducible signals (CEFN)")
roc(response=d2$V3, predict=d2$V2, plot=T, col="darkgreen", add=T)
roc(response=d3$V3, predict=d3$V2, plot=T, col="cyan", add=T)
roc(response=d4$V3, predict=d4$V2, plot=T, col="purple", add=T)
dev.off()



pdf(file = "results/roc_rep_meta_supp.pdf", width=8.3, height=8.2, bg="white", pointsize=16)
d1 = read.table("results/meta_rep_K2.roc.dat")
d2 = read.table("results/meta_rep_K3.roc.dat")
d3 = read.table("results/meta_rep_K5.roc.dat")
d4 = read.table("results/meta_rep_K10.roc.dat")

roc(response=d1$V3, predict=d1$V2, plot=T, col="brown", main="reproducible signals (META)")
roc(response=d2$V3, predict=d2$V2, plot=T, col="darkgreen", add=T)
roc(response=d3$V3, predict=d3$V2, plot=T, col="cyan", add=T)
roc(response=d4$V3, predict=d4$V2, plot=T, col="purple", add=T)
dev.off()


pdf(file = "results/roc_irr_meta_supp.pdf", width=8.3, height=8.2, bg="white", pointsize=16)
d1 = read.table("results/meta_irr_K2.roc.dat")
d2 = read.table("results/meta_irr_K3.roc.dat")
d3 = read.table("results/meta_irr_K5.roc.dat")
d4 = read.table("results/meta_irr_K10.roc.dat")

roc(response=d1$V3, predict=d1$V2, plot=T, col="brown", main="irreproducible signals (META)")
roc(response=d2$V3, predict=d2$V2, plot=T, col="darkgreen", add=T)
roc(response=d3$V3, predict=d3$V2, plot=T, col="cyan", add=T)
roc(response=d4$V3, predict=d4$V2, plot=T, col="purple", add=T)
dev.off()

