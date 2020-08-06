
d1 = read.table("data/GIANT_vs_UKB_Height.muscle.TWAS.zval")
d2 = read.table("output/GIANT_vs_UKB_Height.muscle.TWAS.cefn.intrigue.pip", head=T)
d3 =read.table("output/GIANT_vs_UKB_Height.muscle.TWAS.meta.intrigue.pip", head=T)

z1 = d1$V2
z2 = d1$V3
thresh = 0.90
pdf(file="results/gwas_comp_cefn.pdf", width=8, height=8, bg="white", pointsize=16)
plot(z1~z2,pch=16,xlim=c(-30,30), ylim=c(-30,30), xlab = "gene-level z statistics (UK Biobank)", ylab="gene-level z-score (GIANT)", main="CEFN")
points( z1[d2$rep_prob>=thresh]~ z2[d2$rep_prob>=thresh], pch=16, col="brown")
points( z1[d2$irrep_prob>=thresh]~ z2[d2$irrep_prob>=thresh], pch=16, col="cyan")
abline(0,1, lty=2 ,col="green")
abline(v=0, lty=3)
abline(h=0, lty=3)
legend("bottomright", c("gene w/ reproducible prob. > 0.90","gene w/ irreproducible prob. > 0.90"), pch=c(16,16), col=c("brown", "cyan"))
dev.off()

pdf(file="results/gwas_comp_meta.pdf", width=8, height=8, bg="white", pointsize=16)
plot(z1~z2,pch=16,xlim=c(-30,30), ylim=c(-30,30), cex= 0.85, xlab = "gene-level z statistics (UK Biobank)", ylab="gene-level z-score (GIANT)", main="META")
points( z1[d3$rep_prob>=thresh]~ z2[d3$rep_prob>=thresh], pch=16, cex= 0.85,col="brown")
points( z1[d3$irrep_prob>=thresh]~ z2[d3$irrep_prob>=thresh], pch=16, cex= 0.85,col="cyan")

abline(0,1, lty=2 ,col="green")
abline(v=0, lty=3)
abline(h=0, lty=3)
legend("bottomright", c("gene w/ reproducible prob. > 0.90","gene w/ irreproducible prob. > 0.90"), pch=c(16,16), col=c("brown", "cyan"))
dev.off()
