#!/bin/bash
export FSLTCLSH=/usr/local/fsl/bin/fsltclsh

# Run fsl_anat on each T1w volume to prepare brain extracted T1 for use w/ FSL
# /data = /scratch/psyc5171/bso15101/f19-ex7/hw7/bids; contains sub-TD901, sub-TD902, sub-TD904

cd /data

for d in `ls -d sub-*`; do
	fsl_anat -i ${d}/anat/${d}_run-1_T1w.nii.gz -o ${d}/anat/output
done