args = commandArgs(trailingOnly=TRUE)
d = read.table(args[1])
s1 = d$V2/d$V3
s2 = d$V4/d$V5

ks.test(s1,s2)$p


