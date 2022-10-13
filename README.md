# Host variations of distinct PromA plasmids with different nucleotide compositions
## heatmap
heatmap code used for analysis in Maho Tokuda, Masahiro Yuki, Moriya Ohkuma, Kazuhide Kimbara, Haruo Suzuki and Masaki Shintani. (2022) 
"Host variations of distinct PromA plasmids with different nucleotide compositions" 

### 41PromA.fasta
The plasmid sequence data used for heatmap.
### PromA_heatmap.txt
This script calulates the 3-mer compositions of double strand sequences and clusters based on eucliduan sequences.


## assemble_draft_genome
assemble_draft_genome codeused for analysis in Maho Tokuda, Masahiro Yuki, Moriya Ohkuma, Kazuhide Kimbara, Haruo Suzuki and Masaki Shintani. (2022) 
"Host variations of distinct PromA plasmids with different nucleotide compositions" 
### pbs.bactopia.sh
Raw reads of whole genomes of transconjugants sequenced by Hiseq were assenble by using Unicycler of bactopia.
### run_extract_chr_seq_multi.sh
After assmbled genomes, transferred plasmid genomes were removed for calculation.


## calculate_Mahalanobis_distance
calculate_Mahalanobis_distance code used for analysis in Maho Tokuda, Masahiro Yuki, Moriya Ohkuma, Kazuhide Kimbara, Haruo Suzuki and Masaki Shintani. (2022) 
"Host variations of distinct PromA plasmids with different nucleotide compositions"
### my_fna_rho_dist_.R
This script was used for calculation of Mahalanobis distance between plasmids and draft chromosome genomes.
### my_rho_mahalanobis.R
This script was used for calculation of Mahalanobis distance between plasmids and complete chromosome genomes.

