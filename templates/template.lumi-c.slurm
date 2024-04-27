#!/bin/bash

#SBATCH -J JobName
#SBATCH -p standard
#SBATCH --time 02:00:00
#SBATCH --output slurm_%x_%j.out
#SBATCH --error slurm_%x_%j.err
#SBATCH -N 1
#SBATCH -n 1
#SBATCH -c 128
#SBATCH --hint=nomultithread
#SBATCH --exclusive

#YOUR SCRIPT GOES HERE:
