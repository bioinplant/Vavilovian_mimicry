###SMC++ first Step

## smc++ vcf2smc vcf.gz chr1.smc.gz chr1 CEU:NA12878,NA12879

#! /usr/bin/perl

use warnings;
use strict;

my $vcf_file=shift || die "perl $0 vcf_file groupName AccessionID_file";
my $group=shift || die "perl $0 vcf_file groupName AccessionID_file";
my $AccessionID_file=shift || die "perl $0 vcf_file groupName AccessionID_file";

my $line=`cat $AccessionID_file| perl -npe 's/\n/,/g'`;
my $i=1;
open IN,"$AccessionID_file";
while (<IN>){
	my $d=$_;
	system(qq(cd /workcenters/workcenter1/wudy/EC/SMC++/V2/Group_EC_filtered/G1/$d));
	while ($i<4535){
		system(qq(/root/anaconda3/bin/smc++ vcf2smc -d $d --ignore-missing ../$vcf_file scaffold$i.smc.gz scaffold$i $group:$line));
		#system(qq(echo scaffold$i.smc.gz\n));
		$i++;
	}	
}
