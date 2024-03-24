#!/bin/bash



parse_args_slurm() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            --script)
                SCRIPT="$2"
                shift;shift;
            ;;
            --workdir)
                WORKDIR="$2"
                shift;shift;
            ;;
            --cleanrun)
                CLEAN_RUN=true
                shift
            ;;
            --test)
                SUBMIT_OR_TEST="TEST"
                shift
            ;;
            --jobname)
                JOBNAME="$2"
                shift;shift;
            ;;
            -m|--mpi)
                MPI_PER_NODE="$2"
                shift;shift;
            ;;
            -t|--threads)
                OMP_PER_NODE="$2"
                shift;shift;
            ;;
            -n|--nodes)
                NODES="$2"
                shift;shift;
            ;;
            -q|--queue)
                QUEUE="$2"
                shift;shift;
            ;;
            --perfcounters)
                PERF_COUNTERS="-C perfparanoid"
                shift
            ;;
        esac
    done
}

check_required_slurm(){
    echo -n "Checking arguments... "
    if [ -z $SCRIPT ]; then
        echo "Error: You must set script with --script"
        exit 1
    fi
    if [ -z $WORKDIR ]; then
        echo "Error: You must set a workdirectory with --workdir"
        exit 1
    fi
    echo "Done"
}

submit_and_trace(){

    if [[ $SUBMIT_OR_TEST == "SUBMIT" ]]; then
        # Check nodes && queue
        if [ -z $QUEUE ]; then
            echo "Error: Queue not set. You must use --queue|-q"
        fi
        if [ -z $NODES ]; then
            echo "Error: Nodes not set. You must use --nodes|-n"
        fi

        JOB_ID=$(sbatch  -J $JOB_NAME -q $QUEUE \
                -c $OMP_PER_TASK -n $NUM_TASKS -N $NODES \
                --exclusive --parsable ) 
        echo "Submitting $JOB_ID job"
        # TODO: NOTIFY MY LOGGING SYSTEM HERE
    else
        echo "Executin $SCRIPT without sbatch"
        ./$SCRIPT
    fi
    
}













