sim_data<-function(k, omg, n=2, sd=1){
   
    beta = rnorm(1, mean=0, sd = omg)
    bv = rnorm(n, mean = beta, sd=k*abs(beta))
    zv = sapply(bv, function(x) rnorm(1,mean=x,sd=sd))
    rst = sapply(zv, function(x) c(x,sd))

    return(as.vector(rst))

}






null_data = t(sapply(1:4000, function(x) sim_data(k=0,omg=0)))
rep_data = t(sapply(1:900, function(x) sim_data(k=0.1, omg=1)))
irr_data = t(sapply(1:100,  function(x) sim_data(k=2, omg=1)))

data = rbind(null_data, rep_data, irr_data)

n = dim(data)[1]

name = paste("gene", 1:n, sep="")
outd = cbind(as.character(name), data)

write(file="sim.2.dat", t(outd), ncol = 5)




