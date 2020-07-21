set.seed(123)
M = 2  # number of studies
ssize<-c(100,2000)
or = 3/4

N = 2000 # repeats

wipi<-function(p, bias){
   if(bias == 0){
       return(1)
   }

   if(p>0.01){
       return(0)
   }else{
    return(1)
   }
}


datamatrix = matrix(0, nrow=N, ncol=M*2)

for ( k in  1:N){
  
    est_vec = c()
    for (j in 1:M){

      bias = 1
      if(k==2){
          bias = 0
      }

      flag = 0

      while(flag == 0){
        pcontrol<-runif(1,min=0.1,max=0.5)
        ptreat<-pcontrol*or
        
        oddscontrol<-pcontrol/(1-pcontrol)
        oddstreat<-oddscontrol*or

        ptreat<-oddstreat/(oddstreat+1)

        control<-rbinom(ssize[j],1,pcontrol)
        treat<-rbinom(ssize[j],1,ptreat)
        
        datay<-c(control,treat)
        datax<-c(rep(0,ssize[j]),rep(1,ssize[j]))
        est_p<-summary(glm(datay~datax,
                           family="binomial"))$coefficient[2,c(1,2,4)]
        if (wipi(est_p[3],bias) == 1){
              est_vec<-c(est_vec,est_p[1:2])
            flag = 1
        }
      }
      
    }

    datamatrix[k,] = est_vec

}

outd = cbind(as.character(paste0("gene",1:N)),datamatrix)
write(file="bias.dat", t(outd), ncol=2*M+1)







