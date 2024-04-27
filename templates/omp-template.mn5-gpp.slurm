#!/bin/bash
#
#SBATCH -A bsc32
#SBATCH --exclusive
#SBATCH --q gp_debug
#SBATCH --time=00:30:00
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 112

export SRUN_CPUS_PER_TASK=${SLURM_CPUS_PER_TASK}

srun ./your_binary
