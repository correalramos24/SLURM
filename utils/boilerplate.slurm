#!/bin/bash

#SBATCH --exclusive
#SBATCH --output slurm_%x_%j.out
#SBATCH --error slurm_%x_%j.err
#SBATCH --chdir=/your/job/workdir

#Parse args, Expect:
#1. THREADS PER TASK (OPENMP THREADS)
#2. NUM TASKS (MPI ranks)
#3. WORKING DIR

echo "Launching slurm template for MN4 ..."
echo "Starting at $(date)"

NUM_ARGS=3

if [ "$#" -ne $NUM_ARGS ]; then
    echo "Bad arguments count, exit"
    echo "Expected $NUM_ARGS : threads_per_task mpi_ranks working_dir"
    for i in $*; do
        echo $i
        echo "\n"
    done
    exit 1
fi

MPI_JOBS=$2
OMP_THR=$1
WORKDIR=$3

# USe the local SDD, pointed by $TMPDIR
# mkdir $TMPDIR/$USER
# cd $TMPDIR/$USER
# cp -r /USEFULL/DATA $WORKDIR
# Remember to copy back into your gfps dir's

#Set OMP variable:
export OMP_NUM_THREADS=$OMP_THR

#load modules:
module load EXTRAE

#go to working directory
cd $WORKDIR

#launch binary
mpirun -np $MPI_JOBS echo $HOST

# cp -r /YOUR/RESULTS $WORKDIR

echo "End of the batch $(date)"
