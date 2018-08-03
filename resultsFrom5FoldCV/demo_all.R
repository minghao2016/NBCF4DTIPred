## demo

rm(list = ls())
setwd("C:\\Users\\kevin\\Desktop\\NBCF4DTIPred-master") ## change to the direcotry including all source codes and datasets
source("ppmiCFDTI.R")



dat <- c("hao", "kuang", "e")
numFolds <- 5 ## default 10

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
## make picture

rm(list = ls())
setwd("C:/Users/kevin/Desktop/NBCF4DTIPred-master")


## strategy 1
## hao_srep
load("hao_smoothing.FALSE_isLowRankApprox.FALSE_PPMI.RData")
res4plot_PPMI <- res4plot

load("hao_smoothing.FALSE_isLowRankApprox.FALSE_cosine.RData")
res4plot_cosine <- res4plot

load("hao_smoothing.FALSE_isLowRankApprox.FALSE_tanimoto.RData")
res4plot_tanimoto <- res4plot

## dthybrid
load("hao_dthybrid.RData")
res4plot_dthybrid <- res4plot

hao <- rbind(res4plot_PPMI, res4plot_cosine, res4plot_tanimoto, res4plot_dthybrid)
###



## kuang_srep
load("kuang_smoothing.FALSE_isLowRankApprox.FALSE_PPMI.RData")
res4plot_PPMI <- res4plot

load("kuang_smoothing.FALSE_isLowRankApprox.FALSE_cosine.RData")
res4plot_cosine <- res4plot

load("kuang_smoothing.FALSE_isLowRankApprox.FALSE_tanimoto.RData")
res4plot_tanimoto <- res4plot

## dthybrid
load("kuang_dthybrid.RData")
res4plot_dthybrid <- res4plot

kuang <- rbind(res4plot_PPMI, res4plot_cosine, res4plot_tanimoto, res4plot_dthybrid)
###



## yamanishi_bioinf
load("e_smoothing.FALSE_isLowRankApprox.FALSE_PPMI.RData")
res4plot_PPMI <- res4plot

load("e_smoothing.FALSE_isLowRankApprox.FALSE_cosine.RData")
res4plot_cosine <- res4plot

load("e_smoothing.FALSE_isLowRankApprox.FALSE_tanimoto.RData")
res4plot_tanimoto <- res4plot

## dthybrid
load("e_dthybrid.RData")
res4plot_dthybrid <- res4plot

yaman <- rbind(res4plot_PPMI, res4plot_cosine, res4plot_tanimoto, res4plot_dthybrid)
###




## strategy 2
## hao_srep
load("hao_smoothing.FALSE_isLowRankApprox.TRUE_PPMI.RData")
res4plot_PPMI_svd <- res4plot

load("hao_smoothing.FALSE_isLowRankApprox.TRUE_cosine.RData")
res4plot_cosine_svd <- res4plot

load("hao_smoothing.FALSE_isLowRankApprox.TRUE_tanimoto.RData")
res4plot_tanimoto_svd <- res4plot

## dthybrid
load("hao_dthybrid.RData")
res4plot_dthybrid <- res4plot

hao_svd <- rbind(res4plot_PPMI_svd, res4plot_cosine_svd, res4plot_tanimoto_svd, res4plot_dthybrid)
###



## kuang_srep
load("kuang_smoothing.FALSE_isLowRankApprox.TRUE_PPMI.RData")
res4plot_PPMI_svd <- res4plot

load("kuang_smoothing.FALSE_isLowRankApprox.TRUE_cosine.RData")
res4plot_cosine_svd <- res4plot

load("kuang_smoothing.FALSE_isLowRankApprox.TRUE_tanimoto.RData")
res4plot_tanimoto_svd <- res4plot

## dthybrid
load("kuang_dthybrid.RData")
res4plot_dthybrid <- res4plot

kuang_svd <- rbind(res4plot_PPMI_svd, res4plot_cosine_svd, res4plot_tanimoto_svd, res4plot_dthybrid)
###



## yamanishi_bioinf
load("e_smoothing.FALSE_isLowRankApprox.TRUE_PPMI.RData")
res4plot_PPMI_svd <- res4plot

