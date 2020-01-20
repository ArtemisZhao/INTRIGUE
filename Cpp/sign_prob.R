sim_data<-function(k, omg, sd=1){

    beta = rnorm(1, mean=0, sd = omg)
    bv = rnorm(2, mean = beta, sd=k*abs(beta))
    zv = sapply(bv, function(x) rnorm(1,mean=x,sd=sd))
    sign = (zv[1]*zv[2]>0)+0
    w1 = 1/sqrt(k*k+sd^2/beta^2)
    b2b = 0.5*(zv[2]^2+zv[1]^2-2*sd^2)
    w2 =  1/sqrt(k*k+sd^2/b2b)
    w3 = 1/sqrt(k*k+sd^2/omg^2)
    prob1 = pnorm(-w1)^2 + (1-pnorm(-w1))^2
    prob2 = pnorm(-w2)^2 + (1-pnorm(-w2))^2
    prob3 = pnorm(-w3)^2 + (1-pnorm(-w3))^2
    prob4 = pnorm(-1/sqrt(k*k+sd^2/zv[1]^2))*pnorm(-1/sqrt(k*k+sd^2/zv[2]^2)) + (1-pnorm(-1/sqrt(k*k+sd^2/zv[1]^2)))*(1-pnorm(-1/sqrt(k*k+sd^2/zv[2]^2)))
    return(c(sign, prob1, prob2, prob3, prob4))

}

d = t(sapply(1:10000, function(x) sim_data(0.4,5)))
apply(d,2,mean)
