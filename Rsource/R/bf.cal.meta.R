#' Bayes Factor Calculation Scheme for META prior
#'
#' A function that calculates bayes factor for each data pair on each grid point
#'  in log scale.
#'
#' @param data A dataset which is constructed by pairs of coefficient
#' values \eqn{ \beta } and standard errors \eqn{ se(\beta)}.
#' @param hyperparam A two-dimensional vector denoting all the grid points,
#' namely, \eqn{\phi} x \eqn{\omega}.
#' @param bf.only A boolean, denoting whether this function is called to calculate
#' Bayes factor for META prior only. Usually used when publication bias issue is the target.
#'
#' @return A list records all the log scale bayes factor values or a list records log scale
#' bayes factor for null, reproducible and irreproducible model (when bf.only=TRUE).
#'
#' @export
bf.cal.meta<-function(data,hyperparam=NULL,bf.only=FALSE){
  if (bf.only==TRUE){
    if (is.null(hyperparam)){
      rcd_phi<-c()
      for (k in 1:(ncol(data)/2)){
        rcd_phi<-rbind(rcd_phi,data[,2*(k-1)+1]^2+data[,2*(k-1)+2]^2)
      }
        phi_min<-sqrt(mean(rcd_phi))
        phi_max<-sqrt(quantile(rcd_phi,0.99))

        philist<-phi_max
        med<-phi_max
      #### start from maxphi and go down
        while (med>phi_min){
           med<-med/sqrt(2)
           philist<-c(philist,med)
        }
        phi<-philist^2
        rep=c(0,6e-3,0.024)
        irre<-c(0.500,0.655,0.795)
        r<-c(rep,irre)
      #### Compute k values
        hyperparam<-c()
      for (i in 1:length(r)){
        kk<-phi*r[i]
        oa<-phi*(1-r[i])
        param<-cbind(kk,oa)
        hyperparam<-rbind(hyperparam,param)
      }
    }
  }
  param<-rbind(c(0,0),hyperparam)
  n<-nrow(data)
  m<-ncol(data)/2
  K<-nrow(param)
  log10_bf<-rep(0,n*K)

  for (i in 1:n){
    for (k in 1:K) {
      bm=0
      vm2=0
      sumw=0
      oa2<-param[k,2]
      phi2<-param[k,1]
      for (j in 1:m){
        beta<-data[i,2*(j-1)+1]
        ds2<-data[i,2*(j-1)+2]^2
        w<-1/(ds2+phi2)
        bm<-bm+beta*w
        sumw<-sumw+w
        vm2=vm2+w
        log10_bf[(i-1)*K+k]<-log10_bf[(i-1)*K+k]+0.5*log(ds2/(ds2+phi2))+0.5*(beta^2/ds2)*(phi2/(ds2+phi2))
      }
      bm<-bm/sumw
      vm2<-1/vm2
      log10_bf[(i-1)*K+k]<-log10_bf[(i-1)*K+k]+0.5*log(vm2/(oa2+vm2))+0.5*(bm^2/vm2)*(oa2/(vm2+oa2))
    }
  }

  if (bf.only==TRUE){
    rval<-hyperparam[,1]/(hyperparam[,1]+hyperparam[,2])
    bf.null<-log10_bf[1]
    bf.rep<-sum(log10_bf[which(rval<0.050)+1])
    bf.irr<-sum(log10_bf[which(rval>0.050)+1])
    return(c(bf.null,bf.rep,bf.irr))
  }

  else{
  return(log10_bf)}
}
