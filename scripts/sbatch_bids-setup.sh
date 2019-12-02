#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-user=briana.oshiro@uconn.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=00:10:00    
#SBATCH -e error_bids-setup.log    
#SBATCH -o output_bids-setup.log
#SBATCH --job-name=bids-setup
#SBATCH --partition=serial
##### END OF JOB DEFINITION  #####

module load singularity
singularity run \
--bind /scratch/psyc5171/$USER/f19-ex7/hw7:/data \
/scratch/psyc5171/containers/birc-bids_latest.sif \
bidstrainer.py /data/bids
