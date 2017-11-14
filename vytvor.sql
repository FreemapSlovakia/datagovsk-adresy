--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: adresne_body; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA adresne_body;


ALTER SCHEMA adresne_body OWNER TO postgres;

SET search_path = adresne_body, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ab; Type: TABLE; Schema: adresne_body; Owner: michal; Tablespace: 
--

CREATE TABLE ab (
    vchody_objectid double precision,
    streetname text,
    streetnumber text,
    municipalityname text,
    constriptionnumber double precision,
    postalcode text,
    municipalitycode text,
    lat double precision,
    lon double precision
);


ALTER TABLE ab OWNER TO michal;

--
-- Name: budovy; Type: TABLE; Schema: adresne_body; Owner: michal; Tablespace: 
--

CREATE TABLE budovy (
    changedat timestamp without time zone,
    objectid double precision,
    versionid double precision,
    validfrom timestamp without time zone,
    validto timestamp without time zone,
    effectivedate date,
    propertyregistrationnumber double precision,
    buildingname text,
    containsflats boolean,
    buildingpurposecodelistcode text,
    buildingpurposecode text,
    buildingpurposename text,
    buildingtypecodelistcode text,
    buildingtypecode double precision,
    buildingtypename text,
    municipalityidentifier double precision,
    districtidentifier double precision,
    _id integer NOT NULL
);


ALTER TABLE budovy OWNER TO michal;

--
-- Name: obce; Type: TABLE; Schema: adresne_body; Owner: michal; Tablespace: 
--

CREATE TABLE obce (
    changedat timestamp without time zone,
    objectid double precision,
    versionid double precision,
    validfrom timestamp without time zone,
    validto timestamp without time zone,
    effectivedate date,
    codelistcode text,
    municipalitycode text,
    municipalityname text,
    countyidentifier double precision,
    status text,
    cityidentifier double precision,
    _id integer NOT NULL
);


ALTER TABLE obce OWNER TO michal;

--
-- Name: COLUMN obce.changedat; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.changedat IS 'dátum a čavykonania zmeny';


--
-- Name: COLUMN obce.objectid; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.objectid IS 'identifikátor objektu';


--
-- Name: COLUMN obce.versionid; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.versionid IS 'identifikátor verzie záznamu';


--
-- Name: COLUMN obce.validfrom; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.validfrom IS 'dátum a čaplatnosti začiatku platnosti záznamu (hraničný dátumplatnosti od 1.1.1000 má hodnotu null)';


--
-- Name: COLUMN obce.validto; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.validto IS 'dátum a čaplatnosti konca platnosti záznamu (hraničný dátumplatnosti do 31.12.3000 má hodnotu null)';


--
-- Name: COLUMN obce.effectivedate; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.effectivedate IS 'dátum účinnosti';


--
-- Name: COLUMN obce.codelistcode; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.codelistcode IS 'identifikátor číselníka obcí. vždy cl000025.';


--
-- Name: COLUMN obce.municipalitycode; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.municipalitycode IS 'údaj o obci, obvykle zodpovedá kódu v&nbspčíselníku cl000025';


--
-- Name: COLUMN obce.municipalityname; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.municipalityname IS 'názov obce ';


--
-- Name: COLUMN obce.countyidentifier; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.countyidentifier IS 'identifikátor (county/objectid)&nbspnadradeného okresu';


--
-- Name: COLUMN obce.status; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.status IS 'štatút obce';


--
-- Name: COLUMN obce.cityidentifier; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce.cityidentifier IS 'identifikátor (municipality/objectid) nadradeného mesta premestskú časťpoložka je vyplnená ak jetatu== mestska_cast';


--
-- Name: COLUMN obce._id; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN obce._id IS 'technický identifikátorriadku vygenerovaný automaticky v mode.';


--
-- Name: ulice; Type: TABLE; Schema: adresne_body; Owner: michal; Tablespace: 
--

CREATE TABLE ulice (
    changedat timestamp without time zone,
    objectid double precision,
    versionid double precision,
    validfrom timestamp without time zone,
    validto timestamp without time zone,
    effectivedate date,
    streetname text,
    districtidentifiers double precision,
    municipalityidentifiers double precision,
    _id integer NOT NULL
);


ALTER TABLE ulice OWNER TO michal;

--
-- Name: COLUMN ulice.changedat; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN ulice.changedat IS 'dátum a čavykonania zmeny';


--
-- Name: COLUMN ulice.objectid; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN ulice.objectid IS 'identifikátor objektu';


