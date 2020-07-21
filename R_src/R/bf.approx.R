#' Bayes Factor Approximation
#'
#'A function calculates the approximation for bayes factor, when the value of original bayes factor goes to infinity.
#'
#' @param z The index for individual(i).
#' @param param Input dataset.
#' @param size Number of replicates(m).
#' @param k2 Grid value of \eqn{k^2}.
#' @param oa2 Grid value of \eqn{\omega^2}.
#'
#' @return
#' Approximation for bayes factor in log scale.
#'
#'
bf.approx<-function(z,param,size,k2,oa2){
  bm=0
  vm2=0
  sumw=0
  log_ABF=0
  phi2 <- oa2*k2

  for (j in 1:size)
  {
    beta <- param[z,2*(j-1)+1]
    ds2 <- param[z,2*(j-1)+2]**2
    w <- 1/(ds2+phi2)
    bm = bm + beta*w
    sumw = sumw + w
    vm2 = vm2 + w

    log_ABF<-log_ABF+0.5*log(ds2*w)+0.5*(beta^2/ds2)*(phi2*w)
  }
  bm=bm/sumw
  vm2<-1/vm2
  log_ABF<-log_ABF+0.5*log(vm2/(oa2+vm2))+0.5*((bm^2)/vm2)*(oa2/(vm2+oa2))

  return(log_ABF)
}
