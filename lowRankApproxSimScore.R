
lowRankApproxSimScore <- function(
  numR,
  numC,
  trainIndexByRow,
  simCC,
  isLowRankApprox = TRUE,
  isNormScoreMat = FALSE,
  lowRankMethod = "SVD"
) {
  ##### INPUT
  ##
  ##
  ##
  ##
  
  ##### OUTPUT
  
  ## store neighbor scores for each row (either target or drug)
  ## it has the same shape with adjacency matrix, Y
  neigScoreMat <- matrix(0, nrow = numR, ncol = numC)
  
  for (i in 1:numR) {
    ## training index for current row (either target or drug)
    idxTr <- trainIndexByRow[[i]]
    
    ## neighbor scores for current row
    neigScore <- simCC[, idxTr]
    if (is.matrix(neigScore)) {
      neigScore <- rowSums(neigScore)
    }
    neigScoreMat[i, ] <- neigScore
  }
  
  
  ## row-normalized score
  if (isNormScoreMat) {
    cat("perform row-wise nomalization of score matrix...\n")
    neigScoreMat <- calcXnorm(neigScoreMat, "row")
  }
  
  
  ## need low-rank approximation?
  if (isLowRankApprox) {
    
    if (lowRankMethod == "SVD") {
      cat("SVD decomposition\n")
      flush.console()
      svdRank <- 100
      cat("SVD rank =", svdRank, "\n")
      svdRes <- irlba(neigScoreMat, nv = svdRank)
      # str(svdRes)
      U <- svdRes$u
      S <- svdRes$d
      V <- svdRes$v
      U <- U %*% diag(S)
      predScoreMat <- U %*% t(V)
      
    } else {
      stop("please specify low-rank method\n")
    }
    
  } else {
    
    cat("without low-rank approximation\n")
    flush.console()
    
    predScoreMat <- neigScoreMat
  }
  
  # cat("min =", min(predScoreMat), "\n")
  return(predScoreMat)
}