--
-- Name: COLUMN ulice.versionid; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN ulice.versionid IS 'identifikátor verzie záznamu';


--
-- Name: COLUMN ulice.validfrom; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN ulice.validfrom IS 'dátum a čaplatnosti začiatku platnosti záznamu (hraničný dátumplatnosti od 1.1.1000 má hodnotu null)';


--
-- Name: COLUMN ulice.validto; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN ulice.validto IS 'dátum a čaplatnosti konca platnosti záznamu (hraničný dátumplatnosti do 31.12.3000 má hodnotu null)';


--
-- Name: COLUMN ulice.effectivedate; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN ulice.effectivedate IS 'dátum účinnosti';


--
-- Name: COLUMN ulice.streetname; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN ulice.streetname IS 'názov';


--
-- Name: COLUMN ulice.districtidentifiers; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN ulice.districtidentifiers IS 'zoznam identifikátorov častí obce, cez ktoré ulica prechádza';


--
-- Name: COLUMN ulice.municipalityidentifiers; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN ulice.municipalityidentifiers IS 'buď identifikátor obce alebo identifikátory mestských častí, cezktoré ulica prechádza';


--
-- Name: COLUMN ulice._id; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN ulice._id IS 'technický identifikátorriadku vygenerovaný automaticky v mode.';


--
-- Name: vchody; Type: TABLE; Schema: adresne_body; Owner: michal; Tablespace: 
--

CREATE TABLE vchody (
    changedat timestamp without time zone,
    objectid double precision,
    versionid double precision,
    validfrom timestamp without time zone,
    validto timestamp without time zone,
    effectivedate date,
    buildingnumber text,
    buildingindex text,
    postalcode text,
    axisb double precision,
    axisl double precision,
    propertyregistrationnumberidentifier double precision,
    streetnameidentifier double precision,
    verifiedat timestamp without time zone,
    _id integer NOT NULL
);


ALTER TABLE vchody OWNER TO michal;

--
-- Name: COLUMN vchody.changedat; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.changedat IS 'dátum a čavykonania zmeny';


--
-- Name: COLUMN vchody.objectid; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.objectid IS 'identifikátor objektu';


--
-- Name: COLUMN vchody.versionid; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.versionid IS 'identifikátor verzie záznamu';


--
-- Name: COLUMN vchody.validfrom; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.validfrom IS 'dátum a čaplatnosti začiatku platnosti záznamu (hraničný dátumplatnosti od 1.1.1000 má hodnotu null)';


--
-- Name: COLUMN vchody.validto; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.validto IS 'dátum a čaplatnosti konca platnosti záznamu (hraničný dátumplatnosti do 31.12.3000 má hodnotu null)';


--
-- Name: COLUMN vchody.effectivedate; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.effectivedate IS 'dátum účinnosti';


--
-- Name: COLUMN vchody.buildingnumber; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.buildingnumber IS 'orientačné číslo vchodu';


--
-- Name: COLUMN vchody.buildingindex; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.buildingindex IS 'identifikátor adresy';


--
-- Name: COLUMN vchody.postalcode; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.postalcode IS '&nbsp';


--
-- Name: COLUMN vchody.axisb; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.axisb IS 'súradnice zemepisnej šírky (etrs89)';


--
-- Name: COLUMN vchody.axisl; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.axisl IS 'súradnice zemepisnej dĺžky (etrs89)';


--
-- Name: COLUMN vchody.propertyregistrationnumberidentifier; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.propertyregistrationnumberidentifier IS 'identifikátor(propertyregistrationnumber/objectid)&nbspsúpisného čísla';


--
-- Name: COLUMN vchody.streetnameidentifier; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.streetnameidentifier IS 'identifikátor (streetname/objectid)&nbspulice';


--
-- Name: COLUMN vchody.verifiedat; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody.verifiedat IS 'dátum a čaverifikovania adresy';


--
-- Name: COLUMN vchody._id; Type: COMMENT; Schema: adresne_body; Owner: michal
--

COMMENT ON COLUMN vchody._id IS 'technický identifikátorriadku vygenerovaný automaticky v mode';


--
-- Name: adresne_body; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA adresne_body FROM PUBLIC;
REVOKE ALL ON SCHEMA adresne_body FROM postgres;
GRANT ALL ON SCHEMA adresne_body TO postgres;
GRANT ALL ON SCHEMA adresne_body TO michal;


--
-- PostgreSQL database dump complete
--

