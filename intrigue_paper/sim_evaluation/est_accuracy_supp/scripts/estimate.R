d = read.table("results/SS1.cefn.est")
print("SS1 CEFN")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))

d = read.table("results/SS1.meta.est")
print("SS1 META")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))


d = read.table("results/SS2.cefn.est")
print("SS2 CEFN")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))


d = read.table("results/SS2.meta.est")
print("SS2 META")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))


d = read.table("results/SS3.cefn.est")
print("SS3 CEFN")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))


d = read.table("results/SS3.meta.est")
print("SS3 META")
c(mean(d$V1), mean(d$V1)-1.96*sd(d$V1), mean(d$V1)+1.96*sd(d$V1))
c(mean(d$V2), mean(d$V2)-1.96*sd(d$V2), mean(d$V2)+1.96*sd(d$V2))
c(mean(d$V3), mean(d$V3)-1.96*sd(d$V3), mean(d$V3)+1.96*sd(d$V3))


