#!/bin/bash                                                                                                                                                                                         
#SBATCH --nodes=1                                                                                                                                                                                    
#SBATCH --ntasks=1                                                                                                                                                                                   
#SBATCH --time=48:00:00                                                                                                                                                                              
#SBATCH --cpus-per-task=1                                                                                                                                                                            
#SBATCH --mem=120gb                                                                                                                                                                                  
#SBATCH --partition=Draco                                                                                                                                                                            
#SBATCH --mail-type=end                                                                                                                                                                              
#SBATCH --mail-user=kkrishn8@uncc.edu

#Reference TE insertions
perl /users/kkrishn8/ITIPs/scripts/get_referenceTEinsertions_and_flanking_Seqs.pl /projects/cooper_research/Ref_Genomes/BTx623/Sbicolor_chr1_10.fa  BTx623.merged.DEL.withMorethan80_TE_cov.anno BTx623

#Nonreference TE insertions
perl /users/kkrishn8/ITIPs/scripts/get_nonReferenceTEinsertions_and_flanking_Seqs.pl /projects/cooper_research/Ref_Genomes/BTx623/Sbicolor_chr1_10.fa BTx623.merged.INS.withMorethan80_TE_cov.anno  BTx623.merged.INS.withMorethan80_TE_cov BTx623
