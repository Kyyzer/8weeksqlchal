--
-- PostgreSQL database dump
--

-- Dumped from database version 13.18
-- Dumped by pg_dump version 13.18

-- Started on 2024-12-25 16:00:33

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5 (class 2615 OID 16394)
-- Name: dannys_diner; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA dannys_diner;


ALTER SCHEMA dannys_diner OWNER TO postgres;

--
-- TOC entry 2 (class 3079 OID 16384)
-- Name: adminpack; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS adminpack WITH SCHEMA pg_catalog;


--
-- TOC entry 3001 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION adminpack; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION adminpack IS 'administrative functions for PostgreSQL';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 204 (class 1259 OID 16401)
-- Name: members; Type: TABLE; Schema: dannys_diner; Owner: postgres
--

CREATE TABLE dannys_diner.members (
    customer_id character varying(1),
    join_date date
);


ALTER TABLE dannys_diner.members OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16398)
-- Name: menu; Type: TABLE; Schema: dannys_diner; Owner: postgres
--

CREATE TABLE dannys_diner.menu (
    product_id integer,
    product_name character varying(5),
    price integer
);


ALTER TABLE dannys_diner.menu OWNER TO postgres;

--
-- TOC entry 202 (class 1259 OID 16395)
-- Name: sales; Type: TABLE; Schema: dannys_diner; Owner: postgres
--

CREATE TABLE dannys_diner.sales (
    customer_id character varying(1),
    order_date date,
    product_id integer
);


ALTER TABLE dannys_diner.sales OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16404)
-- Name: menu; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.menu (
    product_id integer,
    product_name character varying(5),
    price integer
);


ALTER TABLE public.menu OWNER TO postgres;

--
-- TOC entry 2994 (class 0 OID 16401)
-- Dependencies: 204
-- Data for Name: members; Type: TABLE DATA; Schema: dannys_diner; Owner: postgres
--

COPY dannys_diner.members (customer_id, join_date) FROM stdin;
A	2021-01-07
B	2021-01-09
\.


--
-- TOC entry 2993 (class 0 OID 16398)
-- Dependencies: 203
-- Data for Name: menu; Type: TABLE DATA; Schema: dannys_diner; Owner: postgres
--

COPY dannys_diner.menu (product_id, product_name, price) FROM stdin;
1	sushi	10
2	curry	15
3	ramen	12
\.


--
-- TOC entry 2992 (class 0 OID 16395)
-- Dependencies: 202
-- Data for Name: sales; Type: TABLE DATA; Schema: dannys_diner; Owner: postgres
--

COPY dannys_diner.sales (customer_id, order_date, product_id) FROM stdin;
A	2021-01-01	1
A	2021-01-01	2
A	2021-01-07	2
A	2021-01-10	3
A	2021-01-11	3
A	2021-01-11	3
B	2021-01-01	2
B	2021-01-02	2
B	2021-01-04	1
B	2021-01-11	1
B	2021-01-16	3
B	2021-02-01	3
C	2021-01-01	3
C	2021-01-01	3
C	2021-01-07	3
\.


--
-- TOC entry 2995 (class 0 OID 16404)
-- Dependencies: 205
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.menu (product_id, product_name, price) FROM stdin;
\.


-- Completed on 2024-12-25 16:00:33

--
-- PostgreSQL database dump complete
--

