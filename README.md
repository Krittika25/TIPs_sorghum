# TIP (Transposable-element Insertion site Polymorphism) identification in sorghum
This pipeline was adapted from the one presented by Xu Cai et al. in their paper 'Transposable element insertion: a hidden major source of domesticated phenotypic variation in *Brassica rapa*'. 
Most of the scripts were used without major alterations but the ones that were modified are available here. 

###Step 1: Identification of insertions and deletions in the 11 sorghum genotypes (NAM lines)
This step involved running the smartie-sv pipeline.
The input were 11 sorghum genomes from the NAM panel being compared against a single reference BTx623 genome.
The output were BED files that also contained the insertion/deletion segments (with respect to the reference BTx623).
Unlike in the paper being referred to, only a single reference genome was used to run this pipeline.

Local installation of Blasr and smartie-sv was required for running the program successfully on the UNC Charlotte HPC cluster.

###Step 2: Construction of the TE insertion dataset
The insertions and deletions were mapped on the TE library.
To create the TE library, first EDTA was run on all the genomes followed by clustering by CD-HIT to create a non-redundant TE library.
CD-HIT parameters: 

The insertions and deletions were merged to create BTx623.merged.DEL and BTx623.merged.INS (corresponding .fa files were also created).
BLAST (blastn) was run using the TE library as the database and the merged files as the query. This created files with extension .withMorethan80_TE_cov.The output in these files in based on the insertion/deletion having 80% similarity and 80% coverage.

Next step was to annotate the insertions and deletions using the reference gff3 file, which created two .anno files. 

With the annotation files,the reference genome was used to identify the flanking sequence around the TEs.
This was followed by using the BTx623 reference genome to identify the flanking+reference based TE insertions and flanking+non-reference based TE insertions

###Step3: Determining TIPs at the population level
Using the output files in the last stage of Step 2, bwa mem was used to map the wild sorghum genotypes to the TE insertions. 
