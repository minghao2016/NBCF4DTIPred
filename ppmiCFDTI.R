

ppmiCFDTI <- function(db = "hao",
                      nfold = 10,
                      nsplit = 5,
                      simMethod = "PPMI",
                      isLowRankApprox = FALSE,
                      lowRankMethod = "SVD",
                      isNormScoreMat = FALSE,
                      hasDTHybrid = FALSE,
                      smoothing = FALSE) {
  
  
  
  ## packages
  library(data.table)
  library(irlba)
  library(Rcpp)
  library(reshape2)
  
  ## R functions
  source("splitData.R")
  source("computeSimFromY.R")
  source("lowRankApproxSimScore.R")
  source("evalMPR.R")
  source("calJaccardMat.R")
  source("calTanimotoSimMat.R")
  source("Recommendation.R")
  source("calcXnorm.R")
  
  if (db == "hao") {
    cat("db = hao", "\n")
    flush.console()
    
    simDrug <- read.csv("Dataset1\\simCID_881_drugBank.csv")
    simDrug <- as.matrix(simDrug) ## 829 drugs * 829 drugs
    
    simProt <- read.table("Dataset1\\newSimSeq.k3")
    simProt <- as.matrix(simProt) ## 733 targets * 733 targets
    
    adjMat <- read.table("Dataset1\\newAdj")
    adjMat <- as.matrix(adjMat)
    adjMat <- t(adjMat) ## 733 targets * 829 drugs
    
  } else if (db == "kuang") {
    cat("db = kuang", "\n")
    flush.console()
    
    simDrug <- read.table("Dataset2\\drug ChemSimilarity.txt", sep = ",")
    simDrug <- as.matrix(simDrug) ## 786 drugs * 786 drugs 
    
    simProt <- read.table("Dataset2\\target SeqSimilarity.txt", sep = ",")
    simProt <- as.matrix(simProt) ## 809 targets * 809 targets
    
    adjMat <- read.table("Dataset2\\adjacent Matrix.txt", sep = ",")
    adjMat <- as.matrix(adjMat)
    adjMat <- t(adjMat) ## 809 targets 786 drugs
    
  } else if (db == "e") {
    cat("db = e", "\n")
    flush.console()
    
    simDrug <- read.table("Dataset3\\e_simmat_dc.txt")
    simDrug <- as.matrix(simDrug) ## 445 drugs * 445 drugs
    
    simProt <- read.table("Dataset3\\e_simmat_dg.txt")
    simProt <- as.matrix(simProt) ## 664 targets * 664 targets
    
    adjMat <- read.table("Dataset3\\e_admat_dgc.txt")
    adjMat <- as.matrix(adjMat) ## 664 targets *  445 drugs
    
  } else {
    stop("no such database\n")
  }
  
  ## create folds of 5 trials of 10-fold cross-validation
  folds <- splitData(adjMat = adjMat, nfold = nfold, nsplit = nsplit)
  
  ## saving results
  resMetrics <- matrix(NA, nrow = nfold, ncol = 1)
  colnames(resMetrics) <- c("MPR")
  resMetrics <- as.data.frame(resMetrics)
  finalResult <- vector("list", length = nsplit)
  
  ## number of rows
  numR <- nrow(adjMat)
  numC <- ncol(adjMat)
  
  
  ##======================================
  ## smoothing prediction?
  thisBeta <- 0.95
  thisAlpha <- thisGamma <- (1 - thisBeta) / 2
  ##======================================
  
  
  ## main computation of 5 trials of 10-fold CV
  for (i in 1:nsplit) {
    for (j in 1:nfold) {
      cat("numSplit:", i, "/", nsplit, ";", "kfold:", j, "/", nfold, "\n")
      flush.console()
      
      trainFold <- folds[[i]][[j]][["trainFold"]]
      
      if (hasDTHybrid) {
        cat("doing DTHybrid...\n")
        flush.console()
        Ypred <- computeRecommendation(A = trainFold, lambda = 0.5, alpha = 0.4, S = simProt, S1 = simDrug)
        
      } else {
        ## column-column similarity
        simCC <- computeSimFromY(trainFold, simMethod = simMethod)
        
        trainIndexByRow <- folds[[i]][[j]][["trainIndexByRow"]]
        ## predicted scores
        Ypred <- lowRankApproxSimScore(numR, numC, trainIndexByRow, simCC, 
                                       isLowRankApprox = isLowRankApprox, 
                                       isNormScoreMat = isNormScoreMat,
                                       lowRankMethod = lowRankMethod)
        
        if (smoothing) {
          
          cat("perform smoothing...\n")
          cat("thisAlpha =", thisAlpha, "\n")
          cat("thisBeta =", thisBeta, "\n")
          cat("thisGamma =", thisGamma, "\n")
          
          Ypred <- thisAlpha * (simProt %*% Ypred) + thisBeta * Ypred + thisGamma * (Ypred %*% simDrug)
        }
      }
      
      ## statistical results 
      testSet <- folds[[i]][[j]][["testIndex"]]
      statMerics <- evalMPR(Ypred, testSet)
      resMetrics[j, ] <- statMerics
    }
    finalResult[[i]] <- resMetrics
  }
  
  ## combine result
  resCom <- as.data.frame(data.table::rbindlist(finalResult))
  resMean <- colMeans(resCom)
  resSd <- apply(resCom, 2, sd)
  
  
  ## save the result
  
  if (!hasDTHybrid) {
    res4plot <- data.frame(resCom, alg = simMethod)  
  } else {
    res4plot <- data.frame(resCom, alg = "dthybrid")
  }
  
  
  
  if (!hasDTHybrid) {
    res4plotName <- paste0(db, "_",  "smoothing.", smoothing, "_","isLowRankApprox.", isLowRankApprox, "_", simMethod, ".RData")
  } else {
    res4plotName <- paste0(db, "_",  "dthybrid", ".RData")
  }
  
  save(res4plot, file = res4plotName)
  
  
  
  
  if (hasDTHybrid) {
    cat("DTHybrid...\n")
    savedFileName <- paste0("db=", db, "_dthybrid_MPR=")
    cat(savedFileName, round(resMean, 3), "+\\-", round(resSd, 3),  "\n")
    
  } else if (isLowRankApprox) {
    cat("low-rank...\n")
    savedFileName <- paste0("db=", db, 
                            "_lowRankMethod=", lowRankMethod,
                            "_isNormScoreMat=", isNormScoreMat,
                            "_simMethod=", simMethod,
                            "_isSmoothing=", smoothing,
                            "_MPR=")
    cat(savedFileName, round(resMean, 3), "+\\-", round(resSd, 3),  "\n")
    
  } else {
    cat("no low-rank...\n")
    savedFileName <- paste0("db=", db, 
                            "_noLowRank", 
                            "_simMethod=", simMethod,
                            "_isSmoothing=", smoothing,
                            "_MPR=")
    cat(savedFileName, round(resMean, 3), "+\\-", round(resSd, 3),  "\n")
  }
  
  ## save to file
  curDate <- format(Sys.time(), format = "%Y%m%d")
  curTime <- format(Sys.time(), format =  "%Hh%Mm%Ss")
  saveToFile <- paste0(savedFileName, 
                          round(resMean, 3), 
                          "+-", 
                          round(resSd, 3), 
                          "_", 
                          curDate, "_", 
                          curTime, 
                          ".RData")
 
  cat("saved file name:", saveToFile, "\n\n")
  
  # save.image(file = savedFileName)
  
  saveToFileSink <- paste0(savedFileName, 
                           round(resMean, 3), 
                           "+-", 
                           round(resSd, 3), 
                           "_", 
                           curDate, "_", 
                           curTime, 
                           ".txt")
  sink(saveToFileSink)
  sink()
  
}










