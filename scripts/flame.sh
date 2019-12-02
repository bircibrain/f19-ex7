#!/bin/bash
export FSLTCLSH=/usr/local/fsl/bin/fsltclsh

# /data = /scratch/psyc5171/bso15101/f19-ex7/hw7/bids; contains sub-TD901, sub-TD902, sub-TD904
# /scripts = /scratch/psyc5171/bso15101/f19-ex7/scripts; contains the scripts like bids2fsl_events.py
# /input = /scratch/psyc5171/bso15101/f19-ex7/musictask; contains dicoms and events
# /output = /scratch/psyc5171/bso15101/f19-ex7/derivatives

# Requirements from level 1:
#	COPE files
#	varcope files
#	dof
#	mask

# Change this to reflect the input/output subdirectories
cd /output

# 1. Created directory for level2 manually:
#	/scratch/psyc5171/bso15101/f19-ex7/derivative/level2

# 2. Register first level analysis to standard space
#	use featregapply

for d in `ls -d level1/sub-*.feat`; do
	featregapply $d
done	

# 3. Merge COPEs to a 4D file
#	use fslmerge
#	(3 contrasts, 1, 2, and 3, so the for loop is over each contrast; i = contrast)
# 	1 contrast so changed to not have for loop.


fslmerge -t level2/cope1 \
	level1/sub-*.feat/reg_standard/stats/cope1.nii.gz



# 4. Mask of subject-level masks
#	use fslmerge
#	use fslmaths

fslmerge -t level2/mask \
	level1/sub-*.feat/reg_standard/mask.nii.gz	

fslmaths level2/mask -Tmin \
	level2/mask


# 5. Merge varcopes
#	use fslmerge


fslmerge -t level2/varcope1 \
	level1/sub-*.feat/reg_standard/stats/varcope1.nii.gz


# 6. Create 4D dof file
#	Zero the 4D cope file, add the dof value, and mask:
dof=$(cat level1/sub-TD901_task-music+.feat/stats/dof)
cd level2
fslmaths cope1 -mul 0 -add $dof -mul mask dof


# 7. Create design files
#	Design matrix
#	Contrast matrix
#	Group matrix
#	Convert to vest files

# create design/group matrix while removing previous one

rm design.txt
rm group.txt
for d in `ls -d ../level1/sub-*.feat`; do
	echo '1' >> design.txt
	echo '1' >> group.txt
done

# create contrast matrix while removing prevoius one (this line is not the same as in the cluster, it's more efficient)

echo '1' > contrast.txt

# Convert to vest files:

for f in *.txt; do
	Text2Vest $f ${f%.txt}.mat
done

# 8. Run analysis


flameo --cope=cope1 \
	--vc=varcope1 \
	--dvc=dof \
	--mask=mask \
	--ld=cope1.feat \
	--dm=design.mat \
	--cs=group.mat \
	--tc=contrast.mat \
	--runmode=flame1	







