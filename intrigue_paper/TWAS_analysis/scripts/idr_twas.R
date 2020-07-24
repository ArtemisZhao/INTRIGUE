library(idr)
UvsG<-read.table("data/UKB_Height.muscle_vs_GIANT.blood.TWAS.zval")
#################################
#UvsG<-cbind(UvsG[,2], 1, UvsG[,3],1)
#hUG<-hetero(UvsG)
#####################################################

UvsGb<-abs(UvsG[,2:3])
UvsGb<-data.frame(UvsGb)

#mu=1
#sigma=0.8
#rho=0.8
#p=0.6
mu=c(1,2,3)
sigma=c(0.5,1,2,3)
rho=c(0.7,0.8,0.9)
p=c(0.5,0.6,0.7)
gridsim1<-expand.grid(mu,sigma,rho,p)
dsim<-sapply(1:nrow(gridsim1),function(i)  est.IDR(UvsGb,mu=gridsim1[i,1],sigma=gridsim1[i,2],rho=gridsim1[i,3]
          ,p=gridsim1[i,4],eps=0.001,max.ite=50000))

#idrUG<-est.IDR(UvsGb,mu,sigma,rho,p,eps=0.001,
              # max.ite = 50000)

save(dsim, file="results/GIANT_vs_UKBB_Height.muscle.TWAS.idr.RData")
