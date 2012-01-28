--
-- PostgreSQL database dump
--

-- Dumped from database version 9.1.2
-- Dumped by pg_dump version 9.1.2
-- Started on 2012-01-28 10:22:05 GMT

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

-- Role: feed

-- DROP ROLE feed;

CREATE ROLE feed LOGIN
  NOSUPERUSER INHERIT NOCREATEDB NOCREATEROLE;

--
-- TOC entry 1872 (class 1262 OID 16405)
-- Name: feed; Type: DATABASE; Schema: -; Owner: feed
--

CREATE DATABASE feed WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'en_GB.UTF-8' LC_CTYPE = 'en_GB.UTF-8';


ALTER DATABASE feed OWNER TO feed;

\connect feed

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- TOC entry 165 (class 3079 OID 11646)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 1875 (class 0 OID 0)
-- Dependencies: 165
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 162 (class 1259 OID 16408)
-- Dependencies: 6
-- Name: instance; Type: TABLE; Schema: public; Owner: feed; Tablespace: 
--

CREATE TABLE instance (
    id integer NOT NULL,
    name text,
    description text
);


ALTER TABLE public.instance OWNER TO feed;

--
-- TOC entry 161 (class 1259 OID 16406)
-- Dependencies: 162 6
-- Name: instance_id_seq; Type: SEQUENCE; Schema: public; Owner: feed
--

CREATE SEQUENCE instance_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.instance_id_seq OWNER TO feed;

--
-- TOC entry 1876 (class 0 OID 0)
-- Dependencies: 161
-- Name: instance_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: feed
--

ALTER SEQUENCE instance_id_seq OWNED BY instance.id;


--
-- TOC entry 1877 (class 0 OID 0)
-- Dependencies: 161
-- Name: instance_id_seq; Type: SEQUENCE SET; Schema: public; Owner: feed
--

SELECT pg_catalog.setval('instance_id_seq', 1, false);


--
-- TOC entry 164 (class 1259 OID 16428)
-- Dependencies: 6
-- Name: sources; Type: TABLE; Schema: public; Owner: feed; Tablespace: 
--

CREATE TABLE sources (
    id integer NOT NULL,
    instance integer,
    url text
);


ALTER TABLE public.sources OWNER TO feed;

--
-- TOC entry 163 (class 1259 OID 16426)
-- Dependencies: 6 164
-- Name: sources_id_seq; Type: SEQUENCE; Schema: public; Owner: feed
--

CREATE SEQUENCE sources_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.sources_id_seq OWNER TO feed;

--
-- TOC entry 1878 (class 0 OID 0)
-- Dependencies: 163
-- Name: sources_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: feed
--

ALTER SEQUENCE sources_id_seq OWNED BY sources.id;


--
-- TOC entry 1879 (class 0 OID 0)
-- Dependencies: 163
-- Name: sources_id_seq; Type: SEQUENCE SET; Schema: public; Owner: feed
--

SELECT pg_catalog.setval('sources_id_seq', 2, true);


--
-- TOC entry 1862 (class 2604 OID 16411)
-- Dependencies: 162 161 162
-- Name: id; Type: DEFAULT; Schema: public; Owner: feed
--

ALTER TABLE instance ALTER COLUMN id SET DEFAULT nextval('instance_id_seq'::regclass);


--
-- TOC entry 1863 (class 2604 OID 16431)
-- Dependencies: 163 164 164
-- Name: id; Type: DEFAULT; Schema: public; Owner: feed
--

ALTER TABLE sources ALTER COLUMN id SET DEFAULT nextval('sources_id_seq'::regclass);



--
-- TOC entry 1865 (class 2606 OID 16438)
-- Dependencies: 162 162
-- Name: instances_key; Type: CONSTRAINT; Schema: public; Owner: feed; Tablespace: 
--

ALTER TABLE ONLY instance
    ADD CONSTRAINT instances_key PRIMARY KEY (id);


--
-- TOC entry 1867 (class 2606 OID 16436)
-- Dependencies: 164 164
-- Name: sources_key; Type: CONSTRAINT; Schema: public; Owner: feed; Tablespace: 
--

ALTER TABLE ONLY sources
    ADD CONSTRAINT sources_key PRIMARY KEY (id);


--
-- TOC entry 1874 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2012-01-28 10:22:06 GMT

--
-- PostgreSQL database dump complete
--

