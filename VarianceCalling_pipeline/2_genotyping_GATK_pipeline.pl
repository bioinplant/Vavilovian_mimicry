#!/usr/bin/perl 

use strict;
use warnings;

my $ref_genome = '/***/EC_v6_genome.fasta';
my $vcf_out = "denovo_genotyping.vcf";

my $gatk_software = "/***/GenomeAnalysisTK.jar";
my $gatk_tmp = 'gatk_tmp';

my ($combined_bams,$bams);

my $bams_file_info = shift || die "bam_file?";
open IN, $bams_file_info;
while(<IN>){
  chomp;
  $bams .= "-I $_ ";	
}
$combined_bams = $1 if $bams =~ /-I (.+)\s+/;

my ($eachscaf_tmp,$eachscaf_vcf);

for my $num (1..4500){
	my $scaf="scaffold"."$num";
	print "$scaf\n";
	$eachscaf_tmp ="scaffold".$num.'.'.$gatk_tmp;
	$eachscaf_vcf ="scaffold".$num.'.'.$vcf_out;
	mkdir $eachscaf_tmp; 
	###SNP and InDel calling
	system(qq(java -Djava.io.tmpdir=./$eachscaf_tmp/ -Xmx50g -jar $gatk_software -R $ref_genome -T UnifiedGenotyper -I $combined_bams -o $eachscaf_vcf -nct 5 -nt 5 -stand_call_conf 30 -L $scaf -glm ALL -allowPotentiallyMisencodedQuals)); 	
}
