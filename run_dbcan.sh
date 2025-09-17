#!/bin/bash


run_dbcan 6031mags_seqs/${genome_id}.faa protein -c 6031mags_seqs/{$genome_id}.gff --cgc_sig_genes tp --out_dir dbcan_out/${genome_id} --dbcan_thread 8
