#!/bin/sh

### Parameter ###

DB=/home/shintani_masaki/idenshi/210907_analysis/db/pSN0729-62gfp.fna

FORMAT="6 qseqid sseqid pident length mismatch gapopen qlen qstart qend slen sstart send evalue bitscore stitle"
EVALUE=1.0e-06
MAX_TARGET=1
THREAD=8

### Command ###

# BLASTにより, pSN1104-11gfp.fnaにヒットするものを確認, IDを抽出.
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

# pidentity, qcoverage, e-value等の閾値を設定して機械的にプラスミドidのみを抽出.
# 適宜, 数値を変更する ($3はpidentity, $4/$7はqcoverage, $13はe-value).
  awk '$3>=80 && $4/$7>=.5 && $13<1.0e-06' ${SAMPLE_NAME}_`basename "${DB%.*}"`_uniq.txt |\
  cut -f 1 \
  > ${SAMPLE_NAME}_plasmid_id.txt

# ゲノムデータの全IDから, 染色体IDのみを抽出.
  samtools faidx ${SAMPLE_NAME}.fna
  cut -f 1 ${SAMPLE_NAME}.fna.fai \
  > ${SAMPLE_NAME}_genome_id.txt

  comm -13 ${SAMPLE_NAME}_plasmid_id.txt ${SAMPLE_NAME}_genome_id.txt \
  > ${SAMPLE_NAME}_chr_id.txt

# 染色体配列を取得.
  seqtk subseq ${SAMPLE_NAME}.fna ${SAMPLE_NAME}_chr_id.txt \
  > ${SAMPLE_NAME}_chr.fna

# プラスミド配列を取得.
  seqtk subseq ${SAMPLE_NAME}.fna ${SAMPLE_NAME}_plasmid_id.txt \
  > ${SAMPLE_NAME}_plasmid.fna

# ファイルの移動
  mkdir dir_${SAMPLE_NAME}
  mv ${SAMPLE_NAME}* dir_${SAMPLE_NAME}
done

mv nohup.out nohup.out_`date +%Y%m%d-%H:%M`.txt
