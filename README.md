# Host variations of distinct PromA plasmids with different nucleotide compositions
## heatmap
heatmap code used for analysis in Maho Tokuda, Masahiro Yuki, Moriya Ohkuma, Kazuhide Kimbara, Haruo Suzuki and Masaki Shintani. (2022) 
"Host variations of distinct PromA plasmids with different nucleotide compositions" 

### heatmap/41PromA.fasta
Nucleotide sequence data of PromA plasmids used for creating heatmap.
### heatmap/PromA_heatmap.txt
This script for calculating 3-mer compositions of double strand sequences  based on Euclidean distance.


## assemble_draft_genome
assemble_draft_genome codeused for analysis in Maho Tokuda, Masahiro Yuki, Moriya Ohkuma, Kazuhide Kimbara, Haruo Suzuki and Masaki Shintani. (2022) 
"Host variations of distinct PromA plasmids with different nucleotide compositions" 
### assemble_draft_genome/pbs.bactopia.sh
A code for assembling draft genomes of transconjugants (sequenced by Hiseq platform) by using Unicycler of [Bactopia](https://github.com/bactopia/bactopia).
### assemble_draft_genome/run_extract_chr_seq_multi.sh
Code for removing transferred PromA plasmid sequences by BLAST.


## calculate_Mahalanobis_distance
calculate_Mahalanobis_distance code used for analysis in Maho Tokuda, Masahiro Yuki, Moriya Ohkuma, Kazuhide Kimbara, Haruo Suzuki and Masaki Shintani. (2022) 
"Host variations of distinct PromA plasmids with different nucleotide compositions"
### calculate_Mahalanobis_distance/my_fna_rho_dist_.R
Code for calculation of Mahalanobis distance between plasmids and chromosomes (for draft genome sequences).
### calculate_Mahalanobis_distance/my_rho_mahalanobis.R
Code for calculation of Mahalanobis distance between plasmids and chromosomes (for complete genome sequences).


# Reference
* Van der Auwera GA, Król JE, Suzuki H, Foster B, Van Houdt R, Brown CJ, et al. [Plasmids captured in C. metallidurans CH34: defining the PromA family of broad-host-range plasmids.](http://dx.doi.org/10.1007/s10482-009-9316-9) Antonie Van Leeuwenhoek. 2009 Aug;96(2):193–204. 
* Schneiker S, Keller M, Dröge M, Lanka E, Pühler A, Selbitschka W. [The genetic organization and evolution of the broad host range mercury resistance plasmid pSB102 isolated from a microbial population residing in the rhizosphere of alfalfa.](http://dx.doi.org/10.1093/nar/29.24.5169) Nucleic Acids Res. 2001 Dec 15;29(24):5169–81.
* Tauch A, Schneiker S, Selbitschka W, Pühler A, van Overbeek LS, Smalla K, et al. [The complete nucleotide sequence and environmental distribution of the cryptic, conjugative, broad-host-range plasmid pIPO2 isolated from bacteria of the wheat rhizosphere.](http://dx.doi.org/10.1099/00221287-148-6-1637) Microbiology. 2002 Jun;148(Pt 6):1637–53. 
*  	Li X, Top EM, Wang Y, Brown CJ, Yao F, Yang S, et al. [The broad-host-range plasmid pSFA231 isolated from petroleum-contaminated sediment represents a new member of the PromA plasmid family.](http://dx.doi.org/10.3389/fmicb.2014.00777) Front Microbiol. 2014;5:777.
*  	Yanagiya K, Maejima Y, Nakata H, Tokuda M, Moriuchi R, Dohra H, et al. [Novel Self-Transmissible and Broad-Host-Range Plasmids Exogenously Captured From Anaerobic Granules or Cow Manure.](http://dx.doi.org/10.3389/fmicb.2018.02602) Front Microbiol. 2018 Nov 6;9:2602. 
*  	Hayakawa M, Tokuda M, Kaneko K, Nakamichi K, Yamamoto Y, Kamijo T, et al. [Hitherto-Unnoticed Self-Transmissible Plasmids Widely Distributed among Different Environments in Japan.](http://dx.doi.org/10.1128/aem.01114-22) Appl Environ Microbiol . 2022 Sep 22;88(18):e0111422. 
*  	Suzuki H, Yano H, Brown CJ, Top EM. [Predicting plasmid promiscuity based on genomic signature.]( http://dx.doi.org/10.1128/JB.00277-10
) J Bacteriol. 2010 Nov;192(22):6045–55. 


