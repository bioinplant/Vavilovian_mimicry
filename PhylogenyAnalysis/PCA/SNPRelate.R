##Pathway to Data
setwd('$PWD')

library(gdsfmt)
library(SNPRelate)

gds <- createfn.gds("sample.gds")

samples <- read.table("sampleid",header=TRUE)
sample.id <- samples$samples
add.gdsn(gds,"sample.id",sample.id,replace=TRUE,compress="ZIP")

snps <- read.table("snpid",header=TRUE)
snp.id <- snps$snps
add.gdsn(gds,"snp.id",snp.id,replace=TRUE,compress="ZIP")

genos <- data.matrix(read.table("genotypes"))
add.gdsn(gds,"genotype",genos,replace=TRUE,compress="ZIP",storage="bit2")

chrs <- read.table("snp_chromosome",header=TRUE)
chr <- chrs$chromosomes
add.gdsn(gds,"snp.chromosome",chr,replace=TRUE,compress="ZIP")


positions <- read.table("snp_pos",header=TRUE)
posi <- positions$positions
add.gdsn(gds,"snp.position",posi,replace=TRUE,compress="ZIP")

snpalleles <- read.table("snp_alleles",header=TRUE)
allele <- snpalleles$alleles
add.gdsn(gds,"snp.allele",allele,replace=TRUE,compress="ZIP")

closefn.gds(gds)
genofile <- openfn.gds("sample.gds")

pca <- snpgdsPCA(genofile,autosome.only=FALSE)

#write.table("pca_result",c(pca$eigenvect[,1],pca$eigenvect[,2]))

#plot(pca$eigenvect[,1],pca$eigenvect[,2])

result <- as.matrix(cbind(pca$eigenvect[,1],pca$eigenvect[,2]))
result2 <- as.matrix(cbind(pca$eigenvect[,1],pca$eigenvect[,2],pca$eigenvect[,3]),row.names=sample.id)
write.table(result,"PCA_two")
write.table(result2,"PCA_three")




