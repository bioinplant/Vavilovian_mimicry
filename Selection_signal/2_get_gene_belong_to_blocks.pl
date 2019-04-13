#!/usr/bin/perl

die("Usage: perl $0 <block file>\n") if @ARGV != 1;

####genegff:/public2/wudy/EC/annotation/genome_annotation/Ecrus-galli_v6.annotation_gene.gff3

$annotation="/public2/wudy/EC/annotation/genome_annotation/Ecrus-galli_v6.annotation_gene.gff3";

open FH_IN1, "$annotation";
open FH_IN2, "$ARGV[0]";
open FH_OUT, ">$ARGV[0].gene";

while(<FH_IN1>){
	@tmp = split/\t/, $_;
	seek(FH_IN2, 0, 0);
	while(<FH_IN2>){
		chomp;
		my @tmp_block = split/\t/;
		if($tmp[0] eq $tmp_block[0] && $tmp[3] > $tmp_block[1] && $tmp[4] < $tmp_block[2]){
			print FH_OUT $tmp[0]."\t".$tmp[3]."\t".$tmp[4]."\t".$tmp[8];
			
			last;
		}
		else{
			next;
		}
	}
}
