args = commandArgs(trailingOnly=TRUE)
index = args[1]

sim_beta_bar <-function(omg){
    return(rnorm(1,mean=0, sd=omg));
}

sim_beta_s <-function(k, bbar){
    return(rnorm(2, mean=bbar, sd=k*abs(bbar)))
}


E = matrix(rnorm(2*5000), ncol=2)

bb_vec = sapply(1:2500,function(x) sim_beta_bar(sqrt(2)))
beta_matrix_r = t(sapply(bb_vec[1:1500], function(x) sim_beta_s(k=0.1,bbar=x)))
beta_matrix_ir = t(sapply(bb_vec[1501:2500], function(x) sim_beta_s(k=3,bbar=x)))
beta_matrix_null = matrix(rep(0,5000), ncol=2)
beta_matrix = rbind(beta_matrix_null, beta_matrix_ir, beta_matrix_r)
data = E + beta_matrix

id = paste0("gene", 1:5000)
data = cbind(as.character(id), data)

outfile = paste0("sim.s3.",index,".dat")
write(file=outfile, t(data), ncol=3)


