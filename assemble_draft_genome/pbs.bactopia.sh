#!/usr/bin/bash
#PBS -q blast
#PBS -l mem=188GB
#PBS -N pbs.bactopia.sh
set -e
#set -u
set -o pipefail
#set -euo pipefail

cd ${PBS_O_WORKDIR}

# start
echo; echo "[$(date)] $0 job has been started."

# [cp-support:25836] 
source /home/tmaho/anaconda3/etc/profile.d/conda.sh
conda activate base
# https://bactopia.github.io/quick-start/
conda activate bactopia
# https://bactopia.github.io/tutorial/



# 2021-08-18
# /home/tmaho/datasets
#複数のときはtxtファイルに書く
bactopia --fastqs fastas.txt
datasets=/home/tmaho/datasets
nohup bactopia --fastqs my_samples.txt --datasets "${datasets}" --cpus $(getconf _NPROCESSORS_ONLN) --outdir local-multiple-samples-paired-end &
#bactopia --fastqs fastqs.txt --datasets "${datasets}" --cpus $(getconf _NPROCESSORS_ONLN) --outdir local-multiple-samples-paired-end-unicycler --assembler unicycler



# Done
echo; echo "[$(date)] $0 has been successfully completed."

: <<'#__COMMENT_OUT__'
https://www.nibb.ac.jp/cproom/wiki3

queue
#PBS -q small
#PBS -q medium
#PBS -q large
#PBS -l mem=96G

#PBS -q blast
#PBS -l mem=188GB

#PBS -q smps
#PBS -l mem=500G

#PBS -q smpm
#PBS -l mem=1TB

#PBS -q smpl
#PBS -l mem=3TB


https://github.com/SionBayliss/PIRATE

https://www.ncbi.nlm.nih.gov/pmc/articles/PMC6785682/
A default MCL inflation value of 2 was identified as appropriate for intra-species clustering by the present study and previous authors [2]. A larger inflation value may be appropriate for inter-species comparisons and can be modified as appropriate.

https://github.com/haruosuz/mgsa/blob/master/references/mgsa.tools.md#bactopia

https://bactopia.github.io/bactopia-tools/pirate/

https://bactopia.github.io/bactopia-tools/pirate/#usage
    --para_off                  Switch off paralog identification

    --evalue STR                E-value used for BLAST hit filtering
                                    Default: 1E-6

#qsub pbs.bactopia.sh
qstat -u $(whoami)

# 2021-04-01
# https://bactopia.github.io/tutorial/#build-datasets
bactopia datasets --ariba "vfdb_core,card" --species "Staphylococcus aureus" --include_genus --cpus $(getconf _NPROCESSORS_ONLN)
# https://bactopia.github.io/tutorial/#acquire-staphopia-datasets
git clone -b staphopia-v1 https://github.com/bactopia/bactopia-datasets.git
cp -r bactopia-datasets/species-specific/ datasets/
rm -rf bactopia-datasets/
# https://bactopia.github.io/tutorial/#running-bactopia
# https://bactopia.github.io/tutorial/#samples-on-sra
# https://bactopia.github.io/tutorial/#single-sample
bactopia --accession SRX4563634 --datasets datasets/ --species "Staphylococcus aureus" --coverage 100 --genome_size median --cpus $(getconf _NPROCESSORS_ONLN) --outdir ena-single-sample


# 2021-04-01
# https://bactopia.github.io/tutorial/#running-bactopia
# https://bactopia.github.io/tutorial/#local-samples
# https://bactopia.github.io/tutorial/#single-sample_1

# https://github.com/bactopia/bactopia/issues/198
datasets=/home/haruo/tools/my_bactopia/2021-04-01/bactopia-tutorial/datasets
sample=$(find local-single-sample/ -name "*.fastq.gz" | xargs basename -s _R1.fastq.gz | xargs basename -s _R2.fastq.gz | sort -u)
fastqs=local-single-sample/SRX4563634/quality-control

bactopia --R1 ${fastqs}/${sample}_R1.fastq.gz \
         --R2 ${fastqs}/${sample}_R2.fastq.gz \
         --sample ${sample} \
         --datasets "${datasets}" \
         --assembler unicycler \
         --outdir local-single-sample-paired-end_unicycler \
         --cpus $(getconf _NPROCESSORS_ONLN)


