SET check_function_bodies = false;
CREATE FUNCTION public.runjobs() RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
    UPDATE job
    SET status = 'running'
    WHERE id in (
        select 
             distinct on (project_id) id 
        from job 
        where project_id in 
            (
                select distinct project_id from job where project_id not in 
                    (select distinct project_id from job where status = 'running')
            ) and status = 'scheduled'
        order by 
            project_id, 
            timestamp desc
    );
END;
$$;
CREATE TABLE public.jobs (
    id integer NOT NULL,
    status text DEFAULT 'scheduled'::text NOT NULL,
    job_type text DEFAULT 'github_integration'::text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    project_id integer NOT NULL
);
CREATE SEQUENCE public.jobs_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;
CREATE TABLE public.test (
    id integer NOT NULL
);
CREATE TABLE public.test2 (
    id integer NOT NULL
);
CREATE SEQUENCE public.test_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.test_id_seq OWNED BY public.test.id;
CREATE TABLE public.test_table (
    id integer NOT NULL
);
CREATE SEQUENCE public.test_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
ALTER SEQUENCE public.test_table_id_seq OWNED BY public.test_table.id;
ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);
ALTER TABLE ONLY public.test ALTER COLUMN id SET DEFAULT nextval('public.test_id_seq'::regclass);
ALTER TABLE ONLY public.test_table ALTER COLUMN id SET DEFAULT nextval('public.test_table_id_seq'::regclass);
ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.test2
    ADD CONSTRAINT test2_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.test
    ADD CONSTRAINT test_pkey PRIMARY KEY (id);
ALTER TABLE ONLY public.test_table
    ADD CONSTRAINT test_table_pkey PRIMARY KEY (id);
