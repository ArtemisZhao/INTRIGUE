#' Bayes Factor Calculation Scheme for META prior
#'
#' A function that calculates bayes factor for each data pair on each grid point
#'  in log scale.
#'
#' @param data A dataset which is constructed by pairs of coefficient
#' values \eqn{ \beta } and standard errors \eqn{ se(\beta)}.
#' @param hyperparam A two-dimensional vector denoting all the grid points,
#' namely, \eqn{\phi} x \eqn{\omega}.
#'
#'
#' @return A list records all the log scale bayes factor values.
bf.cal.meta<-function(data,hyperparam){
  param<-rbind(c(0,0),hyperparam)
  n<-nrow(data)
  m<-ncol(data)/2
  K<-nrow(param)
  log10_bf<-rep(0,n*K)

  for (i in 1:n){
    bm=0
    vm2=0
    sumw=0
    for (k in 1:K) {
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
  return(log10_bf)
}
