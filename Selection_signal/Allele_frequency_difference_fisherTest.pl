#!/usr/bin/perl

## USAGE: perl $0 SNP_Allecount_file (from vcftools --counts);
## input file format: $scaf1, $start, $end, $gene, $scaf2,$pos, $Ref, $Alt, $G1_c1, $G1_c2, $G2_c1, $G2_c2, $impact;

use warnings;

my $count= shift || die "no SNP_count file";

open IN,$count;
open OUT,">$count.fisher";

while (<IN>){
	chomp;
	my ($scaf1, $start, $end, $gene, $scaf2, $pos, $Ref, $Alt, $G1_c1, $G1_c2, $G2_c1, $G2_c2, $impact)=split /\t/,$_;
	#print $_."\n";
	system(qq(Rscript /***/fisher_test.R $G1_c1 $G1_c2 $G2_c1 $G2_c2 >> $count.log ));
	#print $_."\n";
	#print $pval."\n";
	#print OUT $scaf."\t".$pos."\t".$Ref."\t".$Alt."\t".$mimic_c1."\t".$mimic_c2."\t".$nonmimic_c1."\t".$nonmimic_c2."\t".$pval."\n";
}

close OUT;
close IN;
system(qq(cat $count.log | cut -d' ' -f2| sed "/^\$/d"  > $count.pvalue));
system(qq(rm $count.log));
system(qq(paste $count $count.pvalue > $count.fisher ));
system(qq(rm $count.pvalue));
