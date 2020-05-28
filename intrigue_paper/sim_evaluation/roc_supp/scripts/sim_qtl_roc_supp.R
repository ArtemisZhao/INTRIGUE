set.seed(123)

args = commandArgs(trailingOnly=TRUE)

e = as.numeric(args[1])
index = args[2]

sim_data<-function(r, omg, ngene, sd=1, ss, rep){
  
  
  beta = rnorm(ngene, mean=0, sd = omg)
  phi = sqrt(omg^2*r/(1-r))
  bv = t(sapply(1:ngene, function(x) rnorm(rep, mean = beta[x], sd=phi)))

  for( t in 1:rep){
    x1<-rep(c(0:1),each=ss/2)
    y1<-sapply(1:ngene,function(x) x1*bv[x,t]+rnorm(ss,mean=0, sd=sd))
  
    est<-sapply(1:ngene,function(x) summary(lm(y1[,x]~x1))$coefficient[2,1:2])
    
    if(t==1){
        rst = t(est)
    }else{
        rst = cbind(rst,t(est))
    }
  }
  
  return(rst)
}





null_data =sim_data(r=0, omg=0, ngene=400, ss=50, rep=e)
rep_data = sim_data(r=1e-5, omg=1, ngene=300, ss=50, rep=e)
irr_data = sim_data(r=0.795, omg=1, ngene=300, ss=50, rep=e)
heterodata = rbind(null_data, rep_data, irr_data)
write.table(heterodata,file=paste0("sim_SS5_K_", e, "_",index,".dat",sep=""),
            sep=" ",row.names = TRUE,col.names = FALSE)




