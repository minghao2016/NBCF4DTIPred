
computeSimFromY <- function(
  Y,
  simMethod = "PPMI"
) {
  
  ##### INPUT
  ## Y: matrix, binary matrix with {0, 1} entries
  ## simMethod: character string, which method to be used
  
  
  # source("calcXnorm.R")
  
  
  if (simMethod == "PPMI") {
    cat("PPMI...\n")
    
    ## Cij <- t(Y) %*% Y
    Cij <- crossprod(Y)
    
    ## exchange 0 <=> 1
    Y[Y == 1] <- 2
    Y[Y == 0] <- 1
    Y[Y == 2] <- 0
    
    Cij <- Cij + crossprod(Y)
    
    diag(Cij) <- 0
    
    Pi <- colSums(Cij)
    allSum <- sum(Pi)
    P <- allSum * Cij / (Pi %*% t(Pi))
    ppmi <- log2(P)
    # ppmi <- log(P) ## natural logarithm
    ppmi[ppmi < 0] <- 0
    
    simCC <- ppmi

  } 
  else if (simMethod == "tanimoto") {
    
    cat("Jaccard similarity...\n")
    flush.console()
    
    ## same to calTanimotoSimMat()
    simCC <- calJaccardMat(t(Y))
    
  } 
  else if (simMethod == "cosine") {
    
    cat("cosine...\n")
    flush.console()
    
    ## cosine based on col-col (col-wise)
    simCC <- crossprod(Y) / tcrossprod(sqrt(colSums(Y ^ 2)))
    
  } 
  else if (simMethod == "dice") {
    
    cat("dice...\n")
    flush.console()
    
    ## YtY = t(Y) %*% Y
    a <- crossprod(Y)
    numCol <- ncol(Y)
    ## col sum of Y
    csY <- colSums(Y)
    c <- matrix(csY, nrow = numCol, ncol = numCol) - a
    b <- t(c)
    simCC <- (2 * a) / (2 * a + b + c) ## col by col, NOT row by row
  }
  else {
    stop("no such similarity!\n")
  }
  
  return(simCC)
}








