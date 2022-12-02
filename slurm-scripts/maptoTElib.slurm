#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --time=48:00:00
#SBATCH --cpus-per-task=1
#SBATCH --mem=120gb
#SBATCH --partition=Draco
#SBATCH --mail-type=end
#SBATCH --mail-user=kkrishn8@uncc.edu

module load blast

perl getFASTA.pl
