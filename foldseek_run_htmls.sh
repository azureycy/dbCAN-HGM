#!/bin/bash
# Foldseek similarity search of predicted structures against multiple databases
# Databases: AFDB, PDB, CAZyme3D_whole, CAZyme-ID50, SwissProt
# Parameters: E-value 1e-5, TM-score threshold 0.45, alignment-type 1, format-mode 3

INPUT_DIR=/array2/siva/dbcanseq_hgm/final_models/dbcanhgm_final_pdbs_renamed
OUTPUT_DIR=/array2/siva/dbcanseq_hgm/foldseek_results_dbcanhgm_indi_reduced_null
TMP_DIR=tmp

# Create output directory if not exists
mkdir -p $OUTPUT_DIR $TMP_DIR

# Loop through predicted PDBs
for pdb in $INPUT_DIR/*.pdb; do
    base=$(basename $pdb .pdb)

    # AFDB
    foldseek easy-search $pdb dbs/afdb $OUTPUT_DIR/${base}.afdb.html $TMP_DIR \
        -e 1e-5 --alignment-type 1 --format-mode 3 --tmscore-threshold 0.45

    # PDB
    foldseek easy-search $pdb dbs/pdb $OUTPUT_DIR/${base}.pdb.html $TMP_DIR \
        -e 1e-5 --alignment-type 1 --format-mode 3 --tmscore-threshold 0.45

    # CAZyme3D whole
    foldseek easy-search $pdb dbs/cazyme3d_whole $OUTPUT_DIR/${base}.cazyme3d_whole.html $TMP_DIR \
        -e 1e-5 --alignment-type 1 --format-mode 3 --tmscore-threshold 0.45

    # CAZyme-ID50
    foldseek easy-search $pdb dbs/cazymeid50 $OUTPUT_DIR/${base}.cazymeid50.html $TMP_DIR \
        -e 1e-5 --alignment-type 1 --format-mode 3 --tmscore-threshold 0.45

    # SwissProt
    foldseek easy-search $pdb dbs/swissprot $OUTPUT_DIR/${base}.swissprot.html $TMP_DIR \
        -e 1e-5 --alignment-type 1 --format-mode 3 --tmscore-threshold 0.45
done
