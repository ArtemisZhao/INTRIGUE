d1 = read.table("results/S1.cefn.est")
b1 = read.table("results/S1.meta.est")
b2 = read.table("results/S2.meta.est")
d2 = read.table("results/S2.cefn.est")
b3 = read.table("results/S3.meta.est")
d3 = read.table("results/S3.cefn.est")
cefn_est = c(d1$V3,d2$V3,d3$V3)
meta_est = c(b1$V3,b2$V3,b3$V3)
diff = meta_est - cefn_est
hist(diff,main="")
abline(v=0,lty=2,col = "brown")

history(100)
