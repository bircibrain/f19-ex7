#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-user=briana.oshiro@uconn.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=10:00:00    
#SBATCH -e error_fslanat.log    
#SBATCH -o output_fslanat.log
#SBATCH --job-name=fslanat
#SBATCH --partition=serial
##### END OF JOB DEFINITION  #####


module load singularity
unset LD_PRELOAD
singularity run \
--bind /scratch/psyc5171/$USER/f19-ex7/hw7/bids:/data \
--bind /scratch/psyc5171/$USER/f19-ex7/scripts:/scripts \
/scratch/psyc5171/containers/hcpbids_4.0.sif \
/scripts/fslanat.sh