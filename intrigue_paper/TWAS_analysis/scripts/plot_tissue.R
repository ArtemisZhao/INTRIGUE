d1 = read.table("data/UKB_Height.muscle_vs_blood.eGene.TWAS.zval")
d2 = read.table("output/UKB_Height.muscle_vs_blood.eGene.TWAS.cefn.intrigue.pip", head=T)
d3 = read.table("output/UKB_Height.muscle_vs_blood.eGene.TWAS.meta.intrigue.pip", head=T)

z1 = d1$V2
z2 = d1$V3
thresh = 0.75

pdf(file="results/tissue_comp_cefn.pdf", width=8, height=8, bg="white", pointsize=16)
plot(z1~z2,pch=16,xlim=c(-30,30), ylim=c(-30,30), xlab = "TWAS z-scores (Blood)", ylab="TWAS z-scores (Muscle)", main="CEFN")
points( z1[d2$rep_prob>=thresh]~ z2[d2$rep_prob>=thresh], pch=16, col="brown")
points( z1[d2$irrep_prob>=thresh]~ z2[d2$irrep_prob>=thresh], pch=16, col="cyan")
abline(0,1, lty=5 ,col="green")
abline(v=0, lty=3)
abline(h=0, lty=3)
legend("bottomright", c("gene w/ reproducible prob. > 0.75","gene w/ irreproducible prob. > 0.75"), pch=c(16,16), col=c("brown", "cyan"))
dev.off()

pdf(file="results/tissue_comp_meta.pdf", width=8, height=8, bg="white", pointsize=16)
plot(z1~z2,pch=16,xlim=c(-30,30), ylim=c(-30,30), xlab = "TWAS z-scores (Blood)", ylab="TWAS z-scores (Muscle)", main="META")
points( z1[d3$rep_prob>=thresh]~ z2[d3$rep_prob>=thresh], pch=16, col="brown")
points( z1[d3$irrep_prob>=thresh]~ z2[d3$irrep_prob>=thresh], pch=16, col="cyan")
abline(0,1, lty=5 ,col="green")
abline(v=0, lty=3)
abline(h=0, lty=3)
legend("bottomright", c("gene w/ reproducible prob. > 0.75","gene w/ irreproducible prob. > 0.75"), pch=c(16,16), col=c("brown", "cyan"))
dev.off()



