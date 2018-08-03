
calcXnorm <- function(X, normMethod = "row") {
  ## INPUT
  ##   X: original matrix
  ##   normMethod: "row", "col", "frtc" [first row then col] or "fctr" [first col then row]
  
  ## OUTPUT
  ##   Xnorm: normalized X
  
  
  if (normMethod == "row") {
    cat("row-wise normalization...\n")
    rowNorm <- sqrt(rowSums(X ^ 2))
    rowNorm[rowNorm == 0] <- 1
    Xnorm <- X / rowNorm
    
  } else if (normMethod == "col") {
    cat("col-wise normalization...\n")
    colNorm <- sqrt(colSums(X ^ 2))
    colNorm[colNorm == 0] <- 1
    colNorm <- diag(1 / colNorm)
    Xnorm <- X %*% colNorm
    
  } else if (normMethod == "frtc") {
    cat("1st row-wise, 2nd col-wise normalization...\n")
    ## 1st row-norm
    rowNorm <- sqrt(rowSums(X ^ 2))
    rowNorm[rowNorm == 0] <- 1
    X <- X / rowNorm
    ## 2nd col-norm
    colNorm <- sqrt(colSums(X ^ 2))
    colNorm[colNorm == 0] <- 1
    colNorm <- diag(1 / colNorm)
    Xnorm <- X %*% colNorm
    
  } else if (normMethod == "fctr") {
    cat("1st col-wise, 2nd row-wise normalization...\n")
    ## 1st col-norm
    colNorm <- sqrt(colSums(X ^ 2))
    colNorm[colNorm == 0] <- 1
    colNorm <- diag(1 / colNorm)
    X <- X %*% colNorm
    ## 2nd row-norm
    rowNorm <- sqrt(rowSums(X ^ 2))
    rowNorm[rowNorm == 0] <- 1
    Xnorm <- X / rowNorm
    
  } else {
    stop("Please specify the normMethod as one of [row, col, frtc, fctr]")
  }
  
  return(Xnorm)
}

## for test: 2018-02-23
# X <- rbind(c(1, 2, 3),
#            c(4, 5, 6))
# 
# calcXnorm(X)
# calcXnorm(X, "row")
# calcXnorm(X, "col")
# calcXnorm(X, "frtc")
# calcXnorm(X, "fctr")
