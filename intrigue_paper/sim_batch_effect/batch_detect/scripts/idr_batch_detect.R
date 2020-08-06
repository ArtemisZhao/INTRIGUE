library(idr)
num<-seq(0,2,0.1)

mu<-1
sigma<-1
rho<-0.8
pvec<-c(0.02,0.05,0.075,0.10,0.20)

t<-0
outd = matrix(ncol=1, num)

#batch_detect<-list(length(pvec))
for (p in pvec){
	t<-t+1
	rep_est_detect<-c()
        for (i in 1:length(num)){
            data<-read.table(paste0("data/sim_batch_",num[i],".dat",sep=""))
   
            z<-cbind(data[,2]/data[,3],data[,4]/data[,5])

            idrUG<-est.IDR(abs(z),mu,sigma,rho,p,eps=0.001,max.ite = 5000)

            rep_est_detect<-c(rep_est_detect,idrUG$para$p) 
   }

    outd = cbind(outd, rep_est_detect)
}
  
colnames(outd) = c("batch_magnitude", paste0("init_pi0_",pvec))
write.table(file="results/idr.rep_est.out", outd, row.names=F, col.name=T)
