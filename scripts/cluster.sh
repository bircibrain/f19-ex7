#!/bin/bash
export FSLTCLSH=/usr/local/fsl/bin/fsltclsh

# /data = /scratch/psyc5171/bso15101/f19-ex7/hw7/bids; contains sub-TD901, sub-TD902, sub-TD904
# /scripts = /scratch/psyc5171/bso15101/f19-ex7/scripts; contains the scripts like bids2fsl_events.py
# /input = /scratch/psyc5171/bso15101/f19-ex7/musictask; contains dicoms and events
# /output = /scratch/psyc5171/bso15101/f19-ex7/derivatives

cd /output/level2/cope1.feat

dlh=`smoothest -d 2 -m ../mask -r res4d | grep DLH | \
	awk '{print $2}'`

#	0.137421

volume=`smoothest -d 2 -m ../mask -r res4d | grep VOLUME | \
	awk '{print $2}'`

#	283531

cluster --dlh=${dlh} --volume=${volume} \
	-t 2.3 -p .05 \
	--mm --peakdist=10 \
	--othresh=thresh_zstat1_2.3 \
	--olmax=localmax_zstat1_2.3.txt \
	--oindex=index_zstat1_2.3 \
	-i zstat1.nii.gz > clusters_zstat1_2.3.txt


sed 1d clusters_zstat1_2.3.txt | awk '{print $6,$7,$8}' | \
	while read coord; do
		atlasq query mni -c $coord >> atlas-mni.txt
	done

sed 1d clusters_zstat1_2.3.txt | awk '{print $6,$7,$8}' | \
	while read coord; do
		atlasq query harvardoxford-cortical -c $coord >> atlas-harvardoxford-cortical.txt
	done

sed 1d clusters_zstat1_2.3.txt | awk '{print $6,$7,$8}' | \
	while read coord; do
		atlasq query harvardoxford-subcortical -c $coord >> atlas-harvardoxford-subcortical.txt
	done

sed 1d clusters_zstat1_2.3.txt | awk '{print $6,$7,$8}' | \
	while read coord; do
		atlasq query talairach -c $coord >> atlas-talairach.txt
	done

sed 1d clusters_zstat1_2.3.txt | awk '{print $6,$7,$8}' | \
	while read coord; do
		atlasq query cerebellum_mniflirt -c $coord >> atlas-cerebellum_mniflirt.txt
	done


overlay 1 1 $FSLDIR/data/standard/avg152T1_brain.nii.gz -a \
	thresh_zstat1_2.3 2.3 4 \
	rendered_zstat1_2.3

slicer -s 4 -u \
	rendered_zstat1_2.3 \
	-S 2 4096 axial.png



