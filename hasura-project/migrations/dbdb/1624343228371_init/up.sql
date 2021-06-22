SET check_function_bodies = false;
CREATE TABLE public.table1 (
    id integer NOT NULL
);
CREATE TABLE public.table2 (
    id uuid DEFAULT gen_random_uuid() NOT NULL
);
ALTER TABLE ONLY public.table1
    ADD CONSTRAINT table1_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.table2
    ADD CONSTRAINT table2_pkey PRIMARY KEY (id);
