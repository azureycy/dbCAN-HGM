#!/bin/bash

# run checkm for MAG quality check
checkm lineage_wf -t 32 -x fa ${mags_fna_dir} ${checkm_out}
checkm qa ${checkm_out}/lineage.ms ${checkm_out} -o 2 --tab_table -f checkm_quality.tsv

# run gtdbtk to assign taxonomic classification
gtdbtk classify_wf --genome_dir ${mags_fna_dir} --out_dir ${gtdbtk_out} --cpus 6 --mash_db mash_db.msh

# remove highly similar seqs with 99.9% ANI
dRep dereplicate drep_out_0.999 -g mags_path_for_drep.txt -p 32 -comp 90 -con 5 -pa 0.9 -sa 0.999 --S_algorithm skani --multiround_primary_clustering --genomeInfo genome_quality_infor.csv --primary_chunksize 10000

# select spp-level representatives with 95% ANI
dRep dereplicate drep_out_0.95 -g mags_path_for_drep_999to95.txt -p 32 -comp 90 -con 5 -pa 0.9 -sa 0.95 -nc 0.3 --S_algorithm skani --multiround_primary_clustering --primary_chunksize 10000 --genomeInfo genome_quality_infor_for_drep_999to95.csv
