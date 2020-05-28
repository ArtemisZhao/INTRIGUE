d = read.table("results/S1.cefn.est")
print("S1 CEFN")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))

d = read.table("results/S1.meta.est")
print("S1 META")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))


d = read.table("results/S2.cefn.est")
print("S2 CEFN")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))


d = read.table("results/S2.meta.est")
print("S2 META")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))


d = read.table("results/S3.cefn.est")
print("S3 CEFN")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))


d = read.table("results/S3.meta.est")
print("S3 META")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))


