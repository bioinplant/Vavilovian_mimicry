###SMC++ first Step_with"-d (distinguished lineage)"
## smc++ vcf2smc vcf.gz chr1.smc.gz chr1 CEU:NA12878,NA12879

#! /usr/bin/perl

use warnings;
#use strict;

my $vcf_file=shift || die "perl $0 vcf_file groupName AccessionID_file distinguished_file";
my $group=shift || die "perl $0 vcf_file groupName AccessionID_file distinguished_file";
my $AccessionID_file=shift || die "perl $0 vcf_file groupName AccessionID_file distinguished_file";
my $dis = shift || die "perl $0 vcf_file groupName AccessionID_file distinguished_file";

my $line=`cat $AccessionID_file| perl -npe 's/\n/,/g'| perl -npe 's(,\$)()'`;
print $line."\n";

my $i=1;
open IN,"$dis";
while (<IN>){
	chomp;
	my $d = $_ ;
	print $d."\n";
	$i=1;
	while ($i<1000){
		system(qq(/root/anaconda3/bin/smc++ vcf2smc --ignore-missing -d $d $d $vcf_file $d.scaffold$i.smc.gz scaffold$i $group:$line));
		system(qq(echo $d.scaffold$i.smc.gz\n));
		$i++;
	}	
}
