#!/bin/bash                                                                                                                                                                                
#SBATCH --nodes=1                                                                                                                                                                          
#SBATCH --ntasks=6                                                                                                                                                                         
#SBATCH --time=48:00:00                                                                                                                                                                    
#SBATCH --cpus-per-task=1                                                                                                                                                                  
#SBATCH --mem=120gb                                                                                                                                                                        
#SBATCH --partition=Draco                                                                                                                                                                  
#SBATCH --mail-type=end                                                                                                                                                            
#SBATCH --mail-user=kkrishn8@uncc.edu

perl ~/ITIPs/TE_insertions_genotype.pl -Fasta BTx623.referenceTEinsertions_and_flanking1kb.fasta  -leftRead /projects/cooper_research1/Wild_Sorghum_WGS/pi329250_1.fastq -rightRead /projects/cooper_research1/Wild_Sorghum_WGS/pi329250_2.fastq -samId pi329250 -output pi329250.referenceTEinsertion -script ~/ITIPs/scripts -threads 6 
