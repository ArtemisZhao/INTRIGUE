set.seed(123)
library(sva)
args = commandArgs(trailingOnly=TRUE)
sd = as.numeric(args[1])

beta1<-c(rnorm(200,0,1),rep(0,800))
x<-rep(c(0:1),each=20)
batchlabel0<-c(rep(1,4),rep(0,16))
batchlabel1<-c(rep(1,16),rep(0,4))
batchlabels<-c(batchlabel0,batchlabel1)


# small batch effect
batcheffect<-c(rnorm(100,0,sd),rep(0,100),rnorm(400,0,sd),rep(0,400))
batch_indicator = c(rep(1,100),rep(0,100),rep(1,400),rep(0,400))

# simulate two studies: first without batch effects second with batch effects
Y<-sapply(1:length(beta1), function(i) x*beta1[i]+rnorm(40))

#Yrep<-sapply(1:length(beta1), function(i) x*beta1[i]+rnorm(40))

Ybatch<-sapply(1:length(beta1), function(i) 
  x*beta1[i]+batchlabels*batcheffect[i]+rnorm(40))


combat<-ComBat(dat=t(Ybatch), batch=batchlabels, 
                mod=NULL, par.prior=TRUE, mean.only = TRUE)

# Estimation

est<-t(sapply(1:ncol(Y),function(j)
  summary(lm(Y[,j]~x))$coefficient[2,]))

#estrep<-t(sapply(1:ncol(Yrep),function(j)
#  summary(lm(Yrep[,j]~x))$coefficient[2,]))

estbatch<-t(sapply(1:ncol(Ybatch),function(j) 
  summary(lm(Ybatch[,j]~x))$coefficient[2,]))

estbatchcor<-t(sapply(1:nrow(combat),function(j) 
  summary(lm(t(combat)[,j]~x))$coefficient[2,]))




labels = paste0("gene",1:1000)

outd = cbind(as.character(labels), estbatch[,1:2], est[,1:2])
outfile = paste0("sim_batch_",sd,".dat")
write(file=outfile, t(outd), ncol=5)

outd = cbind(as.character(labels), estbatchcor[,1:2], est[,1:2])
outfile = paste0("sim_batch_",sd,".brm.dat")
write(file=outfile, t(outd), ncol=5)





