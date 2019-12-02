#!/bin/bash
export FSLTCLSH=/usr/local/fsl/bin/fsltclsh

# /data = /scratch/psyc5171/bso15101/f19-ex7/hw7/bids; contains sub-TD901, sub-TD902, sub-TD904
# /scripts = /scratch/psyc5171/bso15101/f19-ex7/scripts; contains the scripts like bids2fsl_events.py
# /input = /scratch/psyc5171/bso15101/f19-ex7/musictask; contains dicoms and events
# /output = /scratch/psyc5171/bso15101/f19-ex7/derivatives

cd /input/events

for d in `ls sub-*_ses-1_task-music_run-01_events.tsv`; do
	SUBSTRING=$(echo $d| cut -d'_' -f 1)
	SUBJECT=$(echo $SUBSTRING| cut -d'-' -f 2)
	echo $SUBJECT
	/scripts/run_feat_ex7.sh $SUBJECT 1
done