

evalMPR <- function(Ypred,
                    testSet,
                    ## "percentile" or "percentage"
                    evalMethod = "percentile") {
  
  ##### INPUT
  # Ypred: matrix, Y matrix with predicted scores of real values
  # testSet: matrix, #testSet * 2 matrix
  
  ##### OUTPUT
  ##
  
  
  if (evalMethod == "percentile") {
    cat("calculate mean [percentile] ranking...\n")
    
    ## mean 'percentile' ranking
    ## MPR
    percentileRank <- function(x) {
      ####S INPUT
      ## x: vector, unsorted predicted scores for current row (either target or drug)
      
      ##### OUTPUT
      ## pr: vector, with percentile rank
      
      rx <- rle(sort(x))
      smaller <- cumsum(c(0, rx$lengths))[seq(length(rx$lengths))]
      larger <- rev(cumsum(c(0, rev(rx$lengths))))[-1]
      rxpr <- smaller / (smaller + larger)
      res <- rxpr[match(x, rx$values)]
      pr <- 1 - res
      names(pr) <- names(x)
      return(pr)
    }
    
    isCalcByRow <- TRUE
    
    if (isCalcByRow) {
      
      cat("percentile: MPR calculation by row\n")
      ## tested rows, we calculate PR row-by-row
      testedRow <- sort(unique(testSet[, "row"]))
      MPR <- 0
      for (i in testedRow) {
        ypredi <- Ypred[i, ]
        ## percentile ranking result: prr
        prr <- percentileRank(ypredi)
        idxTest <- testSet[testSet[, "row"] == i, "col"]
        MPR <- MPR + mean(prr[idxTest])
      }
      MPR <- MPR / length(testedRow)
      
    } else {
      
      cat("percentile: MPR calculation by col\n")
      ## tested columns, we calculate PR col-by-col
      testedCol <- sort(unique(testSet[, 2]))
      MPR <- 0
      for (i in testedCol) {
        ypredi <- Ypred[, i]
        ## percentile ranking result: prr
        prr <- percentileRank(ypredi)
        idxTest <- testSet[testSet[, 2] == i, 1]
        MPR <- MPR + mean(prr[idxTest])
      }
      MPR <- MPR / length(testedCol)
    }
    
  } else {
    ##########################
    ##########################
    ##########################
    ## mean percentage ranking
    cat("calculate mean [percentage] ranking...\n")
    
    isCalcFromCol <- FALSE
    
    if (isCalcFromCol) {
      ## MPR by column
      cat("percentage: col-wise MPR...\n")
      testedCol <- sort(unique(testSet[, 2]))
      numRow <- nrow(Ypred)
      MPR <- 0
      for (j in testedCol) {
        yhatj <- Ypred[, j]
        sortedIndex <- sort(yhatj, decreasing = TRUE, index.return = TRUE)$ix
        testedRowIndex <- testSet[testSet[, 2] %in% j, 1]
        PR <- sum((match(testedRowIndex, sortedIndex) / numRow)) / length(testedRowIndex)
        MPR <- MPR + PR
      }
      MPR <- MPR / length(testedCol)
      
    } else {
      ## MPR by row, should use this one
      cat("percentage: row-wise MPR...\n")
      testedRow <- sort(unique(testSet[, 1]))
      numCol <- ncol(Ypred)
      MPR <- 0
      for (i in testedRow) {
        yhati <- Ypred[i, ]
        sortedIndex <- sort(yhati, decreasing = TRUE, index.return = TRUE)$ix
        testedColIndex <- testSet[testSet[, 1] %in% i, 2]
        PR <- sum(match(testedColIndex, sortedIndex) / numCol) / length(testedColIndex)
        MPR <- MPR + PR
      }
      MPR <- MPR / length(testedRow)
    }
  }
  
  ## result
  metrics <- matrix(NA, nrow = 1, ncol = 1)
  colnames(metrics) <- c("MPR")
  metrics <- as.data.frame(metrics)
  metrics[1, ] <- MPR
  
  return(metrics)
}





