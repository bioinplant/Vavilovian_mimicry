#!/usr/bin/perl
#use warnings;
#use strict;
die("Usage: perl $0 <vcf file> <filter ratio>\n") if @ARGV != 2;
open FH_IN, "$ARGV[0]";
open FH_OUT_S, ">$ARGV[0].het$ARGV[1].summary";
open FH_OUT_V, ">$ARGV[0].het$ARGV[1].vcf";
my $ratio_f = $ARGV[1];
print FH_OUT_S "scaffold\tposition\tRef\tAle\thet_count\thet_ratio\tHomAle_count\tHomAle_ratio\tHomRef_count\tHomRef_ratio\n";
my $count4=0;
my $count5=0;
while(<FH_IN>){
	chomp;
	if (/^#/){print FH_OUT_V $_."\n";}
	else{
	#print $_."\n";
	my @tmp = split /\t/,$_;
	#print @tmp."\n";
	my $count1=0;
        my $count2=0;
        my $count3=0;
	for(my $i = 9; $i < @tmp;$i++){
		#print $i."\n";
		$count1++ if $tmp[$i]=~/^0\/1:/;
		$count2++ if $tmp[$i]=~/^1\/1:/;
		$count3++ if $tmp[$i]=~/^0\/0:/;
		}
	#print $count1."\n";
	my $ratio1 = $count1/(@tmp - 9);
	my $ratio2 = $count2/(@tmp - 9);
	my $ratio3 = $count3/(@tmp - 9);
	print FH_OUT_S "$tmp[0]\t$tmp[1]\t$tmp[3]\t$tmp[4]\t$count1\t$ratio1\t$count2\t$ratio2\t$count3\t$ratio3\n";
	$count4++ if $ratio1 <= $ratio_f;
	$count5++;
	print FH_OUT_V "$_\n" if $ratio1 <= $ratio_f;
	}
}

open OUT,">$ARGV[0].het$ARGV[1].log";
print OUT $count4."\t snps of ".$count5." snps  are keeping with het ratio < $ARGV[1]";
