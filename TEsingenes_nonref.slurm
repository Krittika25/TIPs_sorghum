#!/bin/bash                                                                                                                                                                                                 
#SBATCH --nodes=1                                                                                                                                                                                           
#SBATCH --ntasks=1                                                                                                                                                                                          
#SBATCH --time=48:00:00                                                                                                                                                                                     
#SBATCH --cpus-per-task=1                                                                                                                                                                                   
#SBATCH --mem=120gb                                                                                                                                                                                         
#SBATCH --partition=Draco                                                                                                                                                                                   
#SBATCH --mail-type=end                                                                                                                                                                                     
#SBATCH --mail-user=kkrishn8@uncc.edu

perl insertion_annotation.pl BTx623.merged.INS.withMorethan80_TE_cov /projects/cooper_research/Ref_Genomes/BTx623/annotation/Sbicolor_454_v3.1.1.gene.gff3 
