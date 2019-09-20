#' Bayes Factor Loglikelihood Function
#'
#' Calculate the updated loglikelihood value in EM algorithm, and to evaluate whether converge or not.
#'
#' @param w The current weight vector
#' @param bf A vector recording all the bayes factor values.
#'
#' @return  Negative summation of loglikelihood values.
#'
#' @export
#'
bf.loglik<-function(w,bf){
  K<-length(w)
  n<-length(bf)/K
  loglik<-0
  sumloglik<-1
  for (i in 1:n){
    med<-rep(NA,K)
    med<-w*bf[((i-1)*K+1):(i*K)]/sum(w*bf[((i-1)*K+1):(i*K)])
    loglik[i]<-sum(log(bf[((i-1)*K+1):(i*K)])*med+log(w)*med)
    sumloglik<-sumloglik+loglik[i]
  }
  return(-sumloglik)
}
