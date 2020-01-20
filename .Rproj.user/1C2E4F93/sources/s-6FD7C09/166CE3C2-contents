#' Bayes Factor Weighted Summation
#'
#'A function calculates the weighted summation of bayes factor.
#'
#' @param w Input weight vector.
#' @param bf Input bayes factor vector
#' @param i Individual index.
#'
#' @return
#' Weighted sum for bayes factor in log scale.
#'
bf.weighted_sum<-function(w,bf,i){
  K<-length(w)
  bf.sum=0
  bf.m<-max(bf[((i-1)*K+1):(i*K)])
  bf.sum=sum(w*exp(bf[((i-1)*K+1):(i*K)]-bf.m))
  return(bf.m+log(bf.sum))
}
