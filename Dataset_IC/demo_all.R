## demo

rm(list = ls())
setwd("Your dir") ## change to the direcotry including all source codes and datasets
source("ppmiCFDTI.R")



dat <- "ic"
numFolds <- 10 ## default 10

for (db in dat) {
 
   ## 1.1
  ## just pure similarity
  
  ## PPMI
  ppmiCFDTI(
    db = db,
    nfold = numFolds,
    nsplit = 5,
    simMethod = "PPMI"
  )
  
  ## tanimoto
  ppmiCFDTI(
    db = db,
    nfold = numFolds,
    nsplit = 5,
    simMethod = "tanimoto"
  )
  
  ## cosine
  ppmiCFDTI(
    db = db,
    nfold = numFolds,
    nsplit = 5,
    simMethod = "cosine"
  )
  
  
  ## DTHybrid ###
  
  ppmiCFDTI(
    db = db,
    nfold = numFolds,
    nsplit = 5,
    hasDTHybrid = TRUE
  )
  
  
  ## strategy 2
  ## svd
  
  ## PPMI
  ppmiCFDTI(
    db = db,
    nfold = numFolds,
    nsplit = 5,
    simMethod = "PPMI",
    isLowRankApprox = TRUE,
    lowRankMethod = "SVD"
  )
  
  ## tanimoto
  ppmiCFDTI(
    db = db,
    nfold = numFolds,
    nsplit = 5,
    simMethod = "tanimoto",
    isLowRankApprox = TRUE,
    lowRankMethod = "SVD"
  )
  
  ## cosine
  ppmiCFDTI(
    db = db,
    nfold = numFolds,
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
    nfold = numFolds,
    nsplit = 5,
    simMethod = "PPMI",
    smoothing = TRUE
  )
  
  ## tanimoto
  ppmiCFDTI(
    db = db,
    nfold = numFolds,
    nsplit = 5,
    simMethod = "tanimoto",
    smoothing = TRUE
  )
  
  ## cosine
  ppmiCFDTI(
    db = db,
    nfold = numFolds,
    nsplit = 5,
    simMethod = "cosine",
    smoothing = TRUE
  )
}




## 2018-08-02 for revised paper
## make picture for IC

rm(list = ls())
setwd("Your dir")


## Strategy 1
## yamanishi_bioinf
load("ic_smoothing.FALSE_isLowRankApprox.FALSE_PPMI.RData")
res4plot_PPMI <- res4plot

load("ic_smoothing.FALSE_isLowRankApprox.FALSE_cosine.RData")
res4plot_cosine <- res4plot

load("ic_smoothing.FALSE_isLowRankApprox.FALSE_tanimoto.RData")
res4plot_tanimoto <- res4plot

## dthybrid
load("ic_dthybrid.RData")
res4plot_dthybrid <- res4plot

ic <- rbind(res4plot_PPMI, res4plot_cosine, res4plot_tanimoto, res4plot_dthybrid)
###


## strategy 2
## hao_srep
load("ic_smoothing.FALSE_isLowRankApprox.TRUE_PPMI.RData")
res4plot_PPMI_svd <- res4plot

load("ic_smoothing.FALSE_isLowRankApprox.TRUE_cosine.RData")
res4plot_cosine_svd <- res4plot

load("ic_smoothing.FALSE_isLowRankApprox.TRUE_tanimoto.RData")
res4plot_tanimoto_svd <- res4plot

## dthybrid
load("ic_dthybrid.RData")
res4plot_dthybrid <- res4plot

ic_svd <- rbind(res4plot_PPMI_svd, res4plot_cosine_svd, res4plot_tanimoto_svd, res4plot_dthybrid)
###


## strategy 3
load("ic_smoothing.TRUE_isLowRankApprox.FALSE_PPMI.RData")
res4plot_PPMI_smooth <- res4plot

load("ic_smoothing.TRUE_isLowRankApprox.FALSE_cosine.RData")
res4plot_cosine_smooth <- res4plot

load("ic_smoothing.TRUE_isLowRankApprox.FALSE_tanimoto.RData")
res4plot_tanimoto_smooth <- res4plot

## dthybrid
load("ic_dthybrid.RData")
res4plot_dthybrid <- res4plot

ic_smooth <- rbind(res4plot_PPMI_smooth, res4plot_cosine_smooth, res4plot_tanimoto_smooth, res4plot_dthybrid)
###

## figure
#pdf("MPR.pdf", width = 9, height = 9)
tiff("MPR.tiff", 
     width = 24, 
     height = 8, 
     units = "cm", 
     res = 600, 
     compression = "lzw")
## par(mfrow = c(2, 2), xpd = TRUE, mar = c(5, 4, 4, 2) + 0.1)
par(mfrow = c(1, 3), xpd = TRUE, mar = c(3.7, 3.7, 2, 0.5) + 0.1)

## strategy 1
boxplot(MPR ~ alg, data = ic, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.025, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
# mtext(side = 2, text = expression(italic("MPR")), line = 2)
mtext(side = 2, text = "MPR", line = 2)
mtext("(A) IC (Strategy 1)", line = 0.5)

## strategy 2
boxplot(MPR ~ alg, data = ic_svd, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.031, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
# mtext(side = 2, text = expression(italic("MPR")), line = 2)
mtext(side = 2, text = "MPR", line = 2)
mtext("(B) IC (Strategy 2)", line = 0.5)

## strategy 3
boxplot(MPR ~ alg, data = ic_smooth, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.020, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
# mtext(side = 2, text = expression(italic("MPR")), line = 2)
mtext(side = 2, text = "MPR", line = 2)
#mtext(expression(paste("Hao_srep ", "(with ", italic(S)[D], " and ", italic(S)[T], ")")), line = 0.5)
mtext("(C) IC (Strategy 3)", line = 0.5)

###
dev.off()









