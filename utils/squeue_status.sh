#!/bin/bash


echo "There are $(sprio -p ju-standard | wc -l) jobs in ju-std & $(sprio -p ju-standard | wc -l) in ju-std queues waiting for allocation."
echo "There are $(sprio -p ju-strategic | wc -l) jobs in the ju-strat & $(sprio -p ju-strategic | wc -l) in ju-strat queues waiting for allocation."
echo "There are $(sprio -p small | wc -l) jobs in the small & $(sprio -p standard | wc -l) at the standard queues waiting for allocation."
echo "There are $(sprio -p small-g | wc -l) jobs in the small-g & $(sprio -p standard-g | wc -l) at the standard-g queues waiting for allocation."

echo -e "############################"
#echo "Reservation queue"
#\squeue -R climateDTdebug_standard
#echo "Aina's queue"
#\squeue -u aayaiavi
#echo "Vijendra's queue"
#\squeue -u vsingh
#echo -e "############################"
echo -e "My Jobs queue:"
squeue --Format=jobid:10,Name:20,NumNodes:6,State:8,Reason:10,starttime:20,TimeUsed:10,Partition:12, --me
echo ""

export SPRIO_FORMAT="%10i %10Y %4A %.10F %.10u"

echo -e "############################"
echo -e "Priority of my jobs:\n"
sprio -u $USER
#sprio -u aayaiavi

echo -e "############################"
echo -e "First six jobs @ queues:\n"
echo "LUMI-C: SMALL"
sprio -S "-Y" -p small | head -n 6
echo "LUMI-C: STANDARD"
sprio -S "-Y" -p standard | head -n 6
echo "JU-STD"
sprio -S "-Y" -p ju-standard | head -n 6
echo "JU-STRAT"
sprio -S "-Y" -p ju-strategic | head -n 6
echo -e "############################"

echo "Total usague of the queues:"
sinfo -s -p small,standard,small-g,standard-g,debug,dev-g,ju-standard,ju-strategic
