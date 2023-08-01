#!/bin/bash
echo -e "############################"
echo -e "My Jobs queue:"
squeue --Format=jobid:10,Name:30,NumNodes:6,State:8,Reason:10,starttime:20,TimeUsed,Partition:10, --me
echo ""
echo "There are $(sprio -p small | wc -l) jobs in the small & $(sprio -p standard | wc -l) at the standard"

export SPRIO_FORMAT="%10i %10Y %4A %.10F %.10u"

echo -e "############################"
echo -e "Priority of my jobs:\n"
sprio -u $USER
echo -e "############################"
echo -e "First jobs @ small and standard queues:\n"
sprio -S "-Y" -p small | head -n 2
echo ""
sprio -S "-Y" -p standard | head -n 2
echo -e "############################"
