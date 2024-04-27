
export SACCT_FORMAT="ExitCode,JobName%-20,Elapsed,Timelimit,JobId,NNodes,NTasks,ReqCPUS,Start,NodeList%-100"

# queue commands:
alias squeue='squeue --me'
alias queue='watch -t -n 1 squeue --me'
alias standard_prio='sprio -S "+Y" -p standard'
alias info_queue='sinfo -s'

# CATS Project:
alias sbatch_cats='sbatch --account=project_465000454'
alias srun_cats='srun --account=project_465000454'
alias interactive_cats='srun --account=project_465000454 --pty bash'

# DEODE Project:
alias sbatch_deode='sbatch --account=project_465000527'
alias srun_deode='srun --account=project_465000527'
alias interactive_cats='srun --account=project_465000527 --pty bash'

