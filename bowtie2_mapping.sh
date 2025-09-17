#!/bin/sh

# build bowtie2 index
bowtie2-build $genome_fasta 6031mags_btindex/$genome --threads 32

# locate path of input and output
out_bam="bowtie_bam/${genome}_${srr}_${diet}.cgc.std.sorted.bam"
log_file="bowtie_log/${genome}_${srr}_${diet}.log"
bed_file="refgenome_cgc_bed/${genome}.cgc.std.bed"
# bed files containing CGC region information are tsv files with columns: gene_id, start, end and CGC_id

# run bowtie2 read mapping
bowtie2 --very-sensitive --local --no-mixed --no-discordant \
    -x 6031mags_btindex/$genome \
    -1 fastq_files/${srr}_1.fastq.gz \
    -2 fastq_files/${srr}_2.fastq.gz \
    --threads $SLURM_CPUS_PER_TASK 2> $log_file | \
  samtools view -bS - | \
  bedtools intersect -abam - -b $bed_file | \
  samtools sort -o $out_bam
