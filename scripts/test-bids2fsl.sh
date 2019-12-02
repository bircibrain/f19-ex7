#!/bin/bash
# export FSLTCLSH=/usr/local/fsl/bin/fsltclsh

# Run fsl_anat on each T1w volume to prepare brain extracted T1 for use w/ FSL
# /data = /scratch/psyc5171/bso15101/f19-ex7/hw7/bids; contains sub-TD901, sub-TD902, sub-TD904
# /scripts = /scratch/psyc5171/bso15101/f19-ex7/scripts; contains the scripts like bids2fsl_events.py
# /input = /scratch/psyc5171/bso15101/f19-ex7/musictask; contains dicoms and events
# /output = /scratch/psyc5171/bso15101/f19-ex7/derivatives

# /Users/brianaoshiro/f19-ex7-working/musictask/events = /input/events
# /Users/brianaoshiro/f19-ex7-working/derivatives = /output

cd /input/events

for d in `ls sub-*_ses-1_task-music_run-01_events.tsv`; do
	PART1=(${d//-/ })
	echo ${PART1[0]}-${PART1[1]}-${PART1[2]}-${PART1[3]}
	/scripts/bids2fsl_events.py \
		${d} \
		/output/timing/${PART1[0]}-${PART1[1]}-${PART1[2]}-${PART1[3]}-event \
		--tr 1.07 --nvol 6
done

for d in `ls sub-*_ses-1_task-prosody_run-01_events.tsv`; do
	PART2=(${d//-/ })
	echo ${PART2[0]}-${PART2[1]}-${PART2[2]}-${PART2[3]}	
	/scripts/bids2fsl_events.py \
		${d} \
		/output/timing/${PART2[0]}-${PART2[1]}-${PART2[2]}-${PART2[3]}-event \
		--tr 1.07 --nvol 6
done

