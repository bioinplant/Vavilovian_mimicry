###PopGenome.R###
###VCF(after bgzip and tabix)
###GFF(no blank line and \#)
###population information:pop1(under selection),pop2(wild/natural)
###Rscript $0 VCF_file gff_file pop1 pop2 scaffold

library(PopGenome);
args<-commandArgs(T);

##read VCF and gff
GENOME.class<-readVCF(args[1],1000000,args[5],1,100000000,include.unknown=TRUE,gffpath=args[2]);

##set population
pop1<-scan(args[3],list(""));
pop2<-scan(args[4],list(""));
GENOME.class<-set.populations(GENOME.class, list(pop1[[1]],pop2[[1]]),diploid=FALSE);

##split to genes
GENOME.class.split<-splitting.data(GENOME.class, subsites="gene");

##region sites
##GENOME.class.split@n.sites
##position information
##GENOME.class.split@region.names

scaffold <-data.frame(rep(args[5],times=length(GENOME.class.split@region.names)));
colnames(scaffold)<-c("scaffold");

##neural test
GENOME.class.split <- neutrality.stats(GENOME.class.split);
##get.neutrality(GENOME.class.split)
##detailed information
tajima_pop1<-get.neutrality(GENOME.class.split,theta=TRUE)[[1]];
tajima_pop2<-get.neutrality(GENOME.class.split,theta=TRUE)[[2]];
tajima<-cbind(tajima_pop1[,1],tajima_pop1[,2],tajima_pop1[,10],tajima_pop1[,11],tajima_pop2[,1],tajima_pop2[,2],tajima_pop2[,10],tajima_pop2[,11]);
colnames(tajima)<-c("Tajima1","K1","thetaT1","thetaW1","Tajima2","K2","thetaT2","thetaW2");

##Linkage
##GENOME.class.split <- linkage.stats(GENOME.class.split);
##get.linkage(GENOME.class.split)[[1]];

##Fst
GENOME.class.split <- F_ST.stats(GENOME.class.split);
##get.F_ST(GENOME.class.split)[[1]];
Fst<-GENOME.class.split@nucleotide.F_ST   ##pop1&pop2 nucleotide Fst;
colnames(Fst)<-c("Fst");

##diveristy
GENOME.class.split <- diversity.stats(GENOME.class.split,pi=FALSE);
##get.diversity(GENOME.class.split)[[1]];   ##pop1
##get.diversity(GENOME.class.split)[[2]];   ##pop2
diversity1 <-GENOME.class.split@nuc.diversity.within; ##pop1&pop2 nucleotide diversity
#diversity2 <-GENOME.class.split@Pi;
RD1 <-data.frame(diversity1[,2]/diversity1[,1]);
#RD2 <-data.frame(diversity2[,2]/diversity2[,1]);
colnames(RD1) <-c("RD1");
#colnames(RD2) <-c("RD2");
Diversity<-cbind(diversity1,RD1);

sum <-cbind(scaffold, tajima, Fst, Diversity);
output <- paste(args[5],"stat",sep=".");
write.table(sum, file=output, sep="\t", quote=F);
