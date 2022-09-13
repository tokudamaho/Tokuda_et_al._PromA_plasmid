#!/bin/sh

### Parameter ###

DB=/home/shintani_masaki/idenshi/210907_analysis/db/pSN0729-62gfp.fna

FORMAT="6 qseqid sseqid pident length mismatch gapopen qlen qstart qend slen sstart send evalue bitscore stitle"
EVALUE=1.0e-06
MAX_TARGET=1
THREAD=8

### Command ###

# BLAST�ɂ��, pSN1104-11gfp.fna�Ƀq�b�g������̂��m�F, ID�𒊏o.
export BLASTDB=$BLASTDB:/home/database/blastdb/ncbi/taxdb/

cat sample_name_list.txt | while read SAMPLE_NAME; 
do 
  blastn \
  -task megablast \
  -query ${SAMPLE_NAME}.fna \
  -db ${DB} \
  -evalue ${EVALUE} \
  -max_target_seqs ${MAX_TARGET} \
  -num_threads ${THREAD}  \
  -outfmt "${FORMAT}" \
  -out ${SAMPLE_NAME}_`basename "${DB%.*}"`_fmt6.txt

  cat ${SAMPLE_NAME}_`basename "${DB%.*}"`_fmt6.txt |\
  awk '$1 != prev { print; prev = $1 }' \
  > ${SAMPLE_NAME}_`basename "${DB%.*}"`_uniq.txt

# pidentity, qcoverage, e-value����臒l��ݒ肵�ċ@�B�I�Ƀv���X�~�hid�݂̂𒊏o.
# �K�X, ���l��ύX���� ($3��pidentity, $4/$7��qcoverage, $13��e-value).
  awk '$3>=80 && $4/$7>=.5 && $13<1.0e-06' ${SAMPLE_NAME}_`basename "${DB%.*}"`_uniq.txt |\
  cut -f 1 \
  > ${SAMPLE_NAME}_plasmid_id.txt

# �Q�m���f�[�^�̑SID����, ���F��ID�݂̂𒊏o.
  samtools faidx ${SAMPLE_NAME}.fna
  cut -f 1 ${SAMPLE_NAME}.fna.fai \
  > ${SAMPLE_NAME}_genome_id.txt

  comm -13 ${SAMPLE_NAME}_plasmid_id.txt ${SAMPLE_NAME}_genome_id.txt \
  > ${SAMPLE_NAME}_chr_id.txt

# ���F�̔z����擾.
  seqtk subseq ${SAMPLE_NAME}.fna ${SAMPLE_NAME}_chr_id.txt \
  > ${SAMPLE_NAME}_chr.fna

# �v���X�~�h�z����擾.
  seqtk subseq ${SAMPLE_NAME}.fna ${SAMPLE_NAME}_plasmid_id.txt \
  > ${SAMPLE_NAME}_plasmid.fna

# �t�@�C���̈ړ�
  mkdir dir_${SAMPLE_NAME}
  mv ${SAMPLE_NAME}* dir_${SAMPLE_NAME}
done

mv nohup.out nohup.out_`date +%Y%m%d-%H:%M`.txt
