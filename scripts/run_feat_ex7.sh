#!/bin/bash
export FSLTCLSH=/usr/local/fsl/bin/fsltclsh

# /data = /scratch/psyc5171/bso15101/f19-ex7/hw7/bids; contains sub-TD901, sub-TD902, sub-TD904
# /scripts = /scratch/psyc5171/bso15101/f19-ex7/scripts; contains the scripts like bids2fsl_events.py
# /input = /scratch/psyc5171/bso15101/f19-ex7/musictask; contains dicoms and events
# /output = /scratch/psyc5171/bso15101/f19-ex7/derivatives

subject=$1
session=$2

cd /scripts

cat /scripts/task-music_template.fsf | \
sed -e "s/SUBJECT/${subject}/g" -e "s/SESSION/${session}/g" > \
/scripts/designs/sub-${subject}_ses-${session}_task-music.fsf

feat designs/sub-${subject}_ses-${session}_task-music.fsf
