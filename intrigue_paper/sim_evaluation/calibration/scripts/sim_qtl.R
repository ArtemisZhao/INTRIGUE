set.seed(123)

sim_data<-function(k, omg, ngene, rep=2, sd=1, ss1,ss2){
  
  beta = rnorm(ngene, mean=0, sd = omg)
  
  bv = t(sapply(1:ngene, function(x) rnorm(rep, mean = beta[x], sd=k*abs(beta[x]))))
  
  x1<-rep(c(0:1),each=ss1/2)
  x2<-rep(c(0,1),each=ss2/2)
  y1<-sapply(1:ngene,function(x) x1*bv[x,1]+rnorm(ss1,mean=0, sd=sd))
  
  y2<-sapply(1:ngene,function(x) x2*bv[x,2]+rnorm(ss2,mean=0,sd=sd))
  
  est1<-sapply(1:ngene,function(x) summary(lm(y1[,x]~x1))$coefficient[2,1:2])
  est2<-sapply(1:ngene,function(x) summary(lm(y2[,x]~x2))$coefficient[2,1:2])
  
  rst = cbind(t(est1),t(est2))
  
  return(rst)
}

ss<-matrix(c(40,50),ncol=2,byrow = TRUE)


for (i in 1:nrow(ss)){
   for (j in 1:200){
       null_data =sim_data(k=0, omg=0, ngene=400,ss1=ss[i,1],ss2=ss[i,2])
       rep_data = sim_data(k=0.1, omg=1, ngene=300,ss1=ss[i,1],ss2=ss[i,2])
       irr_data = sim_data(k=3, omg=1, ngene=300,ss1=ss[i,1],ss2=ss[i,2])
       heterodata = rbind(null_data, rep_data, irr_data)
      write.table(heterodata,file=paste0("sim_S4_",ss[i,1],"_",ss[i,2],"_",j,".dat",sep=""),
                 sep=" ",row.names = TRUE,col.names = FALSE)
	   }
   }




