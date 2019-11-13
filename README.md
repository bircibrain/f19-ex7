# Homework 7

Complete a first level and group fixed effect analysis on the data in `/scratch/psyc5171/exercises/musictask`.

You are provided with raw DICOM files and will need to complete the following steps:

- BIDS conversion see (02-bidscoiner)
- Run `fsl_anat` on each T1w volume to prepare the brain extracted T1 for use with FSL (06-FSLGroup)
- Run first level preprocessing and GLM (05-fsl_intro). Use the nonlinear registration option for aligning the T1 to MNI space. You should setup a GLM to test to contrast of beat minus melody.

## BIDS conversion details

You have been provided data for 3 subjects, each of which includes DICOMS for:

- A localizer scan for positioning subsequent scans (`AAHead Scout`). These do not need to be converted.
- A T1w MPRAGE
- Multiband fMRI runs of *music* and *prosody* tasks and the corresponding single band reference (sbref) volumes. There is one run of each task with 287 volumes for music and 336 volumes for prosody, but you may find that some subjects have one or more partial runs. The partial runs should not be analyzed
- A physiological recording log for each fMRI run. This should be ignored.

You are also provided with the events for each complete run in BIDS format.

## Analysis details

The *music* task is a block design that is designed to compare **melody** and **beat** discrimination tasks. Your challenge is to estimate a second level fixed effects analysis that tests for a beat > melody effect. You should remove the first 6 volumes and adjust the onset times accordingly. For the first level analysis, use fairly standard choices:

- 90 sec high pass filter
- slice timing correction
- motion correction
- 5mm smoothing
- Nonlinear alignment to MNI space
- include 6 motion parameters as confound regressors

Threshold the group analysis using cluster correction at $Z>2.3$, $P<.05$

## Submission

Your submission should include:

- Your `bidsmap.json` file
- Your `sbatch` script(s)
- Your shell script(s) to run the analysis
- A table of significant clusters from the group analysis

