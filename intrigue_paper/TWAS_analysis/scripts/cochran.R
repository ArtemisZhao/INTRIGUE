# https://bookdown.org/MathiasHarrer/Doing_Meta_Analysis_in_R/heterogeneity.html

qtest<-function(beta, var){
    w = 1/var
    mu = sum(w*beta)/sum(w)
    Q = sum(w*(beta-mu)^2)
    k = length(w)-1
    pval = 1-pchisq(Q,k)
    c(Q, pval)
}



fix_eff_analysis<-function(beta, var){
    w = 1/var
    mu = sum(w*beta)/sum(w)
    se = sqrt(1/sum(w))
    z = mu/se
    return(c(z,2*pnorm(-abs(z))))
}

d= read.table("data/GIANT_vs_UKB_Height.muscle.TWAS.zval")
zm = cbind(d$V2,d$V3)
rst = t(apply(zm,1,function(x) qtest(x,rep(1,2))))
#rst = cbind(zm,rst)
#rst = rbind(c("z1", "z2", "Q", "pval"),rst)
#write(file = "results/GIANT_vs_UKB_Height.muscle.TWAS.cochran_test.rst", t(rst), ncol=4)
Qv = rst[,1]
pval = rst[,2]




pdf(file="results/qtest_pval.pdf", width=10, height=6, bg="white", point=16)
hist(pval[d$V2 !=0 | d$V3 !=0], main="", xlab = "p-values from Cochran's Q test") 
dev.off()


rst = t(apply(zm,1,function(x) fix_eff_analysis(x,rep(1,2))))
library(qvalue)
pval_fix = rst[,2]
pval_fix_pass = pval_fix[pval>0.05]
gene = d[,1]
gene_pass = gene[pval>0.05]
fix_rst = qvalue(pval_fix_pass, fdr.level=0.05)
print(paste(length(gene) - length(pval_fix_pass), "genes with Q-test p-value < 0.05"))
print(paste("Fixed-effect model rejection = ", sum(fix_rst$sig)+0))
rej_fix = gene_pass[fix_rst$sig==1]

rst_giant = qvalue(2*pnorm(-abs(d$V2)), fdr.level=0.05)
rst_ukb = qvalue(2*pnorm(-abs(d$V3)), fdr.level=0.05)
rej_giant = d$V1[rst_giant$sig==1]
rej_ukb = d$V1[rst_ukb$sig==1]

print (paste("GIANT overlapping:", round(length(intersect(rej_fix, rej_giant))/length(rej_giant),3)))
print (paste("UKB overlapping:", round(length(intersect(rej_fix, rej_ukb))/length(rej_ukb),3)))


fix_rst2 = qvalue(pval_fix, fdr.level=0.05)
print(paste("Fixed-effect model rejection (no restriction) = ", sum(fix_rst2$sig)+0))
rej_fix2 = gene[fix_rst2$sig==1]

print (paste("GIANT overlapping:", round(length(intersect(rej_fix2, rej_giant))/length(rej_giant),3)))
print (paste("UKB overlapping:", round(length(intersect(rej_fix2, rej_ukb))/length(rej_ukb),3)))










