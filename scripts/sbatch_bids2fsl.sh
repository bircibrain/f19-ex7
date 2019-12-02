#!/bin/bash
#SBATCH --mail-type=ALL
#SBATCH --mail-user=briana.oshiro@uconn.edu
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --mem=2gb
#SBATCH --time=1:00:00    
#SBATCH -e error_bids2fsl.log    
#SBATCH -o output_bids2fsl.log
#SBATCH --job-name=bids2fsl
#SBATCH --partition=serial
##### END OF JOB DEFINITION  #####


module load singularity
unset LD_PRELOAD
singularity run \
--bind /scratch/psyc5171/$USER/f19-ex7/hw7/bids:/data \
--bind /scratch/psyc5171/$USER/f19-ex7/scripts:/scripts \
--bind /scratch/psyc5171/bso15101/f19-ex7/musictask:/input \
--bind /scratch/psyc5171/bso15101/f19-ex7/derivatives:/output \
/scratch/psyc5171/containers/hcpbids_4.0.sif \
/scripts/bids2fsl.sh
