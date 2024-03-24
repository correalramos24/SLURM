#!/usr/bin/env bash

SCRIPT=
JOBNAME="JOB"
WORKDIR=
SUBMIT_OR_TEST="SUBMIT"
QUEUE=
NODES=
MPI_PER_NODE=4
OMP_PER_NODE=4
PERF_COUNTERS=""
CLEAN_RUN=false

# SLURM Argument parsing
source slurm_args.sh
parse_args_slurm "$@"
check_required_slurm

# Add job specific arg parsing

# Go to rundir && submit script
echo -n "Checking rundir.. "
if [[ -d $WORKDIR ]]; then
    if [ $CLEAN_RUN == true ]; then
        echo -n "Warning: Folder exists, removing the content... "
        rm -rf $WORKDIR/*
    else
        echo "Error: Folder $WORKDIR exists, provide another workdir or remove it"
        exit 1
    fi
fi
echo "Done"

mkdir -p $WORKDIR && cp $SCRIPT $WORKDIR && cd $WORKDIR

submit_and_trace
