###SMC++split Second Step
## smc++ vcf2smc vcf.gz pop.smc.gz <contig> CEU:NA12878,NA12879

#! /usr/bin/perl
use warnings;
#use strict;

my $vcf_file=shift || die "perl $0 vcf_file group1 group1 group2 group2_ID chr";
my $group1=shift || die "perl $0 vcf_file group1 group1 group2 group2_ID chr";
my $group1_ID=shift || die "perl $0 vcf_file group1 group1 group2 group2_ID chr";
my $group2=shift || die "perl $0 vcf_file group1 group1 group2 group2_ID chr";
my $group2_ID=shift || die "perl $0 vcf_file group1 group1 group2 group2_ID chr";
#my $chr=shift || die "perl $0 vcf_file group1 group1 group2 group2_ID chr";

my $line1=`cat $group1_ID| perl -npe 's/\n/,/g'| perl -npe 's(,\$)()'`;
my $line2=`cat $group2_ID| perl -npe 's/\n/,/g'| perl -npe 's(,\$)()'`;

for ($i=14;$i<1001;$i++){
	print "outputting scaffold$i\n";
	system(qq(/root/anaconda3/bin/smc++ vcf2smc $vcf_file joint_$group1$group2.scaffold$i.smc.gz scaffold$i $group1:$line1 $group2:$line2));
	system(qq(/root/anaconda3/bin/smc++ vcf2smc $vcf_file joint_$group2$group1.scaffold$i.smc.gz scaffold$i $group2:$line2 $group1:$line1));
	system(qq(echo scaffold$i.smc.gz is finished!********\n));
}
