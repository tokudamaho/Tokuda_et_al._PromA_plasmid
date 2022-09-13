# Usage: Rscript --vanilla scripts/my_fna_rho_dist_.R "${seq_pls}" "${seq_chr}" "${wordsize}" "${windowsize}"
# Usage: Rscript --vanilla scripts/my_fna_rho_dist_.R "data/fna.Plasmid/AP018710.fna" "data/fna.Chromosome.KEP/NZ_CP014762.fna" 3 5000

# Load packages
library(seqinr)
library(MASS) # ginv

# Extract Command Line Arguments
args <- commandArgs(trailingOnly = TRUE)
print(args)

file_pls <- args[1]; #file_pls <- "AP023407.1.fasta"
file_chr <- args[2]; #file_chr <- "GCA_014679585.1_ASM1467958v1_genomic.fna.gz"
wordsize <- args[3]; #wordsize <- 3
windowsize <- args[4]; #windowsize <- 5000 
#file_pls <- "AP023407.1.fasta"; file_chr <- "GCA_014679585.1_ASM1467958v1_genomic.fna.gz"; wordsize <- 3; windowsize <- 5000
#file_pls <- "AP023401.1.fasta"; file_chr <- "GCA_014679585.1_ASM1467958v1_genomic.fna.gz"; wordsize <- 3; windowsize <- 5000
#file_pls <- "AP023399.1.fasta"; file_chr <- "GCA_014679585.1_ASM1467958v1_genomic.fna.gz"; wordsize <- 3; windowsize <- 5000

file_pls
file_chr
wordsize <- as.numeric(wordsize); wordsize
windowsize <- as.numeric(windowsize); windowsize

# read.fasta
seq_pls <- read.fasta(file=file_pls, seqtype="DNA", strip.desc=TRUE)[[1]]
seq_chr <- read.fasta(file=file_chr, seqtype="DNA", strip.desc=TRUE)
length(seq_chr)
seq_chr <- seq_chr[sapply(seq_chr, length) > windowsize]
length(seq_chr)

# dir.create
my_rho <- paste0("./my_rho","_wordsize",wordsize,"_windowsize",windowsize); if(!dir.exists(my_rho)) dir.create(path=my_rho)
my_rho_dist <- paste0("./my_rho_dist","_wordsize",wordsize,"_windowsize",windowsize); if(!dir.exists(my_rho_dist)) dir.create(path=my_rho_dist)

# rho chromosome
# https://www.r-bloggers.com/2013/04/wapply-a-faster-but-less-functional-rollapply-for-vector-setups/
wapply <- function(x, width, by = NULL, FUN = NULL, ...)
{
  FUN <- match.fun(FUN)
  if (is.null(by)) by <- width
  
  lenX <- length(x)
  SEQ1 <- seq(1, lenX - width + 1, by = by)
  SEQ2 <- lapply(SEQ1, function(x) x:(x + width - 1))
  
  OUT <- lapply(SEQ2, function(a) FUN(x[a], ...))
  OUT <- base:::simplify2array(OUT, higher = TRUE)
  return(OUT)
}
rho_chr <- t(do.call(cbind, lapply(seq_chr, function(seq) wapply(x = seq, width = windowsize, by = windowsize, FUN = function(x) rho(c(x, ' ', rev(comp(x))), wordsize = wordsize) ) ) ) ) 
#library(zoo); system.time(rho_chr <- rollapply(data = as.zoo(seq_chr), width = windowsize, by = windowsize, FUN = function(x) rho(c(x, ' ', rev(comp(x))), wordsize = wordsize) ) )
cat("\n", paste0(my_rho,"/",basename(file_chr),".txt"), "\n")
write.table(round(rho_chr,2), file = paste0(my_rho,"/",basename(file_chr),".txt"), sep="\t", quote=FALSE, row.names=FALSE)

# rho plasmid
#rho_pls <- as.vector( rho(c(seq_pls, ' ', rev(comp(seq_pls))), wordsize = wordsize) )
rho_pls <- rho(c(seq_pls, ' ', rev(comp(seq_pls))), wordsize = wordsize); rho_pls <- as.vector(rho_pls)

# plasmid-chromosome distance
if(nrow(rho_chr) < ncol(rho_chr)){ d_pls <- d_chr <- "nrow_lt_ncol" } else {
  #d_pls <- try(mahalanobis(rho_pls, center=apply(rho_chr,2,mean), cov=var(rho_chr)), silent=FALSE)
  #d_chr <- try(mahalanobis(rho_chr, center=apply(rho_chr,2,mean), cov=var(rho_chr)), silent=FALSE)
  d_pls <- try(mahalanobis(rho_pls, center=apply(rho_chr,2,mean), cov=ginv(var(rho_chr)), inverted=TRUE), silent=FALSE)
  d_chr <- try(mahalanobis(rho_chr, center=apply(rho_chr,2,mean), cov=ginv(var(rho_chr)), inverted=TRUE), silent=FALSE)
}

Distance <- ifelse(is.numeric(d_pls), d_pls, NA)
P_value <- ifelse(is.numeric(d_chr), mean(d_chr > d_pls), NA)
file_pls <- basename(file_pls)
file_chr <- basename(file_chr)
df <- data.frame(file_pls, file_chr, Distance, P_value)
cat("\n", paste0(my_rho_dist,"/",basename(file_pls),"-",basename(file_chr),".txt"), "\n")
write.table(df, file = paste0(my_rho_dist,"/",file_chr,".txt"), sep="\t", quote=FALSE, row.names=FALSE)

#sessionInfo()
Sys.time()
