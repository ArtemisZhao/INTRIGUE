set.seed(123)


sim_data<-function(r, omg, ngene, rep=2, sd=1, ss1,ss2){
  
  beta = rnorm(ngene, mean=0, sd = omg)
  phi = sqrt(omg^2*r/(1-r))
  bv = t(sapply(1:ngene, function(x) rnorm(rep, mean = beta[x], sd=phi)))
  
  x1<-rep(c(0:1),each=ss1/2)
  x2<-rep(c(0,1),each=ss2/2)
  y1<-sapply(1:ngene,function(x) x1*bv[x,1]+rnorm(ss1,mean=0, sd=sd))
  
  y2<-sapply(1:ngene,function(x) x2*bv[x,2]+rnorm(ss2,mean=0,sd=sd))
  
  est1<-sapply(1:ngene,function(x) summary(lm(y1[,x]~x1))$coefficient[2,1:2])
  est2<-sapply(1:ngene,function(x) summary(lm(y2[,x]~x2))$coefficient[2,1:2])
  
  rst = cbind(t(est1),t(est2))
  
  return(rst)
}

ss<-matrix(c(400,500,
          80,500,
	  300,600),ncol=2,byrow = TRUE)


for (i in 1:nrow(ss)){
   for (j in 1:100){
	   if (i!=3){
       null_data =sim_data(r=0, omg=0, ngene=800,ss1=ss[i,1],ss2=ss[i,2])
       rep_data = sim_data(r=1e-5, omg=1, ngene=160,ss1=ss[i,1],ss2=ss[i,2])
       irr_data = sim_data(r=0.795, omg=1, ngene=40,ss1=ss[i,1],ss2=ss[i,2])
       heterodata = rbind(null_data, rep_data, irr_data)
      write.table(heterodata,file=paste0("sim_SS",i,"_",ss[i,1],"_",ss[i,2],"_",j,".dat",sep=""),
                 sep=" ",row.names = TRUE,col.names = FALSE)
	   }
	   else { 
      null_data =sim_data(r=0, omg=0, ngene=500,ss1=ss[i,1],ss2=ss[i,2])
       rep_data = sim_data(r=1e-5, omg=1, ngene=300,ss1=ss[i,1],ss2=ss[i,2])
       irr_data = sim_data(r=0.795, omg=1, ngene=200,ss1=ss[i,1],ss2=ss[i,2])
       heterodata = rbind(null_data, rep_data, irr_data)
     
      write.table(heterodata,file=paste0("sim_SS",3,"_",ss[i,1],"_",ss[i,2],"_",j,".dat",sep=""),
                   sep=" ",row.names = TRUE,col.names = FALSE)
	   }   
   }
}




