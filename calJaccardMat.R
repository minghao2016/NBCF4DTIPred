#'
#'
#' Calculate Jaccard coefficient, if input is binary matrix, then it is Tanimoto coefficient
#'
#'
#' @param x: descriptor matrix
#'
#' @return Jaccard coefficient
#'



calJaccardMat <- function(x){
  ## x %*% t(x)
  xtx <- base::tcrossprod(x)
  xtd <- base::diag(xtx)
  xzz <- base::outer(xtd, xtd, '+')
  ## Here, simMat is a symmetrical matrix
  simMat <- xtx / (xzz - xtx)
  ## return result
  return(simMat)
}
