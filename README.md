# Host variations of distinct PromA plasmids with different nucleotide compositions
## heatmap
heatmap code used for analysis in Maho Tokuda, Masahiro Yuki, Moriya Ohkuma, Kazuhide Kimbara, Haruo Suzuki and Masaki Shintani. (2022) 
"Host variations of distinct PromA plasmids with different nucleotide compositions" 

### heatmap/41PromA.fasta
Nucleotide sequence data of PromA plasmids used for creating heatmap.
### PromA_heatmap.txt
This script for calculating 3-mer compositions of double strand sequences  based on Euclidean distance.


## assemble_draft_genome
assemble_draft_genome codeused for analysis in Maho Tokuda, Masahiro Yuki, Moriya Ohkuma, Kazuhide Kimbara, Haruo Suzuki and Masaki Shintani. (2022) 
"Host variations of distinct PromA plasmids with different nucleotide compositions" 
### assemble_draft_genome/pbs.bactopia.sh
A code for assembling draft genomes of transconjugants (sequenced by Hiseq platform) by using Unicycler of Bactopia.
### assemble_draft_genome/run_extract_chr_seq_multi.sh
Code for removing transferred PromA plasmid sequences.


## calculate_Mahalanobis_distance
calculate_Mahalanobis_distance code used for analysis in Maho Tokuda, Masahiro Yuki, Moriya Ohkuma, Kazuhide Kimbara, Haruo Suzuki and Masaki Shintani. (2022) 
"Host variations of distinct PromA plasmids with different nucleotide compositions"
### calculate_Mahalanobis_distance/my_fna_rho_dist_.R
Code for calculation of Mahalanobis distance between plasmids and chromosomes (for draft genome sequences).
### calculate_Mahalanobis_distance/my_rho_mahalanobis.R
Code for calculation of Mahalanobis distance between plasmids and chromosomes (for complete genome sequences).
