#' Heterogeneity Evaluation
#'
#' Evaluating the overall and individually heterogeneity and reproducibility
#' for the given individuals(units) shared in different replicates.
#'
#' @param data A dataset which is constructed by pairs of coefficient
#' values \eqn{ \beta } and standard errors \eqn{ se(\beta)}.
#' @param use_cefn A boolean, denoting whether to use CEFN prior. If the value is TRUE,
#' CEFN prior is used, else, META prior is applied. The default value is TRUE.
#' @param rep A vector, denoting all the \eqn{k^2} (under CEFN prior) or \eqn{r} (under META prior) values constructing the reproducible signals. If not specified,
#' the default one is c(0.105,0.260,0.369), which corresponds to the several prior values satisfy that
#' \eqn{Pr(\beta_{i,1}, \beta_{i,2} have a same sign)=0.99, 0.975, 0.95} for CEFN prior.
#' @param irre  A vector, denoting all the \eqn{k^2} or \eqn{r} values constructing the irreproducible signals. If not specified,
#' the default one is c(2.198, 3.636, 6.735), which corresponds to the several prior values satisfy that
#' \eqn{Pr(\beta_{i,1}, \beta_{i,2} have a same sign)=0.75, 0.70, 0.65} for CEFN prior.
#' @param phi_min A value which determines the maximum \eqn{phi}. If not specified, will be constructed
#' from the input datasets.
#' @param phi_max  A value which determines the minimum \eqn{phi}. If not specified, will be constructed
#' from the input datasets.
#' @param sq_em_tol A small, positive scalar that determines when iterations should be terminated in squarem algorithm.
#' The default value is \eqn{1e-4}.
#' @param fdr.level The user-defined rejection level for false discovery rate.
#' @param sample_size The user-defined sample size.
#'
#' @return
#'
#' A list with the following components:
#' \item{gridweight}{ The final optimal weight vector evaluated on each grid point.}
#' \item{ind_prob}{ A matrix denoting the converged probability for each individual being inside the
#' three different groups, namely, the null, the reproducible and the irreproducible group.}
#' \item{est_prop}{ The estimated proportion value for the three different groups, namely, the null,
#' the reproducible and the irreproducible group.}
#' \item{lfdr}{ The local false discovery rate based on the null hyppthesis of
#' unit belonging to \eqn{H_R}, reproducible group. \eqn{lfdr=1-Pr(H_R)}}
#' \item{significant}{ If fdr.level is specified, a significant object recording
#' True or False will be returned }
#' @importFrom SQUAREM fpiter
#'
#' @importFrom stats runif
#' @importFrom rlist list.append
#'
#' @export
#'
#' @examples
#' data("heterodata")
#' \donttest{
#' hetero.out<-hetero(heterodata,fdr.level=0.05)
#' names(hetero.out)
#' print(hetero.out$est_prop)
#' }
#'
#' ## for CRAN check
#' hetero.out<-hetero(heterodata[1:100,],fdr.level=0.05)
#'
#'

