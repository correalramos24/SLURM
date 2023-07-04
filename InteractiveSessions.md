

To allocate an interactive session, use:
* LUMI
````bash
salloc --nodes=1 --account=project_465000454 --partition=small --time=00:30:00
srun --cpu_bind=none --nodes=1 --pty bash -i
````
* MN4
````bash
salloc -q debug -N 1 -c 48
#For enabling the performance counters:
salloc -q debug -N 1 -c 48 -C perfparanoid
````

