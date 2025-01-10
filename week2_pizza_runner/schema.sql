--
-- PostgreSQL database dump
--

-- Dumped from database version 13.18
-- Dumped by pg_dump version 13.18

-- Started on 2025-01-10 20:14:56

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
-- TOC entry 5 (class 2615 OID 16408)
-- Name: pizza_runner; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA pizza_runner;


ALTER SCHEMA pizza_runner OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 210 (class 1259 OID 16445)
-- Name: customer_orders; Type: TABLE; Schema: pizza_runner; Owner: postgres
--

CREATE TABLE pizza_runner.customer_orders (
    order_id integer,
    customer_id integer,
    pizza_id integer,
    exclusions character varying(4),
    extras character varying(4),
    order_time timestamp without time zone
);


ALTER TABLE pizza_runner.customer_orders OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16418)
-- Name: pizza_names; Type: TABLE; Schema: pizza_runner; Owner: postgres
--

CREATE TABLE pizza_runner.pizza_names (
    pizza_id integer,
    pizza_name text
);


ALTER TABLE pizza_runner.pizza_names OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16424)
-- Name: pizza_recipes; Type: TABLE; Schema: pizza_runner; Owner: postgres
--

CREATE TABLE pizza_runner.pizza_recipes (
    pizza_id integer,
    toppings text
);


ALTER TABLE pizza_runner.pizza_recipes OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16430)
-- Name: pizza_toppings; Type: TABLE; Schema: pizza_runner; Owner: postgres
--

CREATE TABLE pizza_runner.pizza_toppings (
    topping_id integer,
    topping_name text
);


ALTER TABLE pizza_runner.pizza_toppings OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16448)
-- Name: runner_orders; Type: TABLE; Schema: pizza_runner; Owner: postgres
--

CREATE TABLE pizza_runner.runner_orders (
    order_id integer,
    runner_id integer,
    pickup_time character varying(19),
    distance character varying(7),
    duration character varying(10),
    cancellation character varying(23)
);


ALTER TABLE pizza_runner.runner_orders OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16409)
-- Name: runners; Type: TABLE; Schema: pizza_runner; Owner: postgres
--

CREATE TABLE pizza_runner.runners (
    runner_id integer,
    registration_date date
);


ALTER TABLE pizza_runner.runners OWNER TO postgres;

--
-- TOC entry 3017 (class 0 OID 16445)
-- Dependencies: 210
-- Data for Name: customer_orders; Type: TABLE DATA; Schema: pizza_runner; Owner: postgres
--

COPY pizza_runner.customer_orders (order_id, customer_id, pizza_id, exclusions, extras, order_time) FROM stdin;
1	101	1			2020-01-01 18:05:02
2	101	1			2020-01-01 19:00:52
3	102	1			2020-01-02 23:51:23
3	102	2		\N	2020-01-02 23:51:23
4	103	1	4		2020-01-04 13:23:46
4	103	1	4		2020-01-04 13:23:46
4	103	2	4		2020-01-04 13:23:46
5	104	1	null	1	2020-01-08 21:00:29
6	101	2	null	null	2020-01-08 21:03:13
7	105	2	null	1	2020-01-08 21:20:29
8	102	1	null	null	2020-01-09 23:54:33
9	103	1	4	1, 5	2020-01-10 11:22:59
10	104	1	null	null	2020-01-11 18:34:49
10	104	1	2, 6	1, 4	2020-01-11 18:34:49
\.


--
-- TOC entry 3014 (class 0 OID 16418)
-- Dependencies: 207
-- Data for Name: pizza_names; Type: TABLE DATA; Schema: pizza_runner; Owner: postgres
--

COPY pizza_runner.pizza_names (pizza_id, pizza_name) FROM stdin;
1	Meatlovers
2	Vegetarian
\.


--
-- TOC entry 3015 (class 0 OID 16424)
-- Dependencies: 208
-- Data for Name: pizza_recipes; Type: TABLE DATA; Schema: pizza_runner; Owner: postgres
--

COPY pizza_runner.pizza_recipes (pizza_id, toppings) FROM stdin;
1	1, 2, 3, 4, 5, 6, 8, 10
2	4, 6, 7, 9, 11, 12
\.


--
-- TOC entry 3016 (class 0 OID 16430)
-- Dependencies: 209
-- Data for Name: pizza_toppings; Type: TABLE DATA; Schema: pizza_runner; Owner: postgres
--

COPY pizza_runner.pizza_toppings (topping_id, topping_name) FROM stdin;
1	Bacon
2	BBQ Sauce
3	Beef
4	Cheese
5	Chicken
6	Mushrooms
7	Onions
8	Pepperoni
9	Peppers
10	Salami
11	Tomatoes
12	Tomato Sauce
\.


--
-- TOC entry 3018 (class 0 OID 16448)
-- Dependencies: 211
-- Data for Name: runner_orders; Type: TABLE DATA; Schema: pizza_runner; Owner: postgres
--

COPY pizza_runner.runner_orders (order_id, runner_id, pickup_time, distance, duration, cancellation) FROM stdin;
1	1	2020-01-01 18:15:34	20km	32 minutes	
2	1	2020-01-01 19:10:54	20km	27 minutes	
3	1	2020-01-03 00:12:37	13.4km	20 mins	\N
4	2	2020-01-04 13:53:03	23.4	40	\N
5	3	2020-01-08 21:10:57	10	15	\N
6	3	null	null	null	Restaurant Cancellation
7	2	2020-01-08 21:30:45	25km	25mins	null
8	2	2020-01-10 00:15:02	23.4 km	15 minute	null
9	2	null	null	null	Customer Cancellation
10	1	2020-01-11 18:50:20	10km	10minutes	null
\.


--
-- TOC entry 3013 (class 0 OID 16409)
-- Dependencies: 206
-- Data for Name: runners; Type: TABLE DATA; Schema: pizza_runner; Owner: postgres
--

COPY pizza_runner.runners (runner_id, registration_date) FROM stdin;
1	2021-01-01
2	2021-01-03
3	2021-01-08
4	2021-01-15
\.


-- Completed on 2025-01-10 20:14:57

--
-- PostgreSQL database dump complete
--

