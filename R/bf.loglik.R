#' Bayes Factor Loglikelihood Function
#'
#' Calculate the updated loglikelihood value in EM algorithm, and to evaluate whether converge or not.
#'
#' @param w The current weight vector
#' @param bf A vector recording all the bayes factor values in log scale.
#'
#' @return  Negative summation of loglikelihood values.
#'
#'
bf.loglik<-function(w,bf){
  K<-length(w)
  n<-length(bf)/K
  loglik<-0
  sumloglik<-0
  for (i in 1:n){
    med<-exp(log(w)+bf[((i-1)*K+1):(i*K)]-bf.weighted_sum(w,bf,i))
    loglik<-sum(bf[((i-1)*K+1):(i*K)]*med+log(w)*med)
    sumloglik<-sumloglik+loglik
  }
  return(-sumloglik)
}
