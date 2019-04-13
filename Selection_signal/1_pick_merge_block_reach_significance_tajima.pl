#!/usr/bin/perl
###for tajimaD(less value was preferred in selection signal detection);

use warnings;
use strict;

die("Usage: perl $0 <raw file><threshold>") if @ARGV != 2;

open FH_IN, "$ARGV[0]";
my $threshold=$ARGV[1];
open FH_OUT, ">combined_$threshold.$ARGV[0]";

my $title = <FH_IN>;
print FH_OUT $title;

my($chr, $start, $end);

while(<FH_IN>){
	chomp;
	my @tmp = split/\t/;
	if($tmp[0] ne $chr){	#initialize var for each chr
		print FH_OUT "$chr\t$start\t$end\n" if $end > 0;
		$chr = $tmp[0];
		$start = 0;
		$end = 0;
	}
	if($tmp[3] <= $threshold){	#solve each line reach significance
	
		if($tmp[1] <= $end+40000){
			$end = $tmp[2];
		}
		else{
			print FH_OUT "$chr\t$start\t$end\n" if $end > 0;
			$start = $tmp[1];
			$end = $tmp[2];
			}
	}
}
#print the last block
print FH_OUT "$chr\t$start\t$end\n" if $end > 0;

