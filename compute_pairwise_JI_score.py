###########################################
# This script computes the Jaccard index for all pairs of gene clusters
# based on the gene labels of the clusters.
# The input file should contain one gene cluster ID per line.
# The output is written to a file named 'pairwise_JI_score.tsv'.
# Example usage:
# python compute_pairwise_JI_score.py cgc_idlst.txt
###########################################

import re
import sys
from itertools import combinations, islice
from multiprocessing import Pool


def jaccard_index(set_a, set_b):
    intersect = len(set_a & set_b)
    union = len(set_a | set_b)
    score = intersect / union
    return intersect, union, score


def seq_tsv_dict(seq_tsv):
    dic = {}
    with open(seq_tsv) as f:
        for line in f:
            fields = line.strip().split('\t')
            pul_id = fields[0]
            seq_lst = [seq for seq in re.split(r'[,\|]', fields[1]) if seq != 'null']    # a list of domains in cluster without null
            #seq_lst = [seq for seq in fields[1].split(',') if seq != 'null']    # a list of proteins in cluster without null
            #seq_lst = set(fields[1].split(','))
            dic[pul_id] = seq_lst
    return dic


def process_pair_chunk(chunk, all_data_dict):
    results = []
    for a, b in chunk:
        set_a = set(all_data_dict[a])
        set_b = set(all_data_dict[b])
        intersect, union, score = jaccard_index(set_a, set_b)
        results.append(f"{a}\t{b}\t{intersect}\t{union}\t{score:.4f}")
    return results

def chunk_generator(iterable, size):
    """Yield successive chunks from an iterable, each of length 'size'."""
    it = iter(iterable)
    while True:
        chunk = list(islice(it, size))
        if not chunk:
            break
        yield chunk

def write_to_file_parallel(out_file, geneclstr_id_lst, all_data_dict, num_workers=32, chunk_size=1000000):
    pair_generator = combinations(geneclstr_id_lst, 2)
    with Pool(processes=num_workers) as pool, open(out_file, 'w') as out:
        out.write("geneclstr_a\tgeneclstr_b\tintersection\tunion\tJI\n")
        for chunk in chunk_generator(pair_generator, chunk_size):
            results = pool.starmap(process_pair_chunk, [(chunk, all_data_dict)])
            for result in results:
                for line in result:
                    out.write(line + '\n')


def write_to_file(out_file, geneclstr_id_lst, all_data_dict):
    with open(out_file, 'w') as out:
        out.write("geneclstr_a\tgeneclstr_b\tintersection\tunion\tJI\n")
        for a, b in combinations(geneclstr_id_lst, 2):
            set_a = set(all_data_dict[a])
            set_b = set(all_data_dict[b])
            intersect, union, score = jaccard_index(set_a, set_b)
            out.write(f"{a}\t{b}\t{intersect}\t{union}\t{score:.4f}\n")


def fast_serial_jaccard(geneclstr_id_lst, all_data_dict, out_file):
    sets = {k: set(v) for k, v in all_data_dict.items()}
    with open(out_file, 'w') as out:
        out.write("CGC_A\tCGC_B\tIntersection\tUnion\tJaccard\n")
        for a, b in combinations(geneclstr_id_lst, 2):
            sa, sb = sets[a], sets[b]
            inter = len(sa & sb)
            union = len(sa | sb)
            score = inter / union
            out.write(f"{a}\t{b}\t{inter}\t{union}\t{score:.3f}\n")


if __name__ == "__main__":
    id_lst_file = sys.argv[1]
    out_file = 'pairwise_JI_score.tsv'
    with open(id_lst_file) as f:
        geneclstr_id_lst = [line.strip() for line in f]

    labeled_data_dic = seq_tsv_dict('labeled_data_seq.tsv')
    unlabeled_data_dic = seq_tsv_dict('unlabeled_data_seq.tsv')
    # data_seq_tsv should be tab-separated file contains two columns: gene_cluster_id and comma-separated gene compositions, for example:
    # PUL0313  PL6|PL6_1,PL7_5,PL6|PL6_1
    # A103.bin_16_CGC10       1.A.35.3.2,GH5_2,CBM2

    all_data_dict = {**labeled_data_dic, **unlabeled_data_dic}
    
    #write_to_file(out_file, geneclstr_id_lst, all_data_dict)    # too slow for large data
    fast_serial_jaccard(geneclstr_id_lst, all_data_dict, out_file)
    #write_to_file_parallel(out_file, geneclstr_id_lst, all_data_dict, num_workers=32, chunk_size=1000000)

  
