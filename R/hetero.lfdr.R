#' Local False Discovery Rate Evaluation
#'
#' @param catfinal The final individual-level probabilities of falling into three
#' categories, separately.
#' @param fdr.level Rejection level for Local false discovery rate, if not specified, the rejection
#' decision procedure won't be run.
#'
#' @return
#' A list that preserves local false discovery rate and the corresponding reject
#'  decision if called.
#'
hetero.lfdr<-function(cat,fdr.level){
  if (is.null(fdr.level)){
    lfdr<-1-cat[,2]
    return(lfdr)
  }
  else{
    res<-list(2)
    lfdr<-1-cat[,2]
    res[[1]]<-lfdr
    n<-nrow(cat)

    lfdr<-cbind(c(1:n),lfdr)
    lfdr_sort<-lfdr[order(lfdr[,2]),]

    FDR<-cumsum(lfdr_sort[,2])/1:n
    rejresult<-cbind(lfdr_sort[,1],(FDR>=fdr.level))
    rejresult<-rejresult[order(rejresult[,1]),]

    res[[2]]<-as.logical(rejresult[,2])
    return(res)
  }
}

