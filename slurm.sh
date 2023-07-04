#!/bin/bash

#DEFAULT VALUES:
BATCH_FILE=""
JOB_NAME=JOB
NUM_TASKS=1
THREADS_PER_TASK=1
QUEUE=debug
PAPI=""
WORKDIR=$PWD

#PARSE ARGS:
POSITIONAL_ARGS=()

while [[ $# -gt 0 ]]; do
  case $1 in
    -b|--batch)
      BATCH_FILE="$2"
      echo "set $BATCH_FILE"
      shift
      shift
      ;;
    -j|--job_name)
      JOB_NAME="$2"
      shift # past argument
      shift # past value
      ;;
    -m|--mpi)
      NUM_TASKS="$2"
      shift # past argument
      shift # past value
      ;;
    -t|--threads)
      THREADS_PER_TASK="$2"
      shift # past argument
      shift # past value
      ;;
    -q|--queue)
      QUEUE="$2"
      shift # past argument
      shift # past value
      ;;
    --debug)
      QUEUE="debug"
      shift # past argument
      ;;
   --bsc_es)
      QUEUE="bsc_es"
      shift # past argument
      ;;
   --interactive)
      QUEUE="interactive"
      shift
      ;;
   -c|-counters)
      PAPI="-C perfparanoid"
      shift
      ;;
   -h|--help)
      echo "Usage: ./launch_batch [OPTIONS]"
      echo "-h displays this help"
      echo "-q|--queue set queue name"

      echo "--debug launchs interactive job (MN4) [default]"
      echo "--bsc_es launchs interactive job (MN4)"
      echo "-c|--counters : Enable perfparanoid constrain"

      echo "-b|--batch path to batch file (required)"
      echo "-d|--workdir : Working directory (PWD -> $PWD by default)"
      echo "-j|--job_name set job name"

      echo "-t|--threads set num threads per task. Default 1"
      echo "-m|--mpi set mpi ranks (tasks). Default 1"

      exit 1
      ;;
    -*|--*)
      echo "Unknown option $1"
      exit 1
      ;;
    *)
      POSITIONAL_ARGS+=("$1") # save positional arg
      shift # past argument
      ;;
  esac
done

set -- "${POSITIONAL_ARGS[@]}" # restore positional parameters

#Submit job IF $BATCH_FILE is not empty

if [ -z $BATCH_FILE ]
then
  echo "Error: Not defined batch file! (option -b|--batch)"
  echo "EXIT"
  exit 1
else
  echo "Submitting into $QUEUE QUEUE job $JOB_NAME with"
  echo "batch file: $BATCH_FILE"
  echo "OPENMP: $THREADS_PER_TASK"
  echo "MPI RANKS: $NUM_TASKS"
  echo "WORKDIR: $WORKDIR"


  if [ "$PAPI" = "-C perfparanoid" ] 
  then
    echo "PAPI: Enabled"
  fi
  sbatch -J $JOB_NAME -q $QUEUE -c $THREADS_PER_TASK -n $NUM_TASKS $PAPI $BATCH_FILE $THREADS_PER_TASK $NUM_TASKS $WORKDIR
fi
