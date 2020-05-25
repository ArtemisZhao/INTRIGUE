## code to prepare `DATASET` dataset goes here
sim_data<-function(k, omg, ngene=100, rep=2, sd=1,ss1=1000,ss2=5000){

  beta = rnorm(ngene, mean=0, sd = omg)

  bv = t(sapply(1:ngene, function(x) rnorm(rep, mean = beta[x], sd=k*abs(beta[x]))))

  x1<-rep(c(0:1),each=ss1/2)
  x2<-rep(c(0,1),each=ss2/2)

  y1<-sapply(1:ngene,function(x) x1*bv[x,1]+rnorm(ss1,sd))
  y2<-sapply(1:ngene,function(x) x2*bv[x,2]+rnorm(ss2,sd))

  est1<-sapply(1:ngene,function(x) summary(lm(y1[,x]~x1))$coefficient[2,1:2])
  est2<-sapply(1:ngene,function(x) summary(lm(y2[,x]~x2))$coefficient[2,1:2])

  rst = cbind(t(est1),t(est2))

  return(rst)
}


null_data =sim_data(k=0, omg=0, ngene=800,ss1=400,ss2=500)
rep_data = sim_data(k=0.1, omg=1, ngene=160,ss1=400,ss2=500)
irr_data = sim_data(k=3, omg=1, ngene=40,ss1=400,ss2=500)

heterodata = rbind(null_data, rep_data, irr_data)

usethis::use_data(heterodata,overwrite = TRUE)