load("e_smoothing.FALSE_isLowRankApprox.TRUE_cosine.RData")
res4plot_cosine_svd <- res4plot

load("e_smoothing.FALSE_isLowRankApprox.TRUE_tanimoto.RData")
res4plot_tanimoto_svd <- res4plot

## dthybrid
load("e_dthybrid.RData")
res4plot_dthybrid <- res4plot

yaman_svd <- rbind(res4plot_PPMI_svd, res4plot_cosine_svd, res4plot_tanimoto_svd, res4plot_dthybrid)
###




## strategy 3
## hao_srep
load("hao_smoothing.TRUE_isLowRankApprox.FALSE_PPMI.RData")
res4plot_PPMI_smooth <- res4plot

load("hao_smoothing.TRUE_isLowRankApprox.FALSE_cosine.RData")
res4plot_cosine_smooth <- res4plot

load("hao_smoothing.TRUE_isLowRankApprox.FALSE_tanimoto.RData")
res4plot_tanimoto_smooth <- res4plot

## dthybrid
load("hao_dthybrid.RData")
res4plot_dthybrid <- res4plot

hao_smooth <- rbind(res4plot_PPMI_smooth, res4plot_cosine_smooth, res4plot_tanimoto_smooth, res4plot_dthybrid)
###



## kuang_srep
load("kuang_smoothing.TRUE_isLowRankApprox.FALSE_PPMI.RData")
res4plot_PPMI_smooth <- res4plot

load("kuang_smoothing.TRUE_isLowRankApprox.FALSE_cosine.RData")
res4plot_cosine_smooth <- res4plot

load("kuang_smoothing.TRUE_isLowRankApprox.FALSE_tanimoto.RData")
res4plot_tanimoto_smooth <- res4plot

## dthybrid
load("kuang_dthybrid.RData")
res4plot_dthybrid <- res4plot

kuang_smooth <- rbind(res4plot_PPMI_smooth, res4plot_cosine_smooth, res4plot_tanimoto_smooth, res4plot_dthybrid)
###



## yamanishi_bioinf
load("e_smoothing.TRUE_isLowRankApprox.FALSE_PPMI.RData")
res4plot_PPMI_smooth <- res4plot

load("e_smoothing.TRUE_isLowRankApprox.FALSE_cosine.RData")
res4plot_cosine_smooth <- res4plot

load("e_smoothing.TRUE_isLowRankApprox.FALSE_tanimoto.RData")
res4plot_tanimoto_smooth <- res4plot

## dthybrid
load("e_dthybrid.RData")
res4plot_dthybrid <- res4plot

yaman_smooth <- rbind(res4plot_PPMI_smooth, res4plot_cosine_smooth, res4plot_tanimoto_smooth, res4plot_dthybrid)
###




## figure
#pdf("MPR.pdf", width = 9, height = 9)
tiff("MPR.tiff", 
     width = 24, 
     height = 24, 
     units = "cm", 
     res = 600, 
     compression = "lzw")
## par(mfrow = c(2, 2), xpd = TRUE, mar = c(5, 4, 4, 2) + 0.1)
par(mfrow = c(3, 3), xpd = TRUE, mar = c(3.7, 3.7, 2, 0.5) + 0.1)

