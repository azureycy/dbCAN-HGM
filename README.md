<img src="https://github.com/azureycy/dbCAN-HGM/blob/main/dbcanHGM_logo.png" width=70% height=70%>

### dbCAN-HGM website: [https://pro.unl.edu/dbCAN_HGM/](https://pro.unl.edu/dbCAN_HGM/)
Database of CAZyme gene clusters (CGCs) in gut microbiomes from diverse human populations.

## Tools and databases
- [CheckM v1.2.3](https://github.com/Ecogenomics/CheckM): assess the quality of microbial genomes.
- [dRep v3.5.0](https://github.com/MrOlm/drep): rapid comparison and dereplication of genomes.
- [GTDB-Tk v2.4.0](https://github.com/Ecogenomics/GTDBTk): assign objective taxonomic classifications to bacterial and archaeal genomes.
- [run_dbcan v4](https://github.com/bcb-unl/run_dbcan): CAZyme and CAZyme gene cluster (CGC) annotation.
- [dbCAN-PUL](https://pro.unl.edu/dbCAN_PUL/dbCAN_PUL/): database of polysaccharide utilization loci (PULs).
- [Spacedust](https://github.com/soedinglab/spacedust): identify conserved gene clusters among multiple genomes based on homology search.
- [Bowtie2 v2.5.4](https://github.com/BenLangmead/bowtie2): fast and sensitive gapped read aligner.
- [SAMtools v1.20](https://github.com/samtools/samtools): parse and manipulate alignments in the SAM/BAM format.
- [BEDtools v2.31.1](https://github.com/arq5x/bedtools2): tools for a wide-range of genomics analysis tasks.
- [Foldseek v10](https://github.com/steineggerlab/foldseek): protein structure comparison.
- [ColabFold v1.5.3](https://github.com/sokrypton/ColabFold) for AlphaFold2 structure prediction.

## Database content processing
### Human MAG quality check and taxonomic classification
  - [mag_preprocessing.sh](https://github.com/azureycy/dbCAN-HGM/blob/main/mag_preprocessing.sh)
### CGC and PUL data generation and functional annotation
  - [run_dbcan.sh](https://github.com/azureycy/dbCAN-HGM/blob/main/run_dbcan.sh)

### CGC family generation
  - [compute_pairwise_JI_score.py](https://github.com/azureycy/dbCAN-HGM/blob/main/compute_pairwise_JI_score.py)
  - [mcl.sh](https://github.com/azureycy/dbCAN-HGM/blob/main/mcl.sh)

### Read mapping to profile CGC in different microbiome samples
  - [bowtie2_mapping.sh](https://github.com/azureycy/dbCAN-HGM/blob/main/bowtie2_mapping.sh)

### Structural prediction and homology search for null proteins in CGCs
  - [foldseek_run_htmls.sh](https://github.com/azureycy/dbCAN-HGM/blob/main/foldseek_run_htmls.sh)
  - [foldseek_run_tsv.sh](https://github.com/azureycy/dbCAN-HGM/blob/main/foldseek_run_tsv.sh)
  - [structure_prediction.sh](https://github.com/azureycy/dbCAN-HGM/blob/main/structure_prediction.sh)

