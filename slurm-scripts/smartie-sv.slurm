#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=120gb
#SBATCH --partition=Draco
#SBATCH --mail-type=end
#SBATCH --mail-user=kkrishn8@uncc.edu


module load anaconda3 

source  activate smartie

perl run-smartie.pl grassl Grassl/Assembly/Flye/40-polishing/filtered_contigs.fasta BTx623 /projects/cooper_research/Ref_Genomes/BTx623/Sbicolor_chr1_10.fa 

conda deactivate