# 2021-04-01
# https://bactopia.github.io/tutorial/#running-bactopia
# https://bactopia.github.io/tutorial/#local-samples
# https://bactopia.github.io/tutorial/#single-sample_1
datasets=/home/haruo/tools/my_bactopia/2021-04-01/datasets
sample=$(find sra-single-sample/ -name "*.fastq.gz" | xargs basename -s _R1.fastq.gz | xargs basename -s _R2.fastq.gz | sort -u)
fastqs=sra-single-sample/SRX160386/quality-control

bactopia --R1 ${fastqs}/${sample}_R1.fastq.gz \
         --R2 ${fastqs}/${sample}_R2.fastq.gz \
         --sample ${sample} \
         --datasets "${datasets}" \
         --assembler unicycler \
         --outdir local-single-sample-paired-end-unicycler \
         --cpus $(getconf _NPROCESSORS_ONLN)







assembly=./data/fna/
assembly=/home/haruo/projects/plasmids/rep_type/trfA/2021-01-05/taxa039/my_rho_pls_chr/data/fna.IncP1_chromosome

# pirate_steps_10-98
bactopia tools pirate --only_completed --assembly "${assembly}" --assembly_pattern *.fna --outdir ./ --cpus $(getconf _NPROCESSORS_ONLN) --steps "10,20,30,40,50,60,70,80,90,95,98" --cd_low 98 --evalue 1E-6 --hsp_len 0 --mcl_inflation 2 --use_diamond --skip_clonalframe

# pirate_steps_50-98
bactopia tools pirate --only_completed --assembly "${assembly}" --assembly_pattern *.fna --outdir ./ --cpus $(getconf _NPROCESSORS_ONLN) --steps "50,60,70,80,90,95,98" --cd_low 98 --evalue 1E-6 --hsp_len 0 --mcl_inflation 2 --use_diamond --skip_clonalframe

# pirate_steps_50-98_para_off
#bactopia tools pirate --only_completed --assembly "${assembly}" --assembly_pattern *.fna --outdir ./ --cpus $(getconf _NPROCESSORS_ONLN) --steps "50,60,70,80,90,95,98" --para_off --cd_low 98 --evalue 1E-6 --hsp_len 0 --mcl_inflation 2 --use_diamond --skip_clonalframe

# pirate_steps_10-98_para_off
#bactopia tools pirate --only_completed --assembly "${assembly}" --assembly_pattern *.fna --outdir ./ --cpus $(getconf _NPROCESSORS_ONLN) --steps "10,20,30,40,50,60,70,80,90,95,98" --para_off --cd_low 98 --evalue 1E-6 --hsp_len 0 --mcl_inflation 2 --use_diamond --skip_clonalframe

#bactopia tools pirate --only_completed --assembly ./data/fna/ --assembly_pattern *.fna --outdir ./ --cpus $(getconf _NPROCESSORS_ONLN) --steps "0,10,20,30,40,50,60,70,80,90,95,98" --cd_low 98 --evalue 1E-6 --hsp_len 0.5 --mcl_inflation 2 --skip_clonalframe

#bactopia tools pirate --only_completed --assembly ./data/fna/ --assembly_pattern *.fna --outdir ./ --cpus $(getconf _NPROCESSORS_ONLN) --steps "0,10,20,30,40,50,60,70,80,90,95,98" --cd_low 98 --evalue 1E-6 --hsp_len 0.5 --mcl_inflation 6 --skip_clonalframe

#bactopia tools pirate --only_completed --assembly ./data/fna/ --assembly_pattern *.fna --outdir ./ --cpus $(getconf _NPROCESSORS_ONLN) --steps "0,10,20,30,40,50,60,70,80,90,95,98" --cd_low 100 --evalue 1E-5 --hsp_len 0.5 --mcl_inflation 2 --skip_clonalframe

#bactopia tools pirate --only_completed --assembly ./data/fna/ --assembly_pattern *.fna --outdir ./ --cpus $(getconf _NPROCESSORS_ONLN) --steps "0,10,20,30,40,50,60,70,80,90,95,98" --cd_low 100 --evalue 1E-6 --hsp_len 0.5 --mcl_inflation 1.5 --skip_clonalframe

# --para_off --use_diamond

#bactopia tools pirate --only_completed --assembly ./data/fna/ --assembly_pattern *.fna --outdir ./ --cpus $(getconf _NPROCESSORS_ONLN) --steps 20,30,40,50,60,70,80,90,95 --para_off --use_diamond --skip_clonalframe

#bactopia tools pirate --only_completed --assembly ./data/fna/ --assembly_pattern *.fna --outdir ./ --cpus $(getconf _NPROCESSORS_ONLN) --steps 20,30,40,50,60,70,80,90,95 --skip_clonalframe


#__COMMENT_OUT__
