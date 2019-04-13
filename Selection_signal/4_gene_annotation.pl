#! /usr/bin/perl

use warnings;
#use strict;

my $genelist = shift || die "genelist format: scaf start end geneID";
my $go_base = "/***/genome_annotation/EC.go_new";
my $pfam_base= "/***/genome_annotation/EC.pfam_new";
my $plantArchi = "/***/EC_plantArchitec_100gene_v3_blastp_best_hits.motified";
my $rice_2K_base = "/***/EC_blastp_2000_rice_gene_1e-5_result_best_hits.motified.motified";
my $rice_genome = "/***/Ecrus-galli_prot_riceGenome_blasp_e5_best_hits.motified";
my $maize_3K_base = "/***/EC_blastp_3000_maize_gene_1e-5_result_best_hits.motified.motified";
my $swiss_base_base = "/***/EC_v6_2_swiss-port_blastp_result_best_hits.motified";
my $TAIR="/***/EC_TAIR_gene_blatp_besthit_modified";
my %hash1;
my %hash2;
my %hash4;
my %hash5;
my %hash6;
my %hash7;
my %hash8;
my %hash9;


open IN1,$go_base;
while (<IN1>){
	chomp;
	my ($go_gene,$GO)=split /\t/,$_;
	$hash1{$go_gene}=$GO;
}

open IN2,$pfam_base;
while(<IN2>){
	chomp;
	my ($pfam_gene, $pfam)=split /\t/,$_;
	$hash2{$pfam_gene}=$pfam;
}

open IN4,$rice_2K_base;
while (<IN4>){
	chomp;
	my ($rice2K_gene,)=split /\t/,$_;
	$hash4{$rice2K_gene}=$_;
}

open IN5,$maize_3K_base;
while (<IN5>){
	chomp;
	my ($maize_gene,)=split /\t/,$_;
	$hash5{$maize_gene}=$_;
}

open IN6,$swiss_base_base;
while (<IN6>){
	chomp;
	my ($swiss_gene,) = split /\t/,$_;
	$hash6{$swiss_gene}=$_;
}

open IN7,$plantArchi;
while (<IN7>){
        chomp;
        my ($plantArchi_gene,) = split /\t/,$_;
        $hash7{$plantArchi_gene}=$_;
}

open IN8,$rice_genome;
while (<IN8>){
        chomp;
        my ($rice_gene,) = split /\t/,$_;
        $hash8{$rice_gene}=$_;
}

open IN9,$TAIR;
while (<IN9>){
        chomp;
        my ($tair_gene,) = split /\t/,$_;
        $hash9{$tair_gene}=$_;
#	print $tair_gene."\n";
#	print $hash9{$tair_gene}."\n";
}

my $t11="NA\t" x 11;
my $t12="NA\t" x 12;
my $t13="NA\t" x 13;
my $t14="NA\t" x 14;
my $t8 = "NA\t" x 8;

open IN10,$genelist;
open OUT,">$genelist.annotation";
print OUT "scaffold"."\t"."start"."\t"."end"."\t"."ECgene"."\t"."GO"."\t"."pfam"."\t"."gene_EC"."\t"."gene_PlantArchi"."\t".$t8."E_value"."\t"."score"."\t"."gene_EC_2Krice"."\t"."gene_2Krice"."\t".$t8."E_value"."\t"."score"."\t"."function"."\t"."name"."\t"."Os_locus"."\t"."gene_EC"."\t"."rice_genome"."\t".$t8."E_value"."\t"."score"."\t"."gene_EC_maize"."\t"."gene_maize"."\t".$t8."E_value"."\t"."score"."\t"."name"."\t"."function"."\t"."gene_EC_sp"."\t"."gene_sp"."\t".$t8."E_value"."\t"."score"."\t"."function"."\t"."gene_EC_tair"."\t"."tair_gene"."\t"."pvalue"."\t"."score"."\t"."symbol"."\t"."descrip"."\n";
while (<IN10>){
	chomp;
	s/"//g;
	my ($s,$st,$en,$stat_gene)= split /\t/,$_;
	if (!exists $hash1{$stat_gene}){ $hash1{$stat_gene}="NA";}
	if (!exists $hash2{$stat_gene}){ $hash2{$stat_gene}="NA";}
#	if (!exists $hash3{$stat_gene}){ $hash3{$stat_gene}=$t12."NA";}
	if (!exists $hash4{$stat_gene}){ $hash4{$stat_gene}=$t14."NA";}
	if (!exists $hash5{$stat_gene}){ $hash5{$stat_gene}=$t13."NA";}
	if (!exists $hash6{$stat_gene}){ $hash6{$stat_gene}=$t12."NA";}
	if (!exists $hash7{$stat_gene}){ $hash7{$stat_gene}=$t11."NA";}
	if (!exists $hash8{$stat_gene}){ $hash8{$stat_gene}=$t11."NA";}
	if (!exists $hash9{$stat_gene}){ $hash9{$stat_gene}="NA\tNA\tNA\tNA\tNA\tNA";}
#	print $hash9{$stat_gene}."\n";
	print OUT $_."\t".$hash1{$stat_gene}."\t".$hash2{$stat_gene}."\t".$hash7{$stat_gene}."\t".$hash4{$stat_gene}."\t".$hash8{$stat_gene}."\t".$hash5{$stat_gene}."\t".$hash6{$stat_gene}."\t".$hash9{$stat_gene}."\n";
}

system(qq(cat $genelist.annotation| cut -f1,2,3,4,5,6,8,17,20,29,31,32,33,35,44,44,47,56,58,59,61,70,72,74,75,77,78 > $genelist.annotations ));
system(qq(rm $genelist.annotation));
