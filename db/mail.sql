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
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: alias; Type: TABLE; Schema: public; Owner: kendall; Tablespace: 
--

CREATE TABLE alias (
    id integer NOT NULL,
    member_id integer,
    domain_id integer,
    name character varying(255)
);


ALTER TABLE public.alias OWNER TO kendall;

--
-- Name: alias_id_seq; Type: SEQUENCE; Schema: public; Owner: kendall
--

CREATE SEQUENCE alias_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.alias_id_seq OWNER TO kendall;

--
-- Name: alias_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kendall
--

ALTER SEQUENCE alias_id_seq OWNED BY alias.id;


--
-- Name: domain; Type: TABLE; Schema: public; Owner: kendall; Tablespace: 
--

CREATE TABLE domain (
    id integer NOT NULL,
    name character varying(255)
);


ALTER TABLE public.domain OWNER TO kendall;

--
-- Name: domain_id_seq; Type: SEQUENCE; Schema: public; Owner: kendall
--

CREATE SEQUENCE domain_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.domain_id_seq OWNER TO kendall;

--
-- Name: domain_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kendall
--

ALTER SEQUENCE domain_id_seq OWNED BY domain.id;


--
-- Name: drop; Type: TABLE; Schema: public; Owner: kendall; Tablespace: 
--

CREATE TABLE drop (
    id integer NOT NULL,
    date timestamp without time zone,
    recipient character varying(255),
    body text,
    processed boolean NOT NULL
);


ALTER TABLE public.drop OWNER TO kendall;

--
-- Name: drop_id_seq; Type: SEQUENCE; Schema: public; Owner: kendall
--

CREATE SEQUENCE drop_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.drop_id_seq OWNER TO kendall;

--
-- Name: drop_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kendall
--

ALTER SEQUENCE drop_id_seq OWNED BY drop.id;


--
-- Name: member; Type: TABLE; Schema: public; Owner: kendall; Tablespace: 
--

CREATE TABLE member (
    id integer NOT NULL,
    name character varying(255),
    password bytea
);


ALTER TABLE public.member OWNER TO kendall;

--
-- Name: member_id_seq; Type: SEQUENCE; Schema: public; Owner: kendall
--

CREATE SEQUENCE member_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.member_id_seq OWNER TO kendall;

--
-- Name: member_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kendall
--

ALTER SEQUENCE member_id_seq OWNED BY member.id;


--
-- Name: message; Type: TABLE; Schema: public; Owner: kendall; Tablespace: 
--

CREATE TABLE message (
    id integer NOT NULL,
    member_id integer NOT NULL,
    date timestamp without time zone,
    alias_id integer NOT NULL,
    subject text,
    body text
);


ALTER TABLE public.message OWNER TO kendall;

--
-- Name: message_id_seq; Type: SEQUENCE; Schema: public; Owner: kendall
--

CREATE SEQUENCE message_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.message_id_seq OWNER TO kendall;

--
-- Name: message_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: kendall
--

ALTER SEQUENCE message_id_seq OWNED BY message.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kendall
--

ALTER TABLE ONLY alias ALTER COLUMN id SET DEFAULT nextval('alias_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kendall
--

ALTER TABLE ONLY domain ALTER COLUMN id SET DEFAULT nextval('domain_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kendall
--

ALTER TABLE ONLY drop ALTER COLUMN id SET DEFAULT nextval('drop_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kendall
--

ALTER TABLE ONLY member ALTER COLUMN id SET DEFAULT nextval('member_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: kendall
--

ALTER TABLE ONLY message ALTER COLUMN id SET DEFAULT nextval('message_id_seq'::regclass);


--
-- Name: alias_pkey; Type: CONSTRAINT; Schema: public; Owner: kendall; Tablespace: 
--

ALTER TABLE ONLY alias
    ADD CONSTRAINT alias_pkey PRIMARY KEY (id);


--
-- Name: domain_pkey; Type: CONSTRAINT; Schema: public; Owner: kendall; Tablespace: 
--

ALTER TABLE ONLY domain
    ADD CONSTRAINT domain_pkey PRIMARY KEY (id);


--
-- Name: member_pkey; Type: CONSTRAINT; Schema: public; Owner: kendall; Tablespace: 
--

ALTER TABLE ONLY member
    ADD CONSTRAINT member_pkey PRIMARY KEY (id);


--
-- Name: message_pkey; Type: CONSTRAINT; Schema: public; Owner: kendall; Tablespace: 
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_pkey PRIMARY KEY (id);


--
-- Name: alias_domain_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kendall
--

ALTER TABLE ONLY alias
    ADD CONSTRAINT alias_domain_id_fkey FOREIGN KEY (domain_id) REFERENCES domain(id);


--
-- Name: alias_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kendall
--

ALTER TABLE ONLY alias
    ADD CONSTRAINT alias_member_id_fkey FOREIGN KEY (member_id) REFERENCES member(id);


--
-- Name: message_alias_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kendall
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_alias_id_fkey FOREIGN KEY (alias_id) REFERENCES alias(id);


--
-- Name: message_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: kendall
--

ALTER TABLE ONLY message
    ADD CONSTRAINT message_member_id_fkey FOREIGN KEY (member_id) REFERENCES member(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

