
#######PSMC#########

##consensus sequence
samtools mpileup -Q 30 -q 30 -d 10 -D 50 -u -v -f /***/EC_v6_genome.fasta AH1.sorted.bam | bcftools call -c | perl /***/bcftools/vcfutils.pl vcf2fq -d 7 -D 45 -Q 30 > AH1.fq

#samtools:
# -Q and -q in mpileup determine the cutoffs for baseQ and mapQ, respectively
# -v: tells mpileup to produce vcf output, and -u says that should be uncompressed
# -f: the reference fasta used (needs to be indexed)
# -r: the region to call the mpileup for (in this case, a particular chromosome based on the array task id), -r "scaffold1"
# X.bam is the bam file to use
# bcftools:
# call -c calls a consensus sequence from the mpileup using the original calling method
# vcfutils.pl:
# -d 5 and -d 34 determine the minimum and maximum coverage to allow for vcf2fq, anything outside that range is filtered
# -Q 30 sets the root mean squared mapping quality minimum to 30
##

##convert fq to psmcfa
***/PSMC/utils/fq2psmcfa AH1.fq > AH1.psmcfa

##Run PSMC
./psmc -N 30 -t 15 -r 4 -p “4+25*2+4+6” -o AH1_1.psmc AH1.psmcfa
./psmc -N 30 -t 15 -r 4 -p “4+30*2+4+6+10” -o AH1_2.psmc AH1.psmcfa

## -p: Ne was inferred across 34 free atomic time intervals (4 + 30*2 + 4+6 + 10), which means that the first population-size parameter spans the first four atomic time intervals, each of the next 30 parameters spans two intervals, while the last three parameters span four, six and 10 intervals, respectively;
## -t: the upper limit of the TMRCA;
## -r: the initial θ/ρ value;

##plot
perl ../utils/psmc_plot.pl -u 6.5e-09 -g 1 -p AH1_plot AH1.psmc
## -u: per-generation mutation rate;
## -g: generation time in years