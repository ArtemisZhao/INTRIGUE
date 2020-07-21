d = read.table("data/GIANT_vs_UKB_Height.muscle.TWAS.zval")
library(qvalue)
rst_giant = qvalue(2*pnorm(-abs(d$V2)), fdr.level=0.05)
rst_ukb = qvalue(2*pnorm(-abs(d$V3)), fdr.level=0.05)
rej_giant = d$V1[rst_giant$sig==1]
rej_ukb = d$V1[rst_ukb$sig==1]

d = read.table("output/GIANT_vs_UKB_Height.muscle.TWAS.cefn.intrigue.pip",head=T)
lfdr = sort(1-d$rep_prob)
FDR = cumsum(lfdr)/1:length(lfdr)
thresh = 1 - lfdr[max(which(FDR<=0.05))]
rej_intrigue = d$Gene[d$rep_prob>=thresh]

print (paste("GIANT rej:", length(rej_giant)))
print (paste("UKB rej:", length(rej_ukb)))
print (paste("INTRIGUE rej:", length(rej_intrigue)))

print (paste("GIANT overlapping:", round(length(intersect(rej_intrigue, rej_giant))/length(rej_giant),3)))
print (paste("UKB overlapping:", round(length(intersect(rej_intrigue, rej_ukb))/length(rej_ukb),3)))


