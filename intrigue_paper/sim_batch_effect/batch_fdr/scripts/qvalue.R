library(qvalue)
args = commandArgs(trailingOnly=TRUE)
d= read.table(args[1])
pv = pt(-abs(d$V2/d$V3),38)*2
rst = qvalue(pv,fdr.level=0.05)

rej = which(rst$sig)
fdr_batch = length(rej[rej>200])/length(rej)

print(c(length(rej), length(rej[rej>200]),  fdr_batch, (length(rej)-length(rej[rej>200]))/200))
