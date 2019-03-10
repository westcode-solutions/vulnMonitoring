#!/bin/bash

ett=""
tva=""
tre=""
datum=$(date +%Y-%m-%d)
startDatum=$(date -d 2018-01-01 +%Y-%m-%d)
datum_diff=$(( ($(date -d $datum +%s) - $(date -d $startDatum +%s) )/(60*60*24) ))
echo $datum
mkdir /mnt/hgfs/C/WCS/Omvärldsbevakning/CVE/$datum
for prod in $(cat list.txt); do
	ett=$(echo $prod | cut -d , -f 1)
	tva=$(echo $prod | cut -d , -f 2)
	tre=$(echo $prod | cut -d , -f 3)
	echo Bearbetar mjukvara: $tva , version: $tre

	# söker efter sårbarheter från 2018-01-01 och framåt.
	python3 /root/cve-search/bin/search.py -p $ett:$tva:$tre -t $datum_diff -o html > /mnt/hgfs/C/WCS/Omvärldsbevakning/CVE/$datum/$datum-result-$tva.html
done

echo Rensar filer utan resultat
for file in $(find /mnt/hgfs/C/WCS/Omvärldsbevakning/CVE/ -name "*.html" -size 1k); do
	echo Tar bort $file
	rm -f $file
done
