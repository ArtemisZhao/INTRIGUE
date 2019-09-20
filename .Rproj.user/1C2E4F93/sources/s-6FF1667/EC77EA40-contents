#' Bayes Factor EM Updating Scheme
#'
#' A function that describes the updating process in E step and M step for EM algorithm. It will be used in SQUAREM package.
#'
#' @param w The weight vector in previous M step.
#' @param bf A vector recording all the bayes factor values.
#'
#' @return The updated weight vector in current M step(wnew).
#'
#' @export
#'
bf.em<-function(w,bf){
  K<-length(w)
  wnew<-rep(NA,K)
  n<-length(bf)/K
  ei<-matrix(NA,n,K)
  for (i in 1:n){
    ei[i,]<-w*bf[((i-1)*K+1):(i*K)]/sum(w*bf[((i-1)*K+1):(i*K)])
  }
  wnew<-colSums(ei)/sum(ei)
  w<-wnew
  return(wnew)
}

