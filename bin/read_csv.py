#!/usr/bin/env python3

import csv
import os
import sys

fields=('SN', 'char', 'freq', 'cdf', 'pinyin', 'trans')
MAX = 2500
BATCH = 20
START = 148 # ignore the first 3 pages, 126 chars
debug = False

def main(file, batch_num):
    count = 0
    bn = int(batch_num)

    list = []
    with open(file, "r") as csvf:
        rows = csv.DictReader(csvf, fields, delimiter='\t')
        for row in rows:
            if row['SN'][0] == '#':
                continue
            if count >= MAX:
                break
            if count > START and count <= START + bn * BATCH:
                if debug:
                    print("[DEBUG]", row['SN'], row['char'], row['freq'], row['cdf'], row['pinyin'])
                list.append(row['char'])
            count+=1
    
    print(" ".join(list))

def usage():
    print("Usage: {} <csv filenane> <batch_num> [debug]".format(sys.argv[0]))
    print(" e.g.: {} data/cn_char_by_freq.tsv 1".format(sys.argv[0]))
    sys.exit(1)

if __name__ == '__main__':
    if len(sys.argv) == 1:
        usage()
    
    if len(sys.argv) == 4:
        debug = True

    main(sys.argv[1], sys.argv[2])