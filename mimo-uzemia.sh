#!/bin/sh
# create table www.datagov_adresy_debug (osm_id int, name text, way geography, popis_maly text); create index on datagov_adresy_debug using gist(way);
# test Dudince SK0325518387
#for obec in `echo "select municipalitycode from datagov_adresy where municipalitycode like 'SK%' group by municipalitycode order by municipalitycode;" | psql -t mapnik`; do
for obec in `echo "select name from datagov_adresy_debug group by name order by name;" | psql -t mapnik`; do
	echo $obec;
	echo "delete from datagov_adresy_debug where name='$obec'; insert into datagov_adresy_debug select osm_id, municipalitycode, way, popis_maly || ' je mimo SR' from www.datagov_adresy where municipalitycode ='$obec' and st_intersects(way, (select way from oblasti where typ='sr')) = false; insert into datagov_adresy_debug select datagov_adresy.osm_id, municipalitycode, datagov_adresy.way, datagov_adresy.popis_maly || ' je v ' || lau2 || ' ' || oblasti.name from datagov_adresy, oblasti, obce_sr where oblasti.osm_id= obce_sr.osm_id and st_intersects(oblasti.way, datagov_adresy.way) and obce_sr.lau2 != municipalitycode and municipalitycode ='$obec'; " |psql -q mapnik
done
