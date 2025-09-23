#!/bin/bash
# Foldseek bulk similarity search of predicted structures
# Databases: CAZyme-ID50, AFDB, PDB, SwissProt, CAZyme3D_whole
# Parameters: E-value 1e-5, TM-score threshold 0.45, 20 threads
# Output: TSV files with alignment statistics

INPUT_DIR=final_models/dbcanhgm_final_pdbs
TMP_DIR=tmp
THREADS=20

# Create tmp directory if not exists
mkdir -p $TMP_DIR

# Define output format
FORMAT="query,target,fident,alnlen,mismatch,gapopen,qstart,qend,tstart,tend,evalue,bits,alntmscore,qtmscore,ttmscore"

# Run searches
foldseek easy-search $INPUT_DIR dbs/cazymeid50      dbcanhgm_cazyme_id50_reduced.tsv   $TMP_DIR -e 1e-5 --alignment-type 1 --format-output "$FORMAT" --tmscore-threshold 0.45 --threads $THREADS
foldseek easy-search $INPUT_DIR dbs/afdb           dbcanhgm_afdb_reduced.tsv          $TMP_DIR -e 1e-5 --alignment-type 1 --format-output "$FORMAT" --tmscore-threshold 0.45 --threads $THREADS
foldseek easy-search $INPUT_DIR dbs/pdb            dbcanhgm_pdb_reduced.tsv           $TMP_DIR -e 1e-5 --alignment-type 1 --format-output "$FORMAT" --tmscore-threshold 0.45 --threads $THREADS
foldseek easy-search $INPUT_DIR dbs/swissprot      dbcanhgm_swissprot_reduced.tsv     $TMP_DIR -e 1e-5 --alignment-type 1 --format-output "$FORMAT" --tmscore-threshold 0.45 --threads $THREADS
foldseek easy-search $INPUT_DIR dbs/cazyme3d_whole dbcanhgm_cazyme3d_whole_reduced.tsv $TMP_DIR -e 1e-5 --alignment-type 1 --format-output "$FORMAT" --tmscore-threshold 0.45 --threads $THREADS