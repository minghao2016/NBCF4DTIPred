## http://stats.stackexchange.com/questions/49453/calculating-jaccard-or-other-association-coefficient-for-binary-data-using-matri
#'
#'
#'
#' use sparse matrix to calculate tanimoto similarity matrix
#'
#'
#' @param descMat input matrix, which is usually descritor (fingerprints {0, 1}) matrix
#'
#'
#'
#'




calTanimotoSimMat <- function(descMat) {
  ## check if input is matrix
  is_mat <- is.matrix(descMat)
  if (!is_mat) {
    stop("Input should be Matrix, not data.frame and others!")
  }

  ## check if {0, 1}
  Lev <- levels(factor(descMat))
  all_in <- Lev %in% c("0", "1")
  if (sum(!all_in) != 0) {
    stop("Input should be {0, 1} matrix!!!")
  }


  ## common values:
  A <- tcrossprod(descMat)
  ## indexes for non-zero common values
  im <- which(A > 0, arr.ind = TRUE)
  ## counts for each row
  b <- rowSums(descMat)

  ## only non-zero values of common
  Aim <- A[im]

  ## Jacard formula: #common / (#i + #j - #common)
  ## library(Matrix)
  J <- sparseMatrix(
    i = im[, 1],
    j = im[, 2],
    x = Aim / (b[im[, 1]] + b[im[, 2]] - Aim),
    dims = dim(A)
  )

  ## convert to common matrix
  J <- as.matrix(J)

  ## remove attribute, then the result is equalto that from calJaccardMat.R
  J <- unname(J)

  return(J)
}