## strategy 1
## hao_srep
boxplot(MPR ~ alg, data = hao, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.030, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
# mtext(side = 2, text = expression(italic("MPR")), line = 2)
mtext(side = 2, text = "MPR", line = 2)
mtext("(A) DATASET-H (Strategy 1)", line = 0.5)

## kuang_srep
boxplot(MPR ~ alg, data = kuang, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.033, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
mtext(side = 2, text = "MPR", line = 2)
mtext("(B) DATASET-K (Strategy 1)", line = 0.5)

## yamanishi_srep
boxplot(MPR ~ alg, data = yaman, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.0075, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
mtext(side = 2, text = "MPR", line = 2)
mtext("(C) DATASET-Y (Strategy 1)", line = 0.5)
###


## strategy 2
## hao_srep
boxplot(MPR ~ alg, data = hao_svd, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.038, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
# mtext(side = 2, text = expression(italic("MPR")), line = 2)
mtext(side = 2, text = "MPR", line = 2)
mtext("(D) DATASET-H (Strategy 2)", line = 0.5)

## kuang_srep
boxplot(MPR ~ alg, data = kuang_svd, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.0357, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
mtext(side = 2, text = "MPR", line = 2)
mtext("(E) DATASET-K (Strategy 2)", line = 0.5)

## yamanishi_srep
boxplot(MPR ~ alg, data = yaman_svd, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.008, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
mtext(side = 2, text = "MPR", line = 2)
mtext("(F) DATASET-Y (Strategy 2)", line = 0.5)
###


## strategy 3
## hao_srep, smooth
boxplot(MPR ~ alg, data = hao_smooth, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.047, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
# mtext(side = 2, text = expression(italic("MPR")), line = 2)
mtext(side = 2, text = "MPR", line = 2)
#mtext(expression(paste("Hao_srep ", "(with ", italic(S)[D], " and ", italic(S)[T], ")")), line = 0.5)
mtext("(G) DATASET-H (Strategy 3)", line = 0.5)

## kuang_srep
boxplot(MPR ~ alg, data = kuang_smooth, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.0357, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
mtext(side = 2, text = "MPR", line = 2)
mtext("(H) DATASET-K (Strategy 3)", line = 0.5)

## yamanishi_srep
boxplot(MPR ~ alg, data = yaman_smooth, col = "lightgray", 
        xaxt = "n")
text(1:4, y = 0.0133, 
     labels = c("PPMI", "Cosine", "Tanimoto", "DT-Hybrid"), 
     srt = 45, 
     adj = 1, 
     xpd = TRUE)
mtext(side = 2, text = "MPR", line = 2)
mtext("(I) DATASET-Y (Strategy 3)", line = 0.5)
###
dev.off()





###
### revised manuscript for adding pairwise t-test
## strategy 1
hao
## strategy 1, dataset h, and method
s1_h_ppm <- hao[hao$alg == "PPMI", 1]
s1_h_cos <- hao[hao$alg == "cosine", 1]
s1_h_tan <- hao[hao$alg == "tanimoto", 1]

mean(s1_h_ppm)
mean(s1_h_cos)
mean(s1_h_tan)

## pairwise t-test
t.test(s1_h_ppm, s1_h_cos, paired = TRUE, conf.level = 0.99)
t.test(s1_h_ppm, s1_h_tan, paired = TRUE, conf.level = 0.99)
t.test(s1_h_cos, s1_h_tan, paired = TRUE, conf.level = 0.99) ## 0.04024

kuang
## strategy 1, dataset k, and method
s1_k_ppm <- kuang[kuang$alg == "PPMI", 1]
s1_k_cos <- kuang[kuang$alg == "cosine", 1]
s1_k_tan <- kuang[kuang$alg == "tanimoto", 1]

mean(s1_k_ppm)
mean(s1_k_cos)
mean(s1_k_tan)

## pairwise t-test
t.test(s1_k_ppm, s1_k_cos, paired = TRUE, conf.level = 0.99)
t.test(s1_k_ppm, s1_k_tan, paired = TRUE, conf.level = 0.99)
t.test(s1_k_cos, s1_k_tan, paired = TRUE, conf.level = 0.99) ## 0.6184

yaman
## strategy 1, dataset k, and method
s1_y_ppm <- yaman[yaman$alg == "PPMI", 1]
s1_y_cos <- yaman[yaman$alg == "cosine", 1]
s1_y_tan <- yaman[yaman$alg == "tanimoto", 1]

mean(s1_y_ppm)
mean(s1_y_cos)
mean(s1_y_tan)

## pairwise t-test
t.test(s1_y_ppm, s1_y_cos, paired = TRUE, conf.level = 0.99)
t.test(s1_y_ppm, s1_y_tan, paired = TRUE, conf.level = 0.99)
t.test(s1_y_cos, s1_y_tan, paired = TRUE, conf.level = 0.99) ## 0.4337

## strategy II
hao_svd
s2_h_cos <- hao_svd[hao_svd$alg == "cosine", 1]
mean(s2_h_cos)












