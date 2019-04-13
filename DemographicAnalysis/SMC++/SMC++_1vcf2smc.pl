###SMC++split first Step
## smc++ vcf2smc vcf.gz pop.smc.gz <contig> CEU:NA12878,NA12879

#! /usr/bin/perl
use warnings;
#use strict;

my $vcf_file=shift || die "perl $0 vcf_file group1 group1_ID group2 group2_ID chr_file";
my $group1=shift || die "perl $0 vcf_file group1 group1_ID group2 group2_ID chr_file";
my $group1_ID=shift || die "perl $0 vcf_file group1 group1_ID group2 group2_ID chr_file";
my $group2=shift || die "perl $0 vcf_file group1 group1_ID group2 group2_ID chr_file";
my $group2_ID=shift || die "perl $0 vcf_file group1 group1_ID group2 group2_ID chr_file";
#my $chr=shift || die "perl $0 vcf_file group1 group1_ID group2 group2_ID chr_file";

my $line1=`cat $group1_ID| perl -npe 's/\n/,/g'| perl -npe 's(,\$)()'`;
print $line1."\n";
my $line2=`cat $group2_ID| perl -npe 's/\n/,/g'| perl -npe 's(,\$)()'`;
print $line2."\n";

for ($i=26;$i<1001;$i++){
	system(qq(echo scaffold$i.smc.gz\n));
	system(qq(/root/anaconda3/bin/smc++ vcf2smc $vcf_file $group1.scaffold$i.smc.gz scaffold$i $group1:$line1));
	system(qq(/root/anaconda3/bin/smc++ vcf2smc $vcf_file $group2.scaffold$i.smc.gz scaffold$i $group2:$line2));
	#system(qq(echo $d.scaffold$i.smc.gz\n));
}
