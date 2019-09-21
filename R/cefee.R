#' Barbeta Integration Function
#'
#' @param x Unknown parameter, index the variable to be integrated out.(\eqn{beta})
#' @param param Parameter list.
#' @param z Index for the unit.(i)
#' @param size Index for the number of replicates. (m)
#'
#' @return The value for the function.
#'
#' @export
#'
cefee<-function(x,param=data,z=i,size=m){
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
}
