#' Bayes Factor Calculation Scheme for CENF prior
#'
#' A function that calculates bayes factor for each data pair on each grid point
#'  in log scale.
#'
#' @param data A dataset which is constructed by pairs of coefficient
#' values \eqn{ \beta } and standard errors \eqn{ se(\beta)}.
#' @param hyperparam A two-dimensional vector denoting all the grid points,
#' namely, \eqn{k} x \eqn{\omega}.
#'
#'
#' @return A list records all the log scale bayes factor values.
#'
#' @importFrom stats integrate
#' @export
#'
bf.cal.cefn<-function(data,hyperparam){
  K<-nrow(hyperparam)
  m<-ncol(data)/2
  n<-nrow(data)

  bfn<-rep(NA,n*K) ##bayes factor nominator
  bfd<-rep(NA,n) ## bayes factor denominator
  bf<-rep(NA,n*(K+1)) ## bayes factor

  for(i in 1:n){
    for (k in 1:K){
      k2<-hyperparam[k,1]
      oa2<-hyperparam[k,2]
      bfnmed<-integrate(function(x,param=data,z=i,size=m){
        val<-1
        for (j in 1:size)
        {
          beta<-param[z,2*(j-1)+1]
          ds2<-param[z,2*(j-1)+2]**2
          num2<-(beta-x)**2
          dnum<-ds2+k2*x*x
          fac<-1/(2*pi*dnum)
          val=val*sqrt(fac)*exp(-0.5*num2/dnum)
        }
        val=val*exp(-0.5*x*x/oa2)*sqrt(1/(2*pi*oa2))

        return(val)
      },-Inf,Inf)$value
      bfn[(i-1)*K+k]<-log(bfnmed)
    }
  }
  bfn<-unlist(bfn)

  for (i in 1:n){
    bf.null=0
    for (j in 1:m){
      beta<-data[i,2*(j-1)+1]
      ds2<-data[i,2*(j-1)+2]**2
      fac<-1/(2*pi*ds2)
      bf.null<-bf.null+0.5*log(fac)-0.5*beta^2/ds2
    }
    bfd[i]<-bf.null
  }


 for (i in 1:n){
    for (k in 1:K){

      bf[(i-1)*(K+1)+1]<-0

      bfmed<-bfn[(i-1)*K+k]-bfd[i]

      if (is.infinite(bfmed)){
        k2<-hyperparam[k,1]
        oa2<-hyperparam[k,2]

        bfapx<-bf.approx(i,data,m,k2,oa2)

        bf[(i-1)*(K+1)+k+1]<-bfapx
        #print(bfapx)
      }
      else{
      bf[(i-1)*(K+1)+k+1]<-bfmed
      }
    }
  }
  return(bf)
}
