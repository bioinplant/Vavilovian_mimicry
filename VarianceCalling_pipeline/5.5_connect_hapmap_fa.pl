#! /usr/bin/perl

use warnings;

opendir DIR, "./" or die;

@files=readdir(DIR);

foreach $file(@files){
	if($file=~/hapmap.fa/){
		open IN,$file or die;
		while(<IN>){
			chomp;
			if(/>(.*)/){
				$name=$1;
			}
			else{
				$seq{$name}.=$_;
			}
		}
		close IN;
	}
}

close DIR;
	  
open OUT, ">all_chr_filtered_hapmap.fa"or die;
open OUT1, ">all_chr_filtered_hapmap.len"or die;

foreach $name(sort keys %seq){
	$len=length $seq{$name};
	print OUT ">$name\n$seq{$name}\n";
	print OUT1 ">$name\t$len\n";
}
