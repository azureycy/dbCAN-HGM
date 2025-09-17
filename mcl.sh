#!/bin/sh
# Clustering the CGCs using the Markov Cluster (MCL) algorithm
# Example usage: bash mcl.sh pairwise_JI_score.morethan0.5.tsv 2

# Set inflation value of 2 (control cluster granularity)
I_value=$(echo $2 | awk '{printf "%d", $1 * 10}')

# load input data to mcl format
mcxload -abc $1 -o ${1}.mci --stream-mirror -write-tab ${1}.tab

# mcl clustering
mcl ${1}.mci -I $2 -te 36

# output cluster results
mcxdump -icl out.${1}.mci.I$I_value -tabr ${1}.tab -o dump.${1}.mci.I$I_value

# output cluster results in table format
mcxdump -imx out.${1}.mci.I$I_value -tabr ${1}.tab -o dump.${1}.mci.I$I_value.cluster.tsv

# output cluster results in sif format
mcxdump -imx out.${1}.mci.I$I_value -tabr ${1}.tab -dump-sif related -o dump.${1}.mci.I$I_value.cluster.sif

# output cluster results in matrix format
mcxdump -imx out.${1}.mci.I$I_value -tabr ${1}.tab --dump-table -o dump.${1}.mci.I$I_value.cluster.mat
