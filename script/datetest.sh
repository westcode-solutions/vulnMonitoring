#!/bin/bash
dagensDatum=$(date +%Y-%m-%d)
startDatum=$(date -d 2018-01-01 +%Y-%m-%d)
echo $dagensDatum
echo $startDatum

date_diff=$(( ($(date -d $dagensDatum +%s) - $(date -d $startDatum +%s) )/(60*60*24) ))

echo $date_diff
