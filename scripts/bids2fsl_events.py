#!/usr/bin/env python
#convert bids event files to FSL form
import pandas as pd
import numpy as np
import argparse

argparser = argparse.ArgumentParser(description="Convert BIDS tsv event files to FSL form")
argparser.add_argument("infile", help="Input BIDS tsv file")
argparser.add_argument("prefix", help="Prefix for the output timing files")
arggroup = argparser.add_argument_group(title='timing adjustments', description='Offset times by TR*nvol')
arggroup.add_argument("--tr", default=1.0, type=float, help='TR in seconds')
arggroup.add_argument("--nvol", default=0, type=int, help='Number of volumes to discard')
args = argparser.parse_args()

offset = args.tr * args.nvol
trials = pd.read_csv(args.infile, sep='\t')
trials['onset'] = trials['onset'] - offset
groups = trials.groupby('trial_type')
for g in groups:
    fsl_onsets = groups.get_group(g[0])
    fsl_onsets = fsl_onsets[['onset', 'duration']]
    fsl_onsets['one'] = 1
    fsl_onsets.to_csv(args.prefix + '_' + g[0] + '.tsv', sep='\t', index=False, header=False, doublequote=False)
