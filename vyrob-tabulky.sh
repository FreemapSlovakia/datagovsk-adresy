#!/bin/bash
# pg_dump --schema-only --schema adresne_body mapnik > vytvor.sql
# najpry vytvor.sql
# create schema adresne_body; grant all on schema adresne_body to michal;
date;
cd /home/vseobecne/projekty/osm/datagov
echo "select 'pocet pred: ' ||count(*) from adresne_body.ab" | psql -t mapnik

vyrob_tab () {
tab="${pref}$1";
if [ "$3" != "" ]; then 
	# arrays?
	#echo "\d $tab"  |psql mapnik|grep '\[\]'| sed 's#|.*##'
	#wget -q -O - "$3" | sed 's#,"\([0-9]\)#,"{\1#g' | sed 's#\([0-9]\)",#\1}",#g'| grep -v 3261,4571 > $1.csv
	wget -q --limit-rate=15m -O - "$3" | grep -v "'" | grep -v '"[0-9]' | sed 's/None//g' > $1.csv
#grep -v 3261,4571 |
	col=`head -n 1 $1.csv |  sed 's/\r//g' | tr '[:upper:]' '[:lower:]'`;
	echo "truncate table $tab" | psql mapnik;
	echo "\COPY $tab ($col) FROM '$1.csv' DELIMITERS ',' CSV header; " | psql mapnik;
	echo "delete from $tab where validto is not null;" | psql mapnik
	ls -lh $1.csv; echo "select 'pocet $1: ' ||count(*) from $tab" | psql -t mapnik
	rm $1.csv;
fi
}
pref="adresne_body."
vyrob_tab "vchody" "https://data.gov.sk/dataset/register-adries-register-vchodov/resource/849d6364-10cf-40dd-a354-aba17ae06c52" "https://data.gov.sk/datastore/dump/011f4ec3-7a73-4dff-a63e-81b64cc52947?all=true";
vyrob_tab "ulice" "https://data.gov.sk/dataset/f2b3af7a-b4d4-45d7-9605-29fa5d7ad115/resource/29936968-f4c5-4afc-8c71-a2da2ae142bf/download/package6doc1.htm" "https://data.gov.sk/datastore/dump/47f0e853-3a67-487e-b45f-3f5d099105cf?all=true"
vyrob_tab "budovy" "https://data.gov.sk/dataset/register-adries-register-budov/resource/0ec5e14d-808c-4ebd-9717-45706059fac3" "https://data.gov.sk/datastore/dump/2ba406d0-5ce5-472d-ba75-5e04f05be1c1?all=true"
vyrob_tab "obce" "https://data.gov.sk/dataset/register-adries-register-obci/resource/a8d03e5d-ac1a-4f8a-b4b5-1df7227f202f" "https://data.gov.sk/datastore/dump/15262453-4a0f-4cce-a9e4-7709e135e4b8?all=true"

cat dorob.sql | psql mapnik

c=`psql -q -t -c "select count(*) from adresne_body.ab" mapnik 2> /dev/null  | sed 's/ //'`
if [ "0$c" -lt 10000 ]; then
    echo "iba $c udajov v adresach, koncim";
    exit;
fi


echo "copy ((select streetname as street, streetnumber::text as number, postalcode as postcode, municipalityname as city, lat, lon, constriptionnumber from adresne_body.ab where streetname is not null) union (select municipalityname, constriptionnumber::text, postalcode, municipalityname, lat, lon, constriptionnumber from  adresne_body.ab where streetname is null)) to stdout csv delimiter ';' header force quote street, city "| psql mapnik> sk/countrywide.csv

zip sk-countrywide.zip sk/*
ls -lh sk/* sk-countrywide.zip

rm sk/countrywide.csv
mv sk-countrywide.zip /home/vseobecne/www/weby/epsilon.sk/
scp -Cqp /home/vseobecne/www/weby/epsilon.sk/sk-countrywide.zip izsk@10.9.0.1:/home/izsk/weby/epsilon.sk/
echo "select 'pocet po: ' ||count(*) from adresne_body.ab" | psql -t mapnik
date;