hetero<-function(data,use_cefn=TRUE,rep=NULL,irre=NULL,phi_min=NULL,phi_max=NULL,
                 sq_em_tol=1e-4,fdr.level=NULL,sample_size=NULL){

  ####small sample correction
  sscor<-function(data, sample_size){
    newdata<-c()
    for (i in 1:length(sample_size)){
    t<-data[,2*(i-1)+1]/data[,2*(i-1)+2]
    sd <- data[,2*(i-1)+2]

    p <-  2*pt(q = abs(t) , df = sample_size[i] - 1, lower.tail = FALSE)

    z<-qnorm(p,lower.tail = FALSE)

    newdata<-cbind(newdata,cbind(z*sd,sd))
    }
    return(newdata)
  }

  if (!is.null(sample_size)){
     data<-sscor(data, sample_size)
    }

  ## Hyperparameter Grid set up
  ### omega set up
  rcd_phi<-c()

  for (k in 1:(ncol(data)/2)){
     rcd_phi<-rbind(rcd_phi,data[,2*(k-1)+1]^2+data[,2*(k-1)+2]^2)
  }
  if (is.null(phi_min)){
     phi_min<-sqrt(mean(rcd_phi))
  }
  if (is.null(phi_max)){
     phi_max<-sqrt(quantile(rcd_phi,0.99))
  }

  philist<-phi_max
  med<-phi_max
#### start maxphi and go down
  while (med>phi_min){
    med<-med/sqrt(2)
    philist<-c(philist,med)
  }
  phi<-philist^2

  ### CEFN prior
  if (use_cefn){
    if (is.null(rep)) {
      rep<-c(0.105,0.260,0.369)
    }
    if (is.null(irre)){
      irre<-c(2.198,3.636,6.735)
    }

    kk<-c(rep,irre)
    hyperparam<-c()
    for (i in 1:length(kk)){
      oa<-phi/(1+kk[i])
      param<-cbind(kk[i],oa)
      hyperparam<-rbind(hyperparam,param)
    }

    #### Grid for overall large effect
    for (i in 1:length(kk)){
      oaexp<-max(abs(data[,1]))^2/(kk[i]+1)
      expan<-c(kk[i],oaexp)
      hyperparam<-rbind(hyperparam,expan)
    }
  }

  ### META prior
  else{
    if (is.null(rep)) {
      rep=c(0,6e-3,0.024)
    }
    if (is.null(irre)){
      irre<-c(0.500,0.655,0.795)
    }
    r<-c(rep,irre)
    #### Compute k values
    hyperparam<-c()
    for (i in 1:length(r)){
      kk<-phi*r[i]
      oa<-phi*(1-r[i])
      param<-cbind(kk,oa)
      hyperparam<-rbind(hyperparam,param)
    }
    #### Grid for overall large effect
    for (i in 1:length(r)){
      kkexp<-max(abs(data[,1]))^2*r[i]
      oaexp<-max(abs(data[,1]))^2*(1-r[i])
      expan<-c(kkexp,oaexp)
      hyperparam<-rbind(hyperparam,expan)
    }
  }

  ### Bayes Factor Calculation
  if (use_cefn){
    bf<-bf.cal.cefn(data,hyperparam)
  }
  else{
    bf<-bf.cal.meta(data,hyperparam)
  }

  ### EM Procedure
  #### Package SQUAREM is used
  K<-nrow(hyperparam)+1
  n<-nrow(data)

  cutoff<-rep[length(rep)]
  rval<-hyperparam[,1]/(hyperparam[,1]+hyperparam[,2])

  #######################bf sudo

  nsudo <- ceiling(n*0.01*0.015)
  nnull<- ceiling(n*0.01*0.97)

  if (use_cefn){
    reploc<-which(hyperparam[,1]<=cutoff)
    irrloc<-which(hyperparam[,1]>cutoff)
  }
  if (!use_cefn){
    reploc<-which(rval<=cutoff+0.01)
    irrloc<-which(rval>cutoff+0.01)
  }

  sudorep<-rep(0,K)
  sudoirr<-rep(0,K)
  sudonull<-rep(-1e10,K)
  sudonull[1]<-0
  sudorep[reploc+1]<-1e10
  sudoirr[irrloc+1]<-1e10
  bftest<-c(bf,rep(sudonull,nnull),rep(sudorep,nsudo),rep(sudoirr,nsudo))

 ###############################
  w0<-runif(K)
  w0<-w0/sum(w0)

  #bf.result<-fpiter(w0,bf,fixptfn=bf.em,objfn=bf.loglik,control=list(tol=sq_em_tol))
  bf.result<-fpiter(w0,bftest,fixptfn=bf.em,objfn=bf.loglik,control=list(tol=sq_em_tol))

  wfinal<-bf.result$par

  ### gridweight
  gridweight<-cbind(rbind(c(0,0),hyperparam),wfinal)

  hetero.res<-list(3)
  hetero.res[[1]]<-gridweight


  eifinal<-matrix(NA,n,K)
  catfinal<-matrix(NA,n,3)
  portion<-rep(NA,3)
  rval<-c(0,rval)

  if (use_cefn){
    ### Individual level probability
    for (i in 1:n){
      eifinal[i,]<-exp(log(wfinal)+bf[((i-1)*K+1):(i*K)]-bf.weighted_sum(wfinal,bf,i))
      catfinal[i,1]<-eifinal[i,1] #null
      #reproducible
      catfinal[i,2]<-sum(eifinal[i,which(gridweight[,1]<=cutoff)])-eifinal[i,1]
      #irreproducible
      catfinal[i,3]<-sum(eifinal[i,which(gridweight[,1]>cutoff)])
    }

  }
  else{
    for (i in 1:n){
      eifinal[i,]<-exp(log(wfinal)+bf[((i-1)*K+1):(i*K)]-bf.weighted_sum(wfinal,bf,i))
      catfinal[i,1]<-eifinal[i,1] #null
      #reproducible
      catfinal[i,2]<-sum(eifinal[i,which(rval<=cutoff+0.01)])-eifinal[i,1]
      #irreproducible
      catfinal[i,3]<-sum(eifinal[i,which(rval>cutoff+0.01)])
    }
  }
  hetero.res[[2]]<-catfinal

  if (use_cefn){
    ### Overall proportion
    portion[1]<-gridweight[1,3]#null
    #reproducible
    portion[2]<-sum(gridweight[which(gridweight[,1]<=cutoff),3])-gridweight[1,3]
    #irreproducible
    portion[3]<-sum(gridweight[which(gridweight[,1]>cutoff),3])
  }
  else{
    portion[1]<-gridweight[1,3]#null
    #reproducible
    portion[2]<-sum(gridweight[which(rval<=cutoff+0.01),3])-gridweight[1,3]
    #irreproducible
    portion[3]<-sum(gridweight[which(rval>cutoff+0.01),3])
  }
  hetero.res[[3]]<-portion

  rej_dec<-hetero.lfdr(catfinal,fdr.level)

  if (is.null(fdr.level)){
    hetero.res<-list.append(hetero.res,rej_dec)
    names(hetero.res)<-c("gridweight","ind_prob","est_prop","lfdr")
  }
  else{
    hetero.res<-list.append(hetero.res,rej_dec[[1]],rej_dec[[2]])
    names(hetero.res)<-c("gridweight","ind_prob","est_prop","lfdr","significant")
  }

  return(hetero.res)
}
