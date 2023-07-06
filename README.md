# SLURM utils repository

SLURM boilerplates, submission scripts and other utils files.

## Introduction

## Useful commands


## Other directives
* Hyperthreading control (\[don't\] use extra in-core threads) : `--hint=[no]multithread`

## Binding & Affinity at node, task and thread level
The **tasks binding** for each node can be set up with the `--cpu-bind=[{quiet|verbose},]<type>` directive in the `srun` command. 
The different types could be:
* none: No Binding
* rank: Bind task by rank
* map_cpu: With format map_cpu:<cpu_id_for_task0>,<cpu_id_for_task1>,<cpu_id_for_task2>,...
* mask_cpu: With format mask_cpu:<cpu_mask_for_task_0>,<cpu_mask_for_task_1>,... (expected 0x format)
* sockets, cores, threads,ldom: Automatically generate mask binding tasks to the socket, cores, threads, and Numa nodes.
> You Can use \*X for repetition count into map and mask directives (map_cpu:0*4,3*4)

```bash
srun --cpu-bin=verbose,threads ./your_app
```
For the inter-task thread distribution (which is inherited from the task binding) needs to be set with the OMP environmental variables.

Regarding the distribution policy for the entire job (task placing in nodes), the `-m/--distribution` flag is used. For the GPU's jobs, `--gpu-bind=[verbose,]<type>` is required.

## Heterogenous jobs (ToDo)

