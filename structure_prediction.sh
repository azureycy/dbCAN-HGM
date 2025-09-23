#!/bin/bash
# ColabFold Prediction Script using Apptainer
# Version: ColabFold 1.5.3 with CUDA 11.8.0
# Input: FASTA file(s)
# Output: Predicted protein structures

# Run with Apptainer
apptainer exec --nv \
  -B $local/path/.cache:/cache \
  -B $(pwd):/work \
  docker://ghcr.io/sokrypton/colabfold:1.5.3-cuda11.8.0 \
  colabfold_batch /local/path/fasta_file.faa local/path/output/



#After the run, the top-ranked predicted structures (rank_001.pdb) were selected.