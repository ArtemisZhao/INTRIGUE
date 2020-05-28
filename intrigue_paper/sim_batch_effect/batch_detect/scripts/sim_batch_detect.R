set.seed(123)

args = commandArgs(trailingOnly=TRUE)
sd = as.numeric(args[1])


beta1<-rep(0,1000)
x<-rep(c(0:1),each=20)
batchlabel0<-c(rep(1,4),rep(0,16))
batchlabel1<-c(rep(1,16),rep(0,4))
batchlabels<-c(batchlabel0,batchlabel1)


# small batch effect
batcheffect<-c(rnorm(100,0,sd),rep(0,100),rnorm(400,0,sd),rep(0,400))
batch_indicator = c(rep(1,100),rep(0,100),rep(1,400),rep(0,400))

# simulate two studies: first without batch effects second with batch effects
Y<-sapply(1:length(beta1), function(i) x*beta1[i]+rnorm(40))


Ybatch<-sapply(1:length(beta1), function(i) 
  x*beta1[i]+batchlabels*batcheffect[i]+rnorm(40))



# Estimation

est<-t(sapply(1:ncol(Y),function(j)
  summary(lm(Y[,j]~x))$coefficient[2,]))




estbatch<-t(sapply(1:ncol(Ybatch),function(j) 
  summary(lm(Ybatch[,j]~x))$coefficient[2,]))

#library(qvalue)

#pv1 = est[,4]
#pv_batch = estbatch[,4]

#rst1 = qvalue(pv1,fdr.level=0.05)
#rst_batch = qvalue(pv_batch, fdr.level=0.05)

#rst1_rej = length(which(rst1$sig))
#rst_batch_rej = length(which(rst_batch$sig))


#oracle.out = c(sd, ks.test(pv1,"punif")$p, ks.test(pv_batch, "punif")$p, rst1_rej, rst_batch_rej)
#outfile = paste0("sim_batch_",sd,".ks.out");
#write(file=outfile, t(oracle.out), ncol=5)


labels = paste0("gene",1:1000)

outd = cbind(as.character(labels), estbatch[,1:2], est[,1:2])
outfile = paste0("sim_batch_",sd,".dat")
write(file=outfile, t(outd), ncol=5)

