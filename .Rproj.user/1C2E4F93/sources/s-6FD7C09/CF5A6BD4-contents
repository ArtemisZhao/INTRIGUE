## code to prepare `DATASET` dataset goes here
sim_data<-function(k, omg, n=2, sd=1){

  beta = rnorm(1, mean=0, sd = omg)
  bv = rnorm(n, mean = beta, sd=k*abs(beta))
  zv = sapply(bv, function(x) rnorm(1,mean=x,sd=sd))
  rst = sapply(zv, function(x) c(x,sd))

  return(as.vector(rst))
}


null_data = t(sapply(1:400, function(x) sim_data(k=0,omg=0)))


rep_data = t(sapply(1:100, function(x) sim_data(k=0.1, omg=2)))
irr_data = t(sapply(1:50,  function(x) sim_data(k=3, omg=2)))

heterodata = rbind(null_data, rep_data, irr_data)
usethis::use_data(heterodata,overwrite = TRUE)
