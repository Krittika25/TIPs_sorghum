#!/usr/bin/perl

use strict;
use warnings;

#Using the .INS file instead of .INS.gz
#nrTElib.fa created by CD-HIT clustering; duplicates removed

my $bedFile="BTx623.merged.INS"; 
my %index2Info=();
my $output="BTx623.merged.INS.Seq.fa";
my $TElib="../nrTElib.fa";

&generateFastaFromBed($bedFile, \%index2Info, $output);

my $output2="BTx623.merged.INS.withMorethan80_TE_cov";
&runBlast($output, $TElib, \%index2Info, $output2); 

sub generateFastaFromBed {
  
    my ($bedFile, $index2Info, $output) = @_;

    my $count = 0;
    open IN0, "<$bedFile";
    open OUT0, ">$output";
    <IN0>;
    while(<IN0>){
      chomp;
      $count += 1;
      my @temp = split(/\t/, $_);
      next, if($temp[6] =~ /NN/ || length($temp[6]) < 50); 
      $index2Info ->{$count} = \@temp; 
      print OUT0 ">$count\n", $temp[6], "\n";
    }
    close IN0;
    close OUT0;

}

sub runBlast {

    my ($output, $TELib, $index2Info, $output2) = @_;

    
    `makeblastdb -in  $TELib  -parse_seqids -hash_index  -out  $TELib  -dbtype nucl`, if(not -e $TELib.".nsq"); 

    `blastn -db $TELib -query $output  -out $output.blastn -num_threads 3 -outfmt 6  -perc_identity 80  -word_size 50`;    ##- percent identity 80%

    my %id2coverdLen = ();
    my %id2Pos = ();

    open IN2, "$output.blastn";    
    while(<IN2>){
      chomp;
      my @temp = split(/\t/, $_);
      for(my $m=$temp[6]; $m<=$temp[7]; $m++){
          $id2Pos{$temp[0]}{$m} = "Y";
      }
    }
    close IN2;

    for my $key1(keys %id2Pos){
        my @PosArray = keys %{$id2Pos{$key1}};
           $id2coverdLen{$key1} = scalar(@PosArray);
    }
    %id2Pos = ();
    
    open OUTX, ">$output2";
    for my $idIndex(keys %id2coverdLen){
        my $TElen = $id2coverdLen{$idIndex};
        
        my @info = @{$index2Info ->{$idIndex}};
        my $TEcoverage = $TElen/$info[4]; 

        if($TEcoverage >= 0.8){
           print OUTX join("\t", @info), "\n";
        }
    } 
    close OUTX;


}
