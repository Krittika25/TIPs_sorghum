#!/usr/bin/perl

#This script was adapted from the pipeline's Run_smartie-sv.pl
#It has been modified to just run a single genotype at one time instead of providing a list
#of the genotypes
#Input is the contigs FASTA file for each genotype; no conversion function used like in the pipeline script.
#smartie-sv.slurm
#Date: October 26,2022
#Author: Krittika Krishnan

use strict;
use warnings;
use Cwd;

my $in0 = $ARGV[0]; #query prefix
my $in1 = $ARGV[1]; #query FASTA
my $in2 = $ARGV[2]; #ref prefix
my $in3 = $ARGV[3]; #ref FASTA

my$prefix = $in0."-".$in2;

system("mkdir $prefix");
chdir $prefix;

`cp ../config.json .`;
`cp ../config.sh .`;
`cp ../Snakefile .`;

`sed -i 's#ChineseAmber/Assembly/ChineseAmber.contigs.fasta#$in1#' config.json`;
`sed -i 's#ChiAmber#$in0#' config.json`;

`/users/kkrishn8/sw/packages/smartie-sv/55472e4/bin/sawriter $in3`;
`snakemake -s Snakefile -w 50  -p -k -j 20`;
