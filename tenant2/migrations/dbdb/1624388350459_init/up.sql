SET check_function_bodies = false;
CREATE TABLE public.table1 (
    id integer NOT NULL,
    text text NOT NULL
);
CREATE SEQUENCE public.table1_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.table1_id_seq OWNED BY public.table1.id;
CREATE TABLE public.table2 (
    id integer NOT NULL,
    table1id integer NOT NULL
);
CREATE SEQUENCE public.table2_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.table2_id_seq OWNED BY public.table2.id;
ALTER TABLE ONLY public.table1 ALTER COLUMN id SET DEFAULT nextval('public.table1_id_seq'::regclass);
ALTER TABLE ONLY public.table2 ALTER COLUMN id SET DEFAULT nextval('public.table2_id_seq'::regclass);
ALTER TABLE ONLY public.table1
    ADD CONSTRAINT table1_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.table2
    ADD CONSTRAINT table2_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.table2
    ADD CONSTRAINT table2_table1id_fkey FOREIGN KEY (table1id) REFERENCES public.table1(id) ON UPDATE RESTRICT ON DELETE RESTRICT;
