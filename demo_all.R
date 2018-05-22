## demo

rm(list = ls())
setwd("C:\\Users\\kevin\\Desktop\\YourDir") ## change to the direcotry including all source codes and datasets
source("ppmiCFDTI.R")


dat <- c("hao", "kuang", "e")
for (db in dat) {
 
   ## 1.1
  ## just pure similarity
  
  ## PPMI
  ppmiCFDTI(
    db = db,
    nfold = 10,
    nsplit = 5,
    simMethod = "PPMI"
  )
  
  ## tanimoto
  ppmiCFDTI(
    db = db,
    nfold = 10,
    nsplit = 5,
    simMethod = "tanimoto"
  )
  
  ## cosine
  ppmiCFDTI(
    db = db,
    nfold = 10,
    nsplit = 5,
    simMethod = "cosine"
  )
  
  
  ## DTHybrid ###
  
  ppmiCFDTI(
    db = db,
    nfold = 10,
    nsplit = 5,
    hasDTHybrid = TRUE
  )
  
  
  ## strategy 2
  ## svd
  
  ## PPMI
  ppmiCFDTI(
    db = db,
    nfold = 10,
    nsplit = 5,
    simMethod = "PPMI",
    isLowRankApprox = TRUE,
    lowRankMethod = "SVD"
  )
  
  ## tanimoto
  ppmiCFDTI(
    db = db,
    nfold = 10,
    nsplit = 5,
    simMethod = "tanimoto",
    isLowRankApprox = TRUE,
    lowRankMethod = "SVD"
  )
  
  ## cosine
  ppmiCFDTI(
    db = db,
    nfold = 10,
    nsplit = 5,
    simMethod = "cosine",
    isLowRankApprox = TRUE,
    lowRankMethod = "SVD"
  )
  
  

  ## strategy 3
  
  ## smoothing
  
  ## PPMI
  ppmiCFDTI(
    db = db,
    nfold = 10,
    nsplit = 5,
    simMethod = "PPMI",
    smoothing = TRUE
  )
  
  ## tanimoto
  ppmiCFDTI(
    db = db,
    nfold = 10,
    nsplit = 5,
    simMethod = "tanimoto",
    smoothing = TRUE
  )
  
  ## cosine
  ppmiCFDTI(
    db = db,
    nfold = 10,
    nsplit = 5,
    simMethod = "cosine",
    smoothing = TRUE
  )
}






