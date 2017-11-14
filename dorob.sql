
drop table adresne_body.ab;
CREATE table adresne_body.ab as
select adresne_body.vchody.objectid as vchody_objectid,
adresne_body.ulice.streetname, adresne_body.vchody.buildingnumber as streetnumber,
adresne_body.obce.municipalityname,adresne_body.budovy.propertyregistrationnumber as constriptionnumber, adresne_body.vchody.postalcode, municipalitycode, 
adresne_body.vchody.axisb as lat, adresne_body.vchody.axisl lon

FROM adresne_body.obce,adresne_body.ulice,adresne_body.vchody,adresne_body.budovy
where (adresne_body.ulice.objectid = adresne_body.vchody.streetnameidentifier AND 
adresne_body.ulice.municipalityidentifiers = adresne_body.obce.objectId and 
adresne_body.vchody.axisb >0 and adresne_body.vchody.propertyregistrationnumberidentifier = adresne_body.budovy.objectid);



insert into adresne_body.ab
select adresne_body.vchody.objectid as vchody_objectid,
NULL, adresne_body.vchody.buildingnumber as streetnumber, 
adresne_body.obce.municipalityname,adresne_body.budovy.propertyregistrationnumber as constriptionnumber, adresne_body.vchody.postalcode, municipalitycode, 
adresne_body.vchody.axisb as lat, adresne_body.vchody.axisl lon

FROM adresne_body.budovy,adresne_body.vchody,adresne_body.obce 
where (adresne_body.vchody.streetnameidentifier is null and adresne_body.vchody.validto is null and adresne_body.vchody.axisb >0 and 
adresne_body.vchody.propertyregistrationnumberidentifier = adresne_body.budovy.objectid and 
adresne_body.budovy.municipalityidentifier=adresne_body.obce.objectid);


drop table tanicka.datagov_adresy; create table tanicka.datagov_adresy as 
(select vchody_objectid as osm_id, municipalitycode,
streetnumber::text as name, streetname || ' ' || streetnumber ||', '|| postalcode  || ' ' || municipalityname as popis_maly,
st_makepoint(lon, lat) as way 
from adresne_body.ab where streetname is not null)  
union (select vchody_objectid as osm_id, municipalitycode,
constriptionnumber::text as name, 'č. d. ' || constriptionnumber || ', ' || postalcode || ' ' || municipalityname  as popis_maly, 
geography(st_makepoint(lon, lat)) as way from adresne_body.ab where streetname is null);
create index on tanicka.datagov_adresy using gist(way);
grant select on tanicka.datagov_adresy to wwwoma;

drop table tanicka.datagov_ulice; create table tanicka.datagov_ulice as 
select first(streetname) as name, municipalitycode || ' ' || first(municipalityname) as popis_maly, 
st_simplify(st_union(geometry(st_buffer(geography(st_makepoint(lon, lat)), 20))), 0.0001) as way
from adresne_body.ab where char_length(trimname(streetname)) > 3 and streetname not like '%Směrník%' group by municipalitycode, trimname(streetname);
create index on tanicka.datagov_ulice using gist(way);
grant select on tanicka.datagov_ulice to wwwoma;

