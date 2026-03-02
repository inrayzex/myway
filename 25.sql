--
-- PostgreSQL database dump
--

\restrict mQJKylTohitpnEgqhsAygwrGa2OQQJT7WWJZr0SgQkhMgzIcdhjWdyQV7OeGm9e

-- Dumped from database version 13.23
-- Dumped by pg_dump version 13.23

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
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: articles; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.articles (
    id uuid NOT NULL,
    title character varying(255) NOT NULL,
    content text NOT NULL,
    excerpt character varying(255),
    category character varying(255) NOT NULL,
    author character varying(255),
    read_time integer,
    difficulty character varying(255),
    image_url character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.articles OWNER TO put_user;

--
-- Name: cache; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache OWNER TO put_user;

--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


ALTER TABLE public.cache_locks OWNER TO put_user;

--
-- Name: club_members; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.club_members (
    club_id uuid NOT NULL,
    user_id uuid NOT NULL,
    role character varying(20) DEFAULT 'member'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.club_members OWNER TO put_user;

--
-- Name: club_messages; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.club_messages (
    id uuid NOT NULL,
    club_id uuid NOT NULL,
    user_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.club_messages OWNER TO put_user;

--
-- Name: club_post_comments; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.club_post_comments (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    club_post_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.club_post_comments OWNER TO put_user;

--
-- Name: club_post_likes; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.club_post_likes (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    club_post_id uuid NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.club_post_likes OWNER TO put_user;

--
-- Name: club_posts; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.club_posts (
    id uuid NOT NULL,
    club_id uuid NOT NULL,
    user_id uuid NOT NULL,
    content text NOT NULL,
    photo_url character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.club_posts OWNER TO put_user;

--
-- Name: clubs; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.clubs (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    description text,
    cover_url character varying(255),
    creator_id uuid NOT NULL,
    type character varying(20) DEFAULT 'open'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.clubs OWNER TO put_user;

--
-- Name: comments; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.comments (
    id uuid NOT NULL,
    post_id uuid NOT NULL,
    user_id uuid NOT NULL,
    content text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.comments OWNER TO put_user;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.failed_jobs OWNER TO put_user;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: put_user
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO put_user;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: put_user
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.follows (
    follower_id uuid NOT NULL,
    following_id uuid NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.follows OWNER TO put_user;

--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


ALTER TABLE public.job_batches OWNER TO put_user;

--
-- Name: jobs; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


ALTER TABLE public.jobs OWNER TO put_user;

--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: put_user
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.jobs_id_seq OWNER TO put_user;

--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: put_user
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO put_user;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: put_user
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO put_user;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: put_user
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO put_user;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id uuid NOT NULL,
    name text NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO put_user;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: put_user
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO put_user;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: put_user
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: post_likes; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.post_likes (
    user_id uuid NOT NULL,
    post_id uuid NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.post_likes OWNER TO put_user;

--
-- Name: posts; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.posts (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    content text NOT NULL,
    photo_url character varying(255),
    privacy character varying(20) DEFAULT 'friends'::character varying NOT NULL,
    club_id uuid,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    is_pinned boolean DEFAULT false NOT NULL
);


ALTER TABLE public.posts OWNER TO put_user;

--
-- Name: practice_logs; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.practice_logs (
    id uuid NOT NULL,
    practice_id uuid NOT NULL,
    user_id uuid NOT NULL,
    completed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    value integer,
    note text,
    photo_url character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.practice_logs OWNER TO put_user;

--
-- Name: practices; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.practices (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(50) NOT NULL,
    goal_value integer,
    goal_unit character varying(20),
    goal_days integer,
    period_type character varying(20) DEFAULT 'daily'::character varying NOT NULL,
    days_of_week json,
    reminder_time time(0) without time zone,
    reminder_channels json,
    privacy character varying(20) DEFAULT 'private'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    completed_at timestamp(0) without time zone,
    is_binary boolean DEFAULT false NOT NULL
);


ALTER TABLE public.practices OWNER TO put_user;

--
-- Name: reminders; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.reminders (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    practice_id uuid NOT NULL,
    channel character varying(255) NOT NULL,
    scheduled_at timestamp(0) without time zone NOT NULL,
    sent_at timestamp(0) without time zone,
    is_sent boolean DEFAULT false NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.reminders OWNER TO put_user;

--
-- Name: sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id uuid,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO postgres;

--
-- Name: users; Type: TABLE; Schema: public; Owner: put_user
--

CREATE TABLE public.users (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    username character varying(255),
    status character varying(255) DEFAULT 'seeker'::character varying,
    quote text,
    trackers_privacy character varying(255) DEFAULT 'друзья'::character varying NOT NULL,
    posts_privacy character varying(255) DEFAULT 'все'::character varying NOT NULL,
    avatar_url character varying(255)
);


ALTER TABLE public.users OWNER TO put_user;

--
-- Name: COLUMN users.trackers_privacy; Type: COMMENT; Schema: public; Owner: put_user
--

COMMENT ON COLUMN public.users.trackers_privacy IS 'только я, друзья, все';


--
-- Name: COLUMN users.posts_privacy; Type: COMMENT; Schema: public; Owner: put_user
--

COMMENT ON COLUMN public.users.posts_privacy IS 'только я, друзья, все';


--
-- Name: COLUMN users.avatar_url; Type: COMMENT; Schema: public; Owner: put_user
--

COMMENT ON COLUMN public.users.avatar_url IS 'путь к файлу аватара';


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Data for Name: articles; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.articles (id, title, content, excerpt, category, author, read_time, difficulty, image_url, created_at, updated_at) FROM stdin;
019c702d-8a35-722c-b688-0cc593573022	Медитация	<p>В этой статье будет рассмотрена практика медитации.</p>	\N	meditation	\N	\N	\N	articles/01KJA8T129QM8B61XH6Z4SE5E6.jpg	2026-02-18 09:55:58	2026-02-25 11:26:35
019c94a1-f123-70b6-bccc-ace5fc1f4ef4	Тест	<p>укеукпукп Мухаморы</p>	\N	philosophy	\N	\N	легкая	articles/01KJAA3W92768HRHFQ4QB83YHF.jpg	2026-02-25 11:49:26	2026-02-25 11:49:26
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: club_members; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.club_members (club_id, user_id, role, created_at, updated_at) FROM stdin;
019c8729-477a-7027-9eaf-aaf25837b685	019c6b35-531b-7003-9e4f-ff830b9a39c9	creator	2026-02-22 21:02:35	2026-02-22 21:02:35
019c8ac3-e6eb-7307-af3c-e00c84aa0d8b	019c6b35-531b-7003-9e4f-ff830b9a39c9	creator	2026-02-23 13:50:20	2026-02-23 13:50:20
019c8ac3-e6eb-7307-af3c-e00c84aa0d8b	019c7bc6-5b50-707f-b348-6be7ae146522	member	2026-02-23 20:11:51	2026-02-23 20:11:51
019c8729-477a-7027-9eaf-aaf25837b685	019c7bc6-5b50-707f-b348-6be7ae146522	member	2026-02-23 20:13:16	2026-02-23 20:13:16
019c946e-524e-72b9-9744-1f304567bc7b	019c6b35-531b-7003-9e4f-ff830b9a39c9	creator	2026-02-25 10:53:03	2026-02-25 10:53:03
\.


--
-- Data for Name: club_messages; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.club_messages (id, club_id, user_id, content, created_at, updated_at) FROM stdin;
019c8bd6-f973-70ca-b522-7f10439ee9d1	019c8ac3-e6eb-7307-af3c-e00c84aa0d8b	019c6b35-531b-7003-9e4f-ff830b9a39c9	что за чат такой тут?	2026-02-23 18:50:47	2026-02-23 18:50:47
019c8bd7-2202-7110-9f85-6155ed17e940	019c8ac3-e6eb-7307-af3c-e00c84aa0d8b	019c6b35-531b-7003-9e4f-ff830b9a39c9	Работает что ли?	2026-02-23 18:50:57	2026-02-23 18:50:57
019c8bd7-5bca-72f7-a790-6c1b44416547	019c8ac3-e6eb-7307-af3c-e00c84aa0d8b	019c6b35-531b-7003-9e4f-ff830b9a39c9	Катька нука напиши ка что нибудь	2026-02-23 18:51:12	2026-02-23 18:51:12
019c8bd7-74fb-7276-bc23-ff29112fc0da	019c8ac3-e6eb-7307-af3c-e00c84aa0d8b	019c6b35-531b-7003-9e4f-ff830b9a39c9	:)))))	2026-02-23 18:51:19	2026-02-23 18:51:19
019c8c23-d98a-718d-bc8d-0b763e766551	019c8ac3-e6eb-7307-af3c-e00c84aa0d8b	019c7bc6-5b50-707f-b348-6be7ae146522	Мик Мик мик	2026-02-23 20:14:45	2026-02-23 20:14:45
\.


--
-- Data for Name: club_post_comments; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.club_post_comments (id, user_id, club_post_id, content, created_at, updated_at) FROM stdin;
019c8bd0-1a0a-7123-8a2f-a2a9cd8b981c	019c6b35-531b-7003-9e4f-ff830b9a39c9	019c8bc1-a84c-73ec-8d3b-73d4056feb15	Какой хороший грибочек))))	2026-02-23 18:43:17	2026-02-23 18:43:17
019c8c21-6388-72b4-829a-44729decbdab	019c7bc6-5b50-707f-b348-6be7ae146522	019c8bc1-a84c-73ec-8d3b-73d4056feb15	💕	2026-02-23 20:12:04	2026-02-23 20:12:04
019c8c24-a4d3-714f-8a6e-c8069c2375b3	019c7bc6-5b50-707f-b348-6be7ae146522	019c8bba-415f-71d2-8b11-21b8ef2ad4f9	Иииии	2026-02-23 20:15:37	2026-02-23 20:15:37
019c9431-a446-7024-84ac-2bb438256e01	019c6b35-531b-7003-9e4f-ff830b9a39c9	019c940a-c7a6-710e-b760-a04b5c4dedfc	Код?	2026-02-25 09:46:47	2026-02-25 09:46:47
019c9431-dd65-73f2-985b-2c584bf0d3b7	019c6b35-531b-7003-9e4f-ff830b9a39c9	019c940a-c7a6-710e-b760-a04b5c4dedfc	аапрапр	2026-02-25 09:47:01	2026-02-25 09:47:01
019c9435-f6f8-739a-a246-d2869c68e0e2	019c6b35-531b-7003-9e4f-ff830b9a39c9	019c9435-9ca4-7185-bf4e-94bbab0b7047	Шикарно)	2026-02-25 09:51:30	2026-02-25 09:51:30
\.


--
-- Data for Name: club_post_likes; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.club_post_likes (id, user_id, club_post_id, created_at, updated_at) FROM stdin;
019c8bcf-eddd-711b-8d96-d2804dd0578b	019c6b35-531b-7003-9e4f-ff830b9a39c9	019c8bc1-a84c-73ec-8d3b-73d4056feb15	2026-02-23 18:43:05	2026-02-23 18:43:05
019c8bd6-934f-7077-be3b-0fa0f19c597e	019c6b35-531b-7003-9e4f-ff830b9a39c9	019c8bba-415f-71d2-8b11-21b8ef2ad4f9	2026-02-23 18:50:21	2026-02-23 18:50:21
019c8c21-7383-7363-af1d-5485398ae76b	019c7bc6-5b50-707f-b348-6be7ae146522	019c8bba-415f-71d2-8b11-21b8ef2ad4f9	2026-02-23 20:12:08	2026-02-23 20:12:08
019c8c21-c33d-701c-a101-685e7a16aac5	019c7bc6-5b50-707f-b348-6be7ae146522	019c8bc1-a84c-73ec-8d3b-73d4056feb15	2026-02-23 20:12:28	2026-02-23 20:12:28
\.


--
-- Data for Name: club_posts; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.club_posts (id, club_id, user_id, content, photo_url, created_at, updated_at) FROM stdin;
019c8b2d-c99d-7105-be2e-858fa97e9312	019c8729-477a-7027-9eaf-aaf25837b685	019c6b35-531b-7003-9e4f-ff830b9a39c9	dgsdgsdg	\N	2026-02-23 15:45:59	2026-02-23 15:45:59
019c8bba-415f-71d2-8b11-21b8ef2ad4f9	019c8ac3-e6eb-7307-af3c-e00c84aa0d8b	019c6b35-531b-7003-9e4f-ff830b9a39c9	hui	club_posts/1jxjeAqZbTceQCkatzS8FeK5zPqDYhp3eLQ4LVVs.jpg	2026-02-23 18:19:25	2026-02-23 18:19:25
019c8bc1-a84c-73ec-8d3b-73d4056feb15	019c8ac3-e6eb-7307-af3c-e00c84aa0d8b	019c6b35-531b-7003-9e4f-ff830b9a39c9	ваивава	club_posts/3b0uSGED4QB0XFC85oncLEZd7MfAuftNPJfeonza.jpg	2026-02-23 18:27:30	2026-02-23 18:27:30
019c940a-c7a6-710e-b760-a04b5c4dedfc	019c8729-477a-7027-9eaf-aaf25837b685	019c6b35-531b-7003-9e4f-ff830b9a39c9	Новая запиииська)))	club_posts/CfEIqB7IT9kTOGSSnk3rttAMMjMhyLFoemge7PW2.jpg	2026-02-25 09:04:20	2026-02-25 09:04:20
019c9435-9ca4-7185-bf4e-94bbab0b7047	019c8729-477a-7027-9eaf-aaf25837b685	019c6b35-531b-7003-9e4f-ff830b9a39c9	vertiacal	club_posts/UmvdmgXwDFss5D77tAFdJNoDMg9aLDniVKpuzT5o.jpg	2026-02-25 09:51:07	2026-02-25 09:51:07
019c943d-be5e-7146-9111-d70249766542	019c8729-477a-7027-9eaf-aaf25837b685	019c6b35-531b-7003-9e4f-ff830b9a39c9	wewedde	club_posts/Y5c0nLVzLEbCXQOvSjL7XyHE90Ewaz4mvB5TAXZS.jpg	2026-02-25 10:00:00	2026-02-25 10:00:00
\.


--
-- Data for Name: clubs; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.clubs (id, name, description, cover_url, creator_id, type, created_at, updated_at) FROM stdin;
019c8729-477a-7027-9eaf-aaf25837b685	567567	ghghfh	club_covers/DKZsxykH2K4c4LGGocxHxFJuZiXfv5Ne6WtDtfIa.jpg	019c6b35-531b-7003-9e4f-ff830b9a39c9	open	2026-02-22 21:02:35	2026-02-22 21:02:35
019c8ac3-e6eb-7307-af3c-e00c84aa0d8b	Клуб любителей мухоморов	Катькин клуб для тех, кто любит поболтать про мухоморы и сумки с мухоморами :)	club_covers/oZjEjosnHLwD0KVZYHvaPyBN9fTYfS3Dsa0Gs4wO.jpg	019c6b35-531b-7003-9e4f-ff830b9a39c9	open	2026-02-23 13:50:20	2026-02-23 13:50:20
019c946e-524e-72b9-9744-1f304567bc7b	New super Club	Самый крутой клуб в мире	club_covers/wUtaf2KwRRzPsSKf7TPXyxiyAFFz0DyBCBBup7E4.jpg	019c6b35-531b-7003-9e4f-ff830b9a39c9	open	2026-02-25 10:53:03	2026-02-25 10:53:03
\.


--
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.comments (id, post_id, user_id, content, created_at, updated_at) FROM stdin;
019c7aac-1074-723b-8d46-9d0d645b7332	019c772f-d71e-70f4-b7af-bdda116c0eed	019c6b35-531b-7003-9e4f-ff830b9a39c9	4444	2026-02-20 10:50:22	2026-02-20 10:50:22
019c7aaf-2bfe-7021-9440-b0cad68891ff	019c772f-d71e-70f4-b7af-bdda116c0eed	019c6b35-531b-7003-9e4f-ff830b9a39c9	чувак, ты кто?))	2026-02-20 10:53:46	2026-02-20 10:53:46
019c7ab1-f5be-721a-a119-cee03bd99f9e	019c772f-d71e-70f4-b7af-bdda116c0eed	019c6b35-531b-7003-9e4f-ff830b9a39c9	ты что не отвечаешь то?)))	2026-02-20 10:56:49	2026-02-20 10:56:49
019c7abc-33ab-71da-be6d-d948abe61f64	019c772f-d71e-70f4-b7af-bdda116c0eed	019c6b35-531b-7003-9e4f-ff830b9a39c9	yo yo yo	2026-02-20 11:08:00	2026-02-20 11:08:00
019c7abd-a450-72b1-85e2-6c348bd7d78a	019c772f-d71e-70f4-b7af-bdda116c0eed	019c6b35-531b-7003-9e4f-ff830b9a39c9	555	2026-02-20 11:09:34	2026-02-20 11:09:34
019c7bca-d992-7370-903a-67325e46bbdb	019c7bca-84b3-70a3-9e2f-ca43721de4b4	019c7bc6-5b50-707f-b348-6be7ae146522	Уууу	2026-02-20 16:03:37	2026-02-20 16:03:37
019c7bcb-0b7d-7238-b8d8-f99937eb9169	019c7bca-1170-7372-883e-33093f1dc786	019c7bc6-5b50-707f-b348-6be7ae146522	😀	2026-02-20 16:03:50	2026-02-20 16:03:50
019c7bcd-6e68-7390-b512-48b66fe79bd1	019c772f-d71e-70f4-b7af-bdda116c0eed	019c7bc6-5b50-707f-b348-6be7ae146522	Ннннн	2026-02-20 16:06:26	2026-02-20 16:06:26
019c862b-5902-7029-8bc1-364494349487	019c7bca-84b3-70a3-9e2f-ca43721de4b4	019c6b35-531b-7003-9e4f-ff830b9a39c9	Заичка привет)))	2026-02-22 16:25:13	2026-02-22 16:25:13
019c8701-2531-700b-abb9-fa26a8ccd8ff	019c7bca-84b3-70a3-9e2f-ca43721de4b4	019c6b35-531b-7003-9e4f-ff830b9a39c9	Елки палки)	2026-02-22 20:18:45	2026-02-22 20:18:45
019c8c23-537c-7364-b560-4f0c54fdd361	019c7bd7-2bc4-739e-96ba-0dafa2e0d281	019c7bc6-5b50-707f-b348-6be7ae146522	👀	2026-02-23 20:14:11	2026-02-23 20:14:11
019c8f85-e08b-707b-a507-c6e19e6ea20f	019c8f81-527a-7084-b25a-ae1fa421f321	019c6b35-531b-7003-9e4f-ff830b9a39c9	ergergerg	2026-02-24 12:00:41	2026-02-24 12:00:41
019c90f2-ebe3-7041-9db0-253b4929f6f5	019c8f7d-90c2-701e-aa9e-8e3b94f6cd6c	019c6b35-531b-7003-9e4f-ff830b9a39c9	dfwefwef	2026-02-24 18:39:25	2026-02-24 18:39:25
019c90f4-2d98-72dc-a01a-57babf6f25a1	019c8f81-527a-7084-b25a-ae1fa421f321	019c6b35-531b-7003-9e4f-ff830b9a39c9	45345	2026-02-24 18:40:47	2026-02-24 18:40:47
019c90f4-a699-7274-9968-51612771a662	019c7bd7-2bc4-739e-96ba-0dafa2e0d281	019c6b35-531b-7003-9e4f-ff830b9a39c9	Кто здесь?)	2026-02-24 18:41:18	2026-02-24 18:41:18
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: follows; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.follows (follower_id, following_id, created_at, updated_at) FROM stdin;
019c7bc6-5b50-707f-b348-6be7ae146522	10086b72-ab27-4f2b-9017-01f85c5c2f97	2026-02-20 16:06:07	2026-02-20 16:06:07
019c7bc6-5b50-707f-b348-6be7ae146522	5fdaf68c-2fd8-443b-9a4b-60ef56e28e2b	2026-02-20 16:06:09	2026-02-20 16:06:09
019c7bc6-5b50-707f-b348-6be7ae146522	0ee9aa3f-f2ad-4805-bd43-14f334689389	2026-02-20 16:06:10	2026-02-20 16:06:10
019c6b35-531b-7003-9e4f-ff830b9a39c9	a7b057c5-d8c9-4b09-9e40-fbc71d31be4e	2026-02-21 11:29:59	2026-02-21 11:29:59
019c6b35-531b-7003-9e4f-ff830b9a39c9	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-22 18:02:06	2026-02-22 18:02:06
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.migrations (id, migration, batch) FROM stdin;
36	0001_01_01_000000_create_users_table	1
37	0001_01_01_000001_create_cache_table	1
38	0001_01_01_000002_create_jobs_table	1
39	2026_02_17_064723_create_practices_table	1
40	2026_02_17_065203_create_practice_logs_table	1
41	2026_02_17_070800_create_clubs_table	1
42	2026_02_17_070915_create_posts_table	1
43	2026_02_17_071132_create_follows_table	1
44	2026_02_17_071223_create_post_likes_table	1
45	2026_02_17_071307_create_comments_table	1
46	2026_02_17_071449_create_club_members_table	1
47	2026_02_17_071616_create_club_posts_table	1
48	2026_02_17_074625_add_profile_fields_to_users_table	1
49	2026_02_17_092920_create_personal_access_tokens_table	1
51	2026_02_17_200315_create_articles_table	2
52	2026_02_19_060926_add_completed_at_to_practices_table	3
53	2026_02_19_082936_add_profile_fields_to_users_table	4
54	2026_02_19_085423_add_privacy_fields_to_users_table	5
55	2026_02_19_113828_add_is_pinned_to_posts_table	6
56	2026_02_20_115455_create_club_messages_table	7
57	2026_02_22_103730_add_is_binary_to_practices_table	8
58	2026_02_22_105241_add_is_binary_to_practices_table	9
59	2026_02_23_171646_create_club_post_likes_table	10
60	2026_02_23_172246_create_club_post_comments_table	11
61	2026_02_23_191418_create_reminders_table	12
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
11	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	ce03264a8a51e29eecec3a83bbbe514982413072690eea7bb086260cf8fd7288	["*"]	2026-02-18 10:23:42	\N	2026-02-18 10:23:41	2026-02-18 10:23:42
1	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	ba79c119161676b2983821c92caf03c62eb9f99b5fe72a1aefa2ae948f8feb73	["*"]	2026-02-17 10:51:06	\N	2026-02-17 10:46:41	2026-02-17 10:51:06
2	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	12b9c0e8b8388ad3f9d61dd2fe7d6a8473b3d90f526f29e64e4d07930805c57c	["*"]	2026-02-17 10:56:58	\N	2026-02-17 10:51:21	2026-02-17 10:56:58
67	App\\Models\\User	019c7ba3-dcda-73a9-b873-90bbc8c629df	auth_token	dd1a301484c26fd2ac11b75cea70b9c63613e8788eda2d1f968390d0fda75836	["*"]	2026-02-20 15:21:02	\N	2026-02-20 15:21:02	2026-02-20 15:21:02
3	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	5021fb4b6616f382c675a43137e7c8c4ee83970c8dec5db428ff637e5889c085	["*"]	2026-02-17 10:59:17	\N	2026-02-17 10:57:01	2026-02-17 10:59:17
4	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	e9bdcd8d4f1d845106c1eeeba1e1b8b2afbc86c908176066fb1a05daed6d0380	["*"]	2026-02-17 10:59:23	\N	2026-02-17 10:59:23	2026-02-17 10:59:23
6	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	feacf398c034caebbffb46d7a5b2a7fd67e7cbb2d0a89a65fea0c30affcf5956	["*"]	2026-02-19 12:42:44	\N	2026-02-17 13:37:19	2026-02-19 12:42:44
14	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	c8b64a230a92192173633089e3992f8cd207e762d730f1729973dcfd7ad68fe1	["*"]	2026-02-18 11:09:59	\N	2026-02-18 10:47:48	2026-02-18 11:09:59
12	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	740b0a92e60d2e1f73d5faf4ddc8cdf8c3e07817e683e21aa7d4ac9613041243	["*"]	2026-02-18 10:34:57	\N	2026-02-18 10:30:27	2026-02-18 10:34:57
73	App\\Models\\User	019c7bc6-5b50-707f-b348-6be7ae146522	auth_token	df5b32f2d1ecc5f4e0e151da23850272fabdb5f2d84c2e970de917f644cdb780	["*"]	2026-02-24 19:25:27	\N	2026-02-20 15:58:43	2026-02-24 19:25:27
5	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	65fd966cfd115e45b75a140636266327205fedf2231d67db920a53a7a1a34ee9	["*"]	2026-02-18 07:08:41	\N	2026-02-17 11:53:34	2026-02-18 07:08:41
27	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	d71a1c029e4520c34cc42a14e101a175add8467cd2b83134a35109acbccca0c1	["*"]	2026-02-19 17:49:36	\N	2026-02-19 12:46:23	2026-02-19 17:49:36
16	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	c54175649b721197d074348586d4dcb8af1ab45522b84801243474fe23779cae	["*"]	2026-02-18 17:49:07	\N	2026-02-18 13:37:46	2026-02-18 17:49:07
19	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	c0ba4619da86bf63ef2c5b4e952405b90651f81e5f5dd528640f95c2ba2d8450	["*"]	2026-02-19 10:01:31	\N	2026-02-18 17:50:16	2026-02-19 10:01:31
17	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	1ff6dadf0734a4ddbd8ffa43d9e6079f499be9ac10768d4331dfcba04d28dddd	["*"]	2026-02-18 14:03:32	\N	2026-02-18 14:01:40	2026-02-18 14:03:32
25	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	cfae2c0673d259e9a77d86d4763aa10bdda544a76274ee798d7e585f095c59bb	["*"]	2026-02-19 12:46:19	\N	2026-02-19 12:42:29	2026-02-19 12:46:19
15	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	308ddcbe7fc08c33b2363039aabcdd120b90bb23769679809d837104ad730b46	["*"]	2026-02-18 13:37:35	\N	2026-02-18 11:13:32	2026-02-18 13:37:35
8	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	6ba8698d3829c372130d1951fe0a8a4d54d9b15cae84de591be058c6173e27bd	["*"]	2026-02-18 07:56:27	\N	2026-02-18 07:26:37	2026-02-18 07:56:27
7	App\\Models\\User	0ee9aa3f-f2ad-4805-bd43-14f334689389	auth_token	2a62d8678fa68aa63eea25b9b7967569fa8c35932fc4c618b15f81524c32aaea	["*"]	2026-02-18 07:26:33	\N	2026-02-18 07:11:56	2026-02-18 07:26:33
9	App\\Models\\User	0ee9aa3f-f2ad-4805-bd43-14f334689389	auth_token	d2e42fedf783c8a9f2d843de68803680999c0fbdca50065eef46f8b2e2491a06	["*"]	2026-02-18 07:57:38	\N	2026-02-18 07:57:10	2026-02-18 07:57:38
13	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	26526f78351c98d2afec73c58802daf8b6f8e7cdd7666efe48dd5760804c46b7	["*"]	2026-02-18 10:47:23	\N	2026-02-18 10:41:15	2026-02-18 10:47:23
22	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	a8c6bf867ac045d75be65f133f07d7b2bd5872b2ade84a5656cf971c03f398f6	["*"]	2026-02-19 12:41:43	\N	2026-02-19 12:36:30	2026-02-19 12:41:43
10	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	86adf1a5929fe1d96b1488af3be88399f2ae885a7ef3959325c40a9433e1f4d4	["*"]	2026-02-18 09:56:22	\N	2026-02-18 07:58:10	2026-02-18 09:56:22
68	App\\Models\\User	019c7bae-0966-7150-9095-5baf26f7f11d	auth_token	6ade3a11e422e3f7ba91319359fdb172d6de4aa30a8badbb97cb49cf64a2729a	["*"]	2026-02-20 15:32:09	\N	2026-02-20 15:32:09	2026-02-20 15:32:09
23	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	0fe3dc8f330fe2206752b83066ec6910fc4bc364916a6fbe2a5a213a4627d232	["*"]	2026-02-19 12:41:56	\N	2026-02-19 12:41:53	2026-02-19 12:41:56
69	App\\Models\\User	019c7bb5-f225-7227-9326-909093490a4e	auth_token	450cd7845e809883239794edcb4d8857af7c06e96d9477936646fa045aaff0d9	["*"]	\N	\N	2026-02-20 15:40:47	2026-02-20 15:40:47
28	App\\Models\\User	10086b72-ab27-4f2b-9017-01f85c5c2f97	auth_token	7c01f7cc38a344933435689176ccd38fc1f641f76fad7716f36d548bfcb70cd5	["*"]	2026-02-19 17:50:30	\N	2026-02-19 17:49:45	2026-02-19 17:50:30
24	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	fbac89a7cb9777467c60ef6288caaf3194fc1ab17b22537a06e72a87d019f251	["*"]	2026-02-19 12:42:23	\N	2026-02-19 12:42:00	2026-02-19 12:42:23
20	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	6dcec99d8da390d0e3f0ab74c913913aecbdd42d1ed5fb3462c61d7064b80957	["*"]	2026-02-20 15:57:03	\N	2026-02-18 19:09:25	2026-02-20 15:57:03
21	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	92d3dc737d1f94a3142a459bc1feb0ec82e1ee388e17f8b1537cadfae3abecee	["*"]	2026-02-19 12:30:12	\N	2026-02-19 10:01:40	2026-02-19 12:30:12
33	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	0795461780254c3c9f85a378fc48daa6f7252273f534ad96f8809f47cc89efb5	["*"]	2026-02-20 14:25:57	\N	2026-02-19 18:36:42	2026-02-20 14:25:57
29	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	2fd428f3f4412204269b3d387ac13b241fa86dc5221c5419c79697b364cd5965	["*"]	2026-02-19 17:51:52	\N	2026-02-19 17:50:35	2026-02-19 17:51:52
31	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	b987dbe4ebe9c355bddddbecd7d6d8a05f19f8a31387d37c84d5eb4889d15b37	["*"]	2026-02-19 18:34:22	\N	2026-02-19 17:52:26	2026-02-19 18:34:22
30	App\\Models\\User	10086b72-ab27-4f2b-9017-01f85c5c2f97	auth_token	167ee591d9c9e56da530015e12c51e6e5374829f3c2baed4b5f3b2805e77ee2d	["*"]	2026-02-19 17:52:23	\N	2026-02-19 17:52:17	2026-02-19 17:52:23
26	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	206c50c8fcf91e3d3a2514dc5ff15e6cf57efb1d728c1614ebabf83a5e32b2b4	["*"]	2026-02-25 13:57:10	\N	2026-02-19 12:42:55	2026-02-25 13:57:10
32	App\\Models\\User	6a57d53f-ea1b-4908-bc72-838bd8a540b1	auth_token	e023cea2d0efefcc7192cee02b0c666b2e664f891b99fe273d077a785bc29e42	["*"]	2026-02-19 18:36:09	\N	2026-02-19 18:34:50	2026-02-19 18:36:09
66	App\\Models\\User	019c7b9f-a3b0-733f-8d53-62cc0378e023	auth_token	cfbc9271d9bd3aeaded34661a99b1bbe0fc433ff3dcd3ff63557da5c9a754c8f	["*"]	\N	\N	2026-02-20 15:16:25	2026-02-20 15:16:25
70	App\\Models\\User	019c7bb8-f379-70d5-b5ec-83935ad32bee	auth_token	d677515e633f1cb8642e8c91bce58d238db66793ecf5e19f10cc7ba2cc986a34	["*"]	2026-02-20 15:44:04	\N	2026-02-20 15:44:04	2026-02-20 15:44:04
71	App\\Models\\User	019c7bb9-d0b2-717c-a0eb-9d89e58eb903	auth_token	e0b0125138b5dd820bb487387537f1f8c4effb74f180a7d60a4e2d20fbf20adf	["*"]	2026-02-20 15:45:01	\N	2026-02-20 15:45:01	2026-02-20 15:45:01
72	App\\Models\\User	019c7bc3-6bba-719e-9e1f-9adb694e649d	auth_token	5ac8d22790707edf823f3ee7d986281484b0be39cf8a8e61f931ccda1462c7c2	["*"]	2026-02-20 15:55:30	\N	2026-02-20 15:55:30	2026-02-20 15:55:30
18	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	f616d958c72e7d5ce4f014a1901fa350cea3d5fc88c38791e558c259de6fa44b	["*"]	2026-02-20 21:36:40	\N	2026-02-18 14:03:46	2026-02-20 21:36:40
78	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	28cc84d0099b4b0dbd1ea05e905d73cd15d879b6438dba399153d1bb70ed12c8	["*"]	2026-02-21 09:37:42	\N	2026-02-20 20:20:43	2026-02-21 09:37:42
76	App\\Models\\User	019c7be6-0801-7340-a3fc-13437eea3fd5	auth_token	220dd60a647b7e50f69f3501d9cc19a1d626f6e0da0b8b86df87a20985778431	["*"]	2026-02-20 17:02:58	\N	2026-02-20 16:33:18	2026-02-20 17:02:58
74	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	bc6f92f0766f6bbe2f8a225d0757ebfeb570047b40a5fc14aef24ce4ca61700f	["*"]	2026-02-20 16:18:02	\N	2026-02-20 16:04:37	2026-02-20 16:18:02
79	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	3e4cfa512735964413d1d1736223b9fa68a2068f18248359d677df3a4e919b45	["*"]	2026-02-22 16:29:47	\N	2026-02-20 21:36:53	2026-02-22 16:29:47
81	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	8c6b28e37ae26599db1b98a80b6c4699a17839e0fbc4c904c82870896118d5e0	["*"]	2026-02-21 11:48:03	\N	2026-02-21 10:49:06	2026-02-21 11:48:03
75	App\\Models\\User	019c7bd9-415f-7256-b01f-3f0c3dbcdbca	auth_token	723b52810a8a1ed6bd06eb6c88d7bbcc834452590ab555ee86b6acd1aca8fe74	["*"]	2026-02-20 16:32:43	\N	2026-02-20 16:19:21	2026-02-20 16:32:43
77	App\\Models\\User	019c7c01-a6f6-70eb-8595-dca59ae83a7e	auth_token	380fd2e4199efe49b373d74b1810272daf423eed25822ff3464cf9f444cbff40	["*"]	2026-02-20 20:20:34	\N	2026-02-20 17:03:29	2026-02-20 20:20:34
82	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	5947c0c9e36da9bd1188a6139373baa3970d30cb31a9df3e8c28ee42fb71d94a	["*"]	2026-02-21 12:29:27	\N	2026-02-21 11:48:11	2026-02-21 12:29:27
80	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	b7037432715cd1664dd13d561017fb3dace40e278f189dd7d4b7c158ac848cf4	["*"]	2026-02-21 10:49:02	\N	2026-02-21 09:38:10	2026-02-21 10:49:02
83	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	a555459c52df2168e9b7220d0cf97ac6bc89509b3e598b650614a68df1d543e7	["*"]	2026-02-21 12:57:26	\N	2026-02-21 12:29:53	2026-02-21 12:57:26
85	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	59113b0316b31780a65065654bd798b69c2e2ccee2c0e864bf8aa1445e33d4a6	["*"]	2026-02-25 14:03:53	\N	2026-02-22 09:38:47	2026-02-25 14:03:53
84	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	90e2e3061680026b068b4128f2b55a049c103c3a717b340ab2d5333cc48ea567	["*"]	2026-02-22 09:38:37	\N	2026-02-21 13:05:22	2026-02-22 09:38:37
86	App\\Models\\User	019c6b35-531b-7003-9e4f-ff830b9a39c9	auth_token	9412f0ffcb9f168e81a119b6ad679d180b03ef7bf47556636e1c5e6bfa16c4e7	["*"]	2026-02-24 19:02:55	\N	2026-02-22 16:29:57	2026-02-24 19:02:55
\.


--
-- Data for Name: post_likes; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.post_likes (user_id, post_id, created_at, updated_at) FROM stdin;
10086b72-ab27-4f2b-9017-01f85c5c2f97	019c772f-d71e-70f4-b7af-bdda116c0eed	2026-02-20 10:50:24	2026-02-20 10:50:24
019c7bc6-5b50-707f-b348-6be7ae146522	019c7bca-84b3-70a3-9e2f-ca43721de4b4	2026-02-20 16:03:29	2026-02-20 16:03:29
019c6b35-531b-7003-9e4f-ff830b9a39c9	019c7bca-84b3-70a3-9e2f-ca43721de4b4	2026-02-22 16:25:29	2026-02-22 16:25:29
019c7bc6-5b50-707f-b348-6be7ae146522	019c7bd7-2bc4-739e-96ba-0dafa2e0d281	2026-02-22 20:41:02	2026-02-22 20:41:02
019c6b35-531b-7003-9e4f-ff830b9a39c9	019c7bd7-2bc4-739e-96ba-0dafa2e0d281	2026-02-23 20:10:30	2026-02-23 20:10:30
019c7bc6-5b50-707f-b348-6be7ae146522	019c772f-d71e-70f4-b7af-bdda116c0eed	2026-02-23 20:13:53	2026-02-23 20:13:53
019c7bc6-5b50-707f-b348-6be7ae146522	019c7bca-1170-7372-883e-33093f1dc786	2026-02-23 20:16:30	2026-02-23 20:16:30
019c6b35-531b-7003-9e4f-ff830b9a39c9	019c8f81-527a-7084-b25a-ae1fa421f321	2026-02-24 18:41:02	2026-02-24 18:41:02
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.posts (id, user_id, content, photo_url, privacy, club_id, created_at, updated_at, is_pinned) FROM stdin;
019c7bd7-2bc4-739e-96ba-0dafa2e0d281	019c6b35-531b-7003-9e4f-ff830b9a39c9	Привет Жопочка	posts/azutR1Grt7CIljyjNzx0gfdLiOAPuakHwmXcVFAK.jpg	public	\N	2026-02-20 16:17:04	2026-02-20 16:17:04	f
019c7c09-17a9-71e2-9073-f3e1a892b184	019c7c01-a6f6-70eb-8595-dca59ae83a7e	rgergergergerg	\N	private	\N	2026-02-20 17:11:36	2026-02-20 17:11:36	f
019c7bc9-3503-7094-b243-1cb2eb3e0207	019c7bc6-5b50-707f-b348-6be7ae146522	Порка	posts/FcETm3m39QepQNnSL3REm4KOiQbfKv6sKJHvGCnW.jpg	private	\N	2026-02-20 16:01:49	2026-02-20 16:01:49	f
019c8f7d-90c2-701e-aa9e-8e3b94f6cd6c	019c6b35-531b-7003-9e4f-ff830b9a39c9	1	posts/0jPR94SDKdc1V1T397j5qTFY3TidkhjqsO30Hmnk.jpg	public	\N	2026-02-24 11:51:36	2026-02-24 11:51:36	f
019c7bca-1170-7372-883e-33093f1dc786	019c7bc6-5b50-707f-b348-6be7ae146522	Еще порка	\N	public	\N	2026-02-20 16:02:46	2026-02-20 16:02:46	f
019c8f81-527a-7084-b25a-ae1fa421f321	019c6b35-531b-7003-9e4f-ff830b9a39c9	Облоко хорошо летит	posts/BPsQJRs1SD3PZh8F7Jxz8pALr5uWO9boojvR45OC.jpg	public	\N	2026-02-24 11:55:43	2026-02-24 11:55:43	f
019c772f-d71e-70f4-b7af-bdda116c0eed	6a57d53f-ea1b-4908-bc72-838bd8a540b1	Запись какого то левого чувака	\N	public	\N	2026-02-19 18:35:49	2026-02-19 18:35:49	f
019c7bca-84b3-70a3-9e2f-ca43721de4b4	019c7bc6-5b50-707f-b348-6be7ae146522	Ппп	posts/OyLTEjuF8pTdEVW04CqNS8v1LAxE1RFpm6kYVWTL.jpg	public	\N	2026-02-20 16:03:15	2026-02-20 16:03:15	f
019c90a8-9305-71ba-bada-dfe07065cabc	019c6b35-531b-7003-9e4f-ff830b9a39c9	personal	posts/mvdHYsiSsqeKIQirMMRTYDPHxpI6pbfjrL93sSZv.jpg	private	\N	2026-02-24 17:18:12	2026-02-24 17:18:12	f
\.


--
-- Data for Name: practice_logs; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.practice_logs (id, practice_id, user_id, completed_at, value, note, photo_url, created_at, updated_at) FROM stdin;
019c857a-cd77-70aa-b37e-15c89938875f	019c855c-c7e8-73bf-96e4-c828bfeb6547	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-22 13:12:23	1	\N	\N	2026-02-22 13:12:23	2026-02-22 13:12:23
019c75d0-c426-738f-bace-4ce8acb44fdc	019c75d0-8942-719e-9d2c-4b39d0632a44	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-19 12:12:21	\N	\N	\N	2026-02-19 12:12:21	2026-02-19 12:12:21
019c76b5-f0a8-73c0-be2f-7bc8e9ffc455	019c75fc-552f-7220-99aa-50772abc6c25	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-19 16:22:41	\N	\N	\N	2026-02-19 16:22:41	2026-02-19 16:22:41
019c859e-50d5-7182-a3a3-2aff8ff16d36	019c859e-304c-73bb-ba7f-828893d3f007	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-22 13:51:11	1	\N	\N	2026-02-22 13:51:11	2026-02-22 13:51:11
019c8630-d4e8-721e-94e4-475f2e54ec0c	019c8630-a4f0-705c-9c08-5ed943f67c4f	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-22 16:31:13	1	\N	\N	2026-02-22 16:31:13	2026-02-22 16:31:13
019c8715-4d30-7362-bf32-945d2eb368d5	019c8715-378e-725a-9e77-14cb470c1a67	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-22 20:40:46	1	\N	\N	2026-02-22 20:40:46	2026-02-22 20:40:46
019c899f-9b87-7006-ac4d-1b4773add8d6	019c8176-a049-70fc-9676-c6087df980f4	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-23 08:31:04	5	\N	\N	2026-02-23 08:31:04	2026-02-23 08:31:04
019c899f-c161-7062-a262-5fa72a291657	019c817c-a8de-7328-8d3a-3ff00b5f280b	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-23 08:31:14	1	\N	\N	2026-02-23 08:31:14	2026-02-23 08:31:14
019c7c05-828c-701c-b6e4-8202eaebf60b	019c7c04-8232-7092-9c78-98c5ab9e1cc8	019c7c01-a6f6-70eb-8595-dca59ae83a7e	2026-02-20 17:07:41	\N	\N	\N	2026-02-20 17:07:41	2026-02-20 17:07:41
019c7c05-92b9-70a6-a633-c5339cad27af	019c7c04-ee26-7235-9330-ea2a6c6fa856	019c7c01-a6f6-70eb-8595-dca59ae83a7e	2026-02-20 17:07:45	\N	\N	\N	2026-02-20 17:07:45	2026-02-20 17:07:45
019c899f-e1fc-73b1-bb1a-2f162ead31dc	019c8163-3bfc-70ea-8399-a9f6a947662f	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-23 08:31:22	5	\N	\N	2026-02-23 08:31:22	2026-02-23 08:31:22
019c89a0-0591-73fc-aed1-e4eaa52b090e	019c855c-c7e8-73bf-96e4-c828bfeb6547	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-23 08:31:31	1	\N	\N	2026-02-23 08:31:31	2026-02-23 08:31:31
019c8c25-2588-7387-b452-13f434837968	019c8715-378e-725a-9e77-14cb470c1a67	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-23 20:16:10	1	\N	\N	2026-02-23 20:16:10	2026-02-23 20:16:10
019c8c25-2f02-734a-baf9-fbe4931de2dd	019c8561-6f41-7277-823f-0e5b7dc2b0d1	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-23 20:16:13	1	\N	\N	2026-02-23 20:16:13	2026-02-23 20:16:13
019c8c25-36c3-7016-8aa8-86fdff8259b2	019c8564-212b-70e5-ad9c-7f5307b16e92	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-23 20:16:15	8	\N	\N	2026-02-23 20:16:15	2026-02-23 20:16:15
019c8c25-3c18-705f-83b8-bf58ffb60cb4	019c8565-6b4a-71f3-b8a9-ab8df91ddfcb	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-23 20:16:16	1	\N	\N	2026-02-23 20:16:16	2026-02-23 20:16:16
019c8c25-41b6-7376-900f-f92cabc5268d	019c859e-304c-73bb-ba7f-828893d3f007	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-23 20:16:17	1	\N	\N	2026-02-23 20:16:17	2026-02-23 20:16:17
019c8f0f-2a1c-72d2-bded-f2e0f9fc19fd	019c817c-a8de-7328-8d3a-3ff00b5f280b	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-24 09:51:01	1	\N	\N	2026-02-24 09:51:01	2026-02-24 09:51:01
019c8f0f-31c5-710b-813c-7309a41ce287	019c8163-3bfc-70ea-8399-a9f6a947662f	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-24 09:51:03	5	\N	\N	2026-02-24 09:51:03	2026-02-24 09:51:03
019c8164-65cf-7196-bbbc-c732a159ba18	019c8163-3bfc-70ea-8399-a9f6a947662f	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-21 18:09:26	5	\N	\N	2026-02-21 18:09:26	2026-02-21 18:09:26
019c8f88-a849-70a6-b780-f61186e5c7e6	019c8176-a049-70fc-9676-c6087df980f4	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-24 12:03:43	5	\N	\N	2026-02-24 12:03:43	2026-02-24 12:03:43
019c8177-9228-7339-b803-728127d8fd29	019c8176-a049-70fc-9676-c6087df980f4	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-21 18:30:23	5	\N	\N	2026-02-21 18:30:23	2026-02-21 18:30:23
019c8f88-d8ff-71b6-9c33-88fc5fc35cda	019c8f82-b4b4-71e1-b9fb-dc662acc2517	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-24 12:03:56	28	\N	\N	2026-02-24 12:03:56	2026-02-24 12:03:56
019c8f89-1a9f-727d-980a-b41cdb11eafe	019c855c-c7e8-73bf-96e4-c828bfeb6547	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-24 12:04:13	1	\N	\N	2026-02-24 12:04:13	2026-02-24 12:04:13
019c817c-ddfd-730e-ad4d-9fb174aa6a2a	019c817c-a8de-7328-8d3a-3ff00b5f280b	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-21 18:36:10	1	\N	\N	2026-02-21 18:36:10	2026-02-21 18:36:10
019c8f8a-e4e5-736c-9323-12aa331298f6	019c8f89-8718-71d5-bae1-612af244706f	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-24 12:06:10	1	\N	\N	2026-02-24 12:06:10	2026-02-24 12:06:10
019c84e5-ad1b-7295-9625-2d776da41316	019c8176-a049-70fc-9676-c6087df980f4	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-22 10:29:30	5	\N	\N	2026-02-22 10:29:30	2026-02-22 10:29:30
019c8f8d-c40c-7308-80ae-26dc692045fd	019c8f8d-a6ff-71db-a1ad-10efcdb11a4b	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-24 12:09:18	7	\N	\N	2026-02-24 12:09:18	2026-02-24 12:09:18
019c84e5-e9c1-728a-906c-552b107f0aaa	019c817c-a8de-7328-8d3a-3ff00b5f280b	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-22 10:29:46	1	\N	\N	2026-02-22 10:29:46	2026-02-22 10:29:46
019c84e6-1196-71bb-bcef-c4253602e7fb	019c8163-3bfc-70ea-8399-a9f6a947662f	019c6b35-531b-7003-9e4f-ff830b9a39c9	2026-02-22 10:29:56	5	\N	\N	2026-02-22 10:29:56	2026-02-22 10:29:56
019c8561-90d6-70c5-9128-560d9e4b3730	019c8561-6f41-7277-823f-0e5b7dc2b0d1	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-22 12:44:49	\N	\N	\N	2026-02-22 12:44:49	2026-02-22 12:44:49
019c8564-3095-7117-a6e1-439a0df6a1f8	019c8564-212b-70e5-ad9c-7f5307b16e92	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-22 12:47:41	8	\N	\N	2026-02-22 12:47:41	2026-02-22 12:47:41
019c8565-f918-7293-90c3-605a34f5913f	019c8565-6b4a-71f3-b8a9-ab8df91ddfcb	019c7bc6-5b50-707f-b348-6be7ae146522	2026-02-22 12:49:38	\N	\N	\N	2026-02-22 12:49:38	2026-02-22 12:49:38
\.


--
-- Data for Name: practices; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.practices (id, user_id, name, type, goal_value, goal_unit, goal_days, period_type, days_of_week, reminder_time, reminder_channels, privacy, is_active, created_at, updated_at, completed_at, is_binary) FROM stdin;
019c8176-a049-70fc-9676-c6087df980f4	019c6b35-531b-7003-9e4f-ff830b9a39c9	NewLife	meditation	5	pages	\N	daily	\N	08:00:00	["telegram"]	private	t	2026-02-21 18:29:21	2026-02-21 18:29:21	\N	f
019c8630-a4f0-705c-9c08-5ed943f67c4f	019c6b35-531b-7003-9e4f-ff830b9a39c9	Архив тест	askesa	\N	\N	1	daily	\N	08:00:00	[]	private	t	2026-02-22 16:31:00	2026-02-22 16:31:13	2026-02-22 16:31:13	t
019c8715-378e-725a-9e77-14cb470c1a67	019c7bc6-5b50-707f-b348-6be7ae146522	Без мяса	askesa	\N	\N	90	daily	\N	08:00:00	[]	private	t	2026-02-22 20:40:40	2026-02-22 20:40:40	\N	t
019c75d0-8942-719e-9d2c-4b39d0632a44	019c6b35-531b-7003-9e4f-ff830b9a39c9	Abra cadabra	other	20	minutes	1	daily	\N	08:00:00	[]	private	t	2026-02-19 12:12:06	2026-02-19 12:12:21	2026-02-19 12:12:21	f
019c817c-a8de-7328-8d3a-3ff00b5f280b	019c6b35-531b-7003-9e4f-ff830b9a39c9	Askesa	meditation	1	times	7	daily	\N	08:00:00	["telegram"]	private	t	2026-02-21 18:35:56	2026-02-21 18:35:56	\N	f
019c75fc-552f-7220-99aa-50772abc6c25	019c6b35-531b-7003-9e4f-ff830b9a39c9	утренняя медитация	meditation	20	minutes	1	daily	\N	08:00:00	["telegram"]	private	t	2026-02-19 12:59:57	2026-02-19 16:22:41	2026-02-19 16:22:41	f
019c8f82-b4b4-71e1-b9fb-dc662acc2517	019c6b35-531b-7003-9e4f-ff830b9a39c9	555	yoga	28	times	\N	daily	\N	08:00:00	[]	friends	t	2026-02-24 11:57:13	2026-02-24 11:57:13	\N	f
019c8f89-8718-71d5-bae1-612af244706f	019c6b35-531b-7003-9e4f-ff830b9a39c9	hhh	yoga	\N	minutes	\N	weekly	[1,2,3,5]	08:00:00	[]	private	t	2026-02-24 12:04:40	2026-02-24 12:04:40	\N	f
019c8f8d-a6ff-71db-a1ad-10efcdb11a4b	019c6b35-531b-7003-9e4f-ff830b9a39c9	y	other	7	km	21	daily	\N	08:00:00	[]	friends	t	2026-02-24 12:09:11	2026-02-24 12:09:11	\N	f
019c7be5-4e1d-72e5-9546-b0ec3fda07dd	019c7bd9-415f-7256-b01f-3f0c3dbcdbca	утренняя медитация	meditation	20	minutes	\N	daily	\N	08:00:00	["telegram"]	private	t	2026-02-20 16:32:31	2026-02-20 16:32:31	\N	f
019c7c04-8232-7092-9c78-98c5ab9e1cc8	019c7c01-a6f6-70eb-8595-dca59ae83a7e	практика спорт	sport	20	minutes	\N	daily	\N	08:00:00	["telegram"]	public	t	2026-02-20 17:06:36	2026-02-20 17:06:36	\N	f
019c7c04-ee26-7235-9330-ea2a6c6fa856	019c7c01-a6f6-70eb-8595-dca59ae83a7e	утренняя медитация	meditation	20	minutes	1	daily	\N	08:00:00	["telegram"]	public	t	2026-02-20 17:07:03	2026-02-20 17:07:45	2026-02-20 17:07:45	f
019c7c20-ff7b-73c9-8242-a6a942accfa9	019c7c01-a6f6-70eb-8595-dca59ae83a7e	practice	meditation	20	minutes	21	daily	\N	08:00:00	["telegram"]	public	t	2026-02-20 17:37:43	2026-02-20 17:37:43	\N	f
019c8163-3bfc-70ea-8399-a9f6a947662f	019c6b35-531b-7003-9e4f-ff830b9a39c9	Go go	sport	5	km	\N	daily	\N	08:00:00	["telegram"]	private	t	2026-02-21 18:08:10	2026-02-21 18:08:10	\N	f
019c855c-c7e8-73bf-96e4-c828bfeb6547	019c6b35-531b-7003-9e4f-ff830b9a39c9	Без сахара	askesa	\N	\N	21	daily	\N	08:00:00	["telegram"]	private	t	2026-02-22 12:39:36	2026-02-22 12:39:36	\N	t
019c8561-6f41-7277-823f-0e5b7dc2b0d1	019c7bc6-5b50-707f-b348-6be7ae146522	Без булочек	askesa	\N	\N	30	daily	\N	08:00:00	["push"]	private	t	2026-02-22 12:44:41	2026-02-22 12:44:41	\N	t
019c8564-212b-70e5-ad9c-7f5307b16e92	019c7bc6-5b50-707f-b348-6be7ae146522	Сон	sleep	8	hours	30	daily	\N	08:00:00	["push"]	private	t	2026-02-22 12:47:37	2026-02-22 12:47:37	\N	f
019c8565-6b4a-71f3-b8a9-ab8df91ddfcb	019c7bc6-5b50-707f-b348-6be7ae146522	Без алкоголя	askesa	\N	\N	365	daily	\N	08:00:00	[]	public	t	2026-02-22 12:49:02	2026-02-22 12:49:02	\N	t
019c859e-304c-73bb-ba7f-828893d3f007	019c7bc6-5b50-707f-b348-6be7ae146522	Ходить	other	\N	minutes	\N	daily	\N	08:00:00	[]	private	t	2026-02-22 13:51:02	2026-02-22 13:51:02	\N	f
\.


--
-- Data for Name: reminders; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.reminders (id, user_id, practice_id, channel, scheduled_at, sent_at, is_sent, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
1em7P8q32kNVXUjYbcZCFQ3HnA2JfSAvu8DlfmWf	019c7003-3392-72b9-909c-cf2d58548fe5	192.168.0.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiR2xPVEhYMXN3U0NRY25OUmhkRlA3eWNuYjdsVTVUNkhqT0lzOVNudCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xOTIuMTY4LjAuNTEvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1771592450
Tt46s1KxT33INLcVY4XGYtpqNzk4i4sYcKrJ0w5V	019c7003-3392-72b9-909c-cf2d58548fe5	192.168.0.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiSzdlY2N3Q1BWQURNTlFmUlZHMmEwckpQTDFORjkyS0RENm9kQ0VqYiI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xOTIuMTY4LjAuNTEvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1771695323
THGHxXlsm8I5OywSMltwrHb4bNzyLcsA6YJaYB7E	019c7003-3392-72b9-909c-cf2d58548fe5	192.168.0.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiTzNtcGJrVFl0YkhsUnljWndkcTdrTnZjOWk4NWw5SGJLYk92bHowayI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xOTIuMTY4LjAuNTEvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1771761036
gtevYf6ZKUID0hPjyq8M09H0tvg53yzVKSb6pI5a	019c7003-3392-72b9-909c-cf2d58548fe5	192.168.0.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	YTo2OntzOjY6Il90b2tlbiI7czo0MDoicjU4clZmY0lWblVxcDRJbW02cklHUmM0M2tmMDJIOEZWSVZjQW11ZSI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO3M6MzY6IjAxOWM3MDAzLTMzOTItNzJiOS05MDljLWNmMmQ1ODU0OGZlNSI7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6ImFlNWNkMWM1MDdjMDU2NzAxY2MwNWE2YmJiOTg1YWZkOGZlOTAyMjQzZDhkODY0ZTgyMWZlMzhkNTA2NjM5ZTEiO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjI1OiJodHRwOi8vMTkyLjE2OC4wLjUxL2xvZ2luIjtzOjU6InJvdXRlIjtzOjU6ImxvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo4OiJmaWxhbWVudCI7YTowOnt9fQ==	1771411177
Plf7SYe3kIJsU69S4zBX4HLWYd6u7z4jkJ8Eeccv	019c7003-3392-72b9-909c-cf2d58548fe5	192.168.0.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	YTo2OntzOjY6Il90b2tlbiI7czo0MDoieVJJOEtraTNVTzlLbnFRV29OaHE3alJyV1ZUc0lxVDE1YnE3WHNXQyI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO3M6MzY6IjAxOWM3MDAzLTMzOTItNzJiOS05MDljLWNmMmQ1ODU0OGZlNSI7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6ImFlNWNkMWM1MDdjMDU2NzAxY2MwNWE2YmJiOTg1YWZkOGZlOTAyMjQzZDhkODY0ZTgyMWZlMzhkNTA2NjM5ZTEiO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjc2OiJodHRwOi8vMTkyLjE2OC4wLjUxL2FkbWluL2FydGljbGVzLzAxOWM3NmJlLTY5NDItNzFiNS05NmU2LTVlYzQ5NDdkODcyMi9lZGl0IjtzOjU6InJvdXRlIjtzOjM4OiJmaWxhbWVudC5hZG1pbi5yZXNvdXJjZXMuYXJ0aWNsZXMuZWRpdCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6ODoiZmlsYW1lbnQiO2E6MDp7fX0=	1771518722
zvXvm43kyDVbIuH0EgVupADcpcr9qHPSigaR4yhH	019c7003-3392-72b9-909c-cf2d58548fe5	192.168.0.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoieVpyRTQ4QzZ0Wjdndmc2dGl6a0ZxWjR2Y051dUdWdllqNXdiZUlzMSI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xOTIuMTY4LjAuNTEvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1771785676
Wt7xIJ8fSAg2wCDj3K7wouS56HZgKXMVMMtEhiRv	019c7003-3392-72b9-909c-cf2d58548fe5	192.168.0.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiNzZDUXpBbkg4MjBOZWdvVTZvVlNHekNSczZsS1Y1ZDhwMlJjVGRzNCI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xOTIuMTY4LjAuNTEvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1771867262
9N0mdf9dnNAyn5J9TC8dFVhhOpphC3uXm5U1Yc4l	019c7003-3392-72b9-909c-cf2d58548fe5	192.168.0.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	YTozOntzOjY6Il90b2tlbiI7czo0MDoiZXR3dU90QmY2QVJ0dG1aZ2RualdJR09KTFc2bW9qUnlHc2FLSmpRciI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MjU6Imh0dHA6Ly8xOTIuMTY4LjAuNTEvbG9naW4iO3M6NToicm91dGUiO3M6NToibG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1771876463
kfnKlOW01EP6rYrnqvpGWpAGX2PwhlztxH6hQHrV	019c7003-3392-72b9-909c-cf2d58548fe5	192.168.0.12	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36	YTo2OntzOjY6Il90b2tlbiI7czo0MDoiUDBJZ0xkQVVTVDhMeHFQSkVkMWdBZW1EamczVExoMFp0SG9EVzRwciI7czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO3M6MzY6IjAxOWM3MDAzLTMzOTItNzJiOS05MDljLWNmMmQ1ODU0OGZlNSI7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6ImFlNWNkMWM1MDdjMDU2NzAxY2MwNWE2YmJiOTg1YWZkOGZlOTAyMjQzZDhkODY0ZTgyMWZlMzhkNTA2NjM5ZTEiO3M6OToiX3ByZXZpb3VzIjthOjI6e3M6MzoidXJsIjtzOjM0OiJodHRwOi8vMTkyLjE2OC4wLjUxL2FkbWluL2FydGljbGVzIjtzOjU6InJvdXRlIjtzOjM5OiJmaWxhbWVudC5hZG1pbi5yZXNvdXJjZXMuYXJ0aWNsZXMuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjg6ImZpbGFtZW50IjthOjA6e319	1772022727
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: put_user
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at, username, status, quote, trackers_privacy, posts_privacy, avatar_url) FROM stdin;
10086b72-ab27-4f2b-9017-01f85c5c2f97	Shyann Baumbach DDS	noemi.grant@example.org	2026-02-17 10:37:53	$2y$12$2DtxbhT/jHqX478ksyVOcesmZV8n58ztxb1Y100sjCISaREDoq3xS	wzA6RhnMIy	2026-02-17 10:37:53	2026-02-17 10:37:53	pasquale23	practitioner	Ea ipsam repellat dolores et voluptas.	друзья	все	\N
5fdaf68c-2fd8-443b-9a4b-60ef56e28e2b	Dr. Shyann Daugherty	leffler.price@example.org	2026-02-17 10:37:53	$2y$12$2DtxbhT/jHqX478ksyVOcesmZV8n58ztxb1Y100sjCISaREDoq3xS	PR4WAbxV5l	2026-02-17 10:37:53	2026-02-17 10:37:53	antone13	guide	\N	друзья	все	\N
0ee9aa3f-f2ad-4805-bd43-14f334689389	Miss Hilda Yundt	macejkovic.leonard@example.com	2026-02-17 10:37:53	$2y$12$2DtxbhT/jHqX478ksyVOcesmZV8n58ztxb1Y100sjCISaREDoq3xS	5GGxIvP7oq	2026-02-17 10:37:53	2026-02-17 10:37:53	mwuckert	practitioner	Aperiam cumque ea hic debitis ad corporis.	друзья	все	\N
a7b057c5-d8c9-4b09-9e40-fbc71d31be4e	Ms. Ava Koss IV	gerhold.imelda@example.com	2026-02-17 10:37:53	$2y$12$2DtxbhT/jHqX478ksyVOcesmZV8n58ztxb1Y100sjCISaREDoq3xS	VlybCf8nMk	2026-02-17 10:37:53	2026-02-17 10:37:53	graham12	seeker	Veniam ipsum vitae eaque accusamus dolorem cupiditate.	друзья	все	\N
46f18ff6-0dce-4fe7-af55-50410afe1b5b	Marcel Fritsch	mortimer72@example.org	2026-02-17 10:37:53	$2y$12$2DtxbhT/jHqX478ksyVOcesmZV8n58ztxb1Y100sjCISaREDoq3xS	RDIeAMz3eT	2026-02-17 10:37:53	2026-02-17 10:37:53	zoey85	guide	Delectus occaecati impedit rerum.	друзья	все	\N
a877b1ca-6e36-409c-b847-52c3907525c1	Nicholaus Fadel	dstokes@example.com	2026-02-17 10:37:53	$2y$12$2DtxbhT/jHqX478ksyVOcesmZV8n58ztxb1Y100sjCISaREDoq3xS	zAtfBnyNaM	2026-02-17 10:37:53	2026-02-17 10:37:53	dexter.rau	practitioner	Asperiores quae delectus nulla animi.	друзья	все	\N
7765641d-4e06-4000-b945-4044e21b748c	Elissa Kihn	lwehner@example.com	2026-02-17 10:37:53	$2y$12$2DtxbhT/jHqX478ksyVOcesmZV8n58ztxb1Y100sjCISaREDoq3xS	mOVxRTGB7d	2026-02-17 10:37:53	2026-02-17 10:37:53	muhammad41	seeker	\N	друзья	все	\N
d07f76a0-4556-4e12-9da5-46fad7e0c58c	Fabiola Marvin	turner.kellen@example.net	2026-02-17 10:37:53	$2y$12$2DtxbhT/jHqX478ksyVOcesmZV8n58ztxb1Y100sjCISaREDoq3xS	0z3Z6VjGMW	2026-02-17 10:37:53	2026-02-17 10:37:53	yundt.luther	guide	\N	друзья	все	\N
ad184c0a-1039-46ad-a8e0-318d582a5551	Sallie Willms Jr.	bernier.genesis@example.org	2026-02-17 10:37:53	$2y$12$2DtxbhT/jHqX478ksyVOcesmZV8n58ztxb1Y100sjCISaREDoq3xS	Vy9UX81lmI	2026-02-17 10:37:53	2026-02-17 10:37:53	barney.leuschke	seeker	\N	друзья	все	\N
6a57d53f-ea1b-4908-bc72-838bd8a540b1	Kristian Bartell DVM	mclaughlin.loma@example.net	2026-02-17 10:37:53	$2y$12$2DtxbhT/jHqX478ksyVOcesmZV8n58ztxb1Y100sjCISaREDoq3xS	RMyfmtYXGW	2026-02-17 10:37:53	2026-02-17 10:37:53	lesley78	seeker	Error voluptatem ipsum et vitae nihil molestiae est.	друзья	все	\N
38c91d0f-ecfa-4143-a6ee-2d880ca097c1	Katrine Roberts	kwisozk@example.com	2026-02-17 17:13:14	$2y$12$wZvn/.VYBHYmgpXkZce71OfYMB/sWkFXa0IiuibYLtuaHXIBf5njW	k6b1I5iLWG	2026-02-17 17:13:14	2026-02-17 17:13:14	ubaldo54	seeker	Non quidem illo illum dolorum corporis at.	друзья	все	\N
9a1e9e7a-891c-43c1-8b12-92acda6b3d2d	Alysson Abernathy	catalina20@example.org	2026-02-17 17:13:14	$2y$12$wZvn/.VYBHYmgpXkZce71OfYMB/sWkFXa0IiuibYLtuaHXIBf5njW	3jn59ciaZq	2026-02-17 17:13:14	2026-02-17 17:13:14	lilly.stanton	practitioner	\N	друзья	все	\N
fa6b61b9-9afd-452c-a139-7defb48ea124	Dr. Hazel Frami I	jessika76@example.org	2026-02-17 17:13:14	$2y$12$wZvn/.VYBHYmgpXkZce71OfYMB/sWkFXa0IiuibYLtuaHXIBf5njW	707YUjxSQW	2026-02-17 17:13:14	2026-02-17 17:13:14	stanton.santa	seeker	\N	друзья	все	\N
3eaf8836-8138-4d03-b93a-738aeaf4e4e9	Leo Welch	dbraun@example.com	2026-02-17 17:13:14	$2y$12$wZvn/.VYBHYmgpXkZce71OfYMB/sWkFXa0IiuibYLtuaHXIBf5njW	jrZKyCof6g	2026-02-17 17:13:14	2026-02-17 17:13:14	morar.colton	seeker	\N	друзья	все	\N
d5dfb956-2b84-4ce8-82d0-9cdce8eeefda	Liza Denesik I	larkin.eleonore@example.org	2026-02-17 17:13:14	$2y$12$wZvn/.VYBHYmgpXkZce71OfYMB/sWkFXa0IiuibYLtuaHXIBf5njW	0vE3f2PAWw	2026-02-17 17:13:14	2026-02-17 17:13:14	bailey.roger	practitioner	Ducimus a pariatur architecto quis.	друзья	все	\N
575f84f9-8d97-4390-bc5b-4b896da10369	Anais Moen MD	betsy57@example.net	2026-02-17 17:13:14	$2y$12$wZvn/.VYBHYmgpXkZce71OfYMB/sWkFXa0IiuibYLtuaHXIBf5njW	WtOX7ieM9R	2026-02-17 17:13:14	2026-02-17 17:13:14	orn.alvina	practitioner	\N	друзья	все	\N
011cc642-d1cd-4eb2-bb30-54ee6eadf4b3	Casandra DuBuque	ebert.mable@example.net	2026-02-17 17:13:14	$2y$12$wZvn/.VYBHYmgpXkZce71OfYMB/sWkFXa0IiuibYLtuaHXIBf5njW	HCo7KrBE6S	2026-02-17 17:13:14	2026-02-17 17:13:14	alek.ohara	practitioner	Ad omnis vel deserunt quo eaque autem.	друзья	все	\N
9a632ac5-9075-4239-bfec-42fcdc064476	Golden Murray	xyundt@example.com	2026-02-17 17:13:14	$2y$12$wZvn/.VYBHYmgpXkZce71OfYMB/sWkFXa0IiuibYLtuaHXIBf5njW	Gu166vPAjW	2026-02-17 17:13:14	2026-02-17 17:13:14	marcelino51	practitioner	Sint dolores sit et laudantium deleniti.	друзья	все	\N
3531ad0e-c11a-40f4-a0f4-d77267774c93	Columbus Kozey Sr.	dolly.homenick@example.net	2026-02-17 17:13:14	$2y$12$wZvn/.VYBHYmgpXkZce71OfYMB/sWkFXa0IiuibYLtuaHXIBf5njW	vRyNXXlib5	2026-02-17 17:13:14	2026-02-17 17:13:14	claudie62	seeker	Debitis error tenetur inventore fuga ratione itaque.	друзья	все	\N
8cd287fa-38d1-4309-a9c8-efd6b977322f	Mia Greenholt	mose63@example.net	2026-02-17 17:13:14	$2y$12$wZvn/.VYBHYmgpXkZce71OfYMB/sWkFXa0IiuibYLtuaHXIBf5njW	i0tui5rBhK	2026-02-17 17:13:14	2026-02-17 17:13:14	keely34	practitioner	\N	друзья	все	\N
019c6fe7-8789-726a-a080-e90af5aae0cc	Admin	admin@path.ru	\N	$2y$12$kqBEXCgfZNORAuYEBNM0p.Y/m5cdkLU4h7DyPCXdHFm2Y29erK8/2	\N	2026-02-18 08:39:30	2026-02-18 08:39:30	admin	seeker	\N	друзья	все	\N
019c7003-3392-72b9-909c-cf2d58548fe5	admin	admi2n@path.ru	\N	$2y$12$8aWvBV9dvBmxMF5fCjhgx.UGd22Scyaw8htjJD5JXtm/pmTp/gJM6	0WkDSQsu2xwVpYAjEFJ1gJz2azuhGUtr8ZADmaFAEzkVEeYIFrOYHSPB9D15	2026-02-18 09:09:43	2026-02-18 09:09:43	\N	seeker	\N	друзья	все	\N
019c7b9f-a3b0-733f-8d53-62cc0378e023	Test	newuser@test.com	\N	$2y$12$s/9oZq1R13wTIppyt/VIeeBw5bsLrg7k52zjy2ToJejPUeDu0ZX1a	\N	2026-02-20 15:16:25	2026-02-20 15:16:25	testuser_new	ищущий	\N	друзья	все	\N
019c7ba3-dcda-73a9-b873-90bbc8c629df	Катька	kate@gmail.com	\N	$2y$12$XXjyhWjZKq65SH2Kp72CaOKeomoFdk9YbPz.s1N/F8Wx5q25QjpaS	\N	2026-02-20 15:21:02	2026-02-20 15:21:02	kate	ищущий	\N	друзья	все	\N
019c7bae-0966-7150-9095-5baf26f7f11d	gegergerg	egegeeg@efegeg	\N	$2y$12$SAvrGlqFQSYWaGKAs9AnAe3jgsujCqM7pRLIK16ZLOKHDHWRVVR/W	\N	2026-02-20 15:32:09	2026-02-20 15:32:09	egegerg	ищущий	\N	друзья	все	\N
019c7bb5-f225-7227-9326-909093490a4e	Test	test123@test.com	\N	$2y$12$VyqgglMHvKkhwE2d7Cms.eGa8QvrvOazE00Y8JzBcSKKZkl4U9pvu	\N	2026-02-20 15:40:47	2026-02-20 15:40:47	test123	ищущий	\N	друзья	все	\N
019c7bb8-f379-70d5-b5ec-83935ad32bee	wqrrwr	werwerr@efwewf	\N	$2y$12$aGen6cjraxiIXCripx8Xl.zCwUNH0ZaqMeuOVxNGE/kidyi46bqji	\N	2026-02-20 15:44:04	2026-02-20 15:44:04	werwerw	ищущий	\N	друзья	все	\N
019c7bb9-d0b2-717c-a0eb-9d89e58eb903	Жопка	fghfghfr54564@com	\N	$2y$12$e8gt19Axg0v.85IXAv.k.ehTqUsUE1.FDr4Zo138Awgp3CvYUkGCy	\N	2026-02-20 15:45:01	2026-02-20 15:45:01	Жопин	ищущий	\N	друзья	все	\N
019c7bc3-6bba-719e-9e1f-9adb694e649d	Жопик	email@gmail.com	\N	$2y$12$7Y2CgovnjHZkaWgoIpl/qeMORzL2iFcE4M6BIpmE2HFVCxF0ZdlGW	\N	2026-02-20 15:55:30	2026-02-20 15:55:30	Херов	ищущий	\N	друзья	все	\N
019c7bd9-415f-7256-b01f-3f0c3dbcdbca	Гоша	qweqwe@gmail.com	\N	$2y$12$kN6X3QbjNb8i6bNk0iPCkOW/6qXiSVisHey2AG3d1iICG77itgd4q	\N	2026-02-20 16:19:21	2026-02-20 16:19:21	Петькин	ищущий	\N	друзья	все	\N
019c7be6-0801-7340-a3fc-13437eea3fd5	tttttt	tttttttt@mail.com	\N	$2y$12$0g2FXQf7RAR0MKhoAOreu.hvuVksskbIedndud4qDeg8zMkU2r2gi	\N	2026-02-20 16:33:18	2026-02-20 16:33:18	tttttttt	ищущий	\N	друзья	все	\N
019c7bc6-5b50-707f-b348-6be7ae146522	Катерина	bka@mail.com	\N	$2y$12$UvGHbzgLjICnWTY6P4HnO.sMGSdkPxKVhTCW9AijYpqShbjT1qw1.	\N	2026-02-20 15:58:43	2026-02-24 16:23:06	Kate	\N	Жопка	друзья	все	avatars/9NsG2sZTr5Ufivd7EmrcXDfxUZbO6M9MDkNxl9rA.jpg
019c7c01-a6f6-70eb-8595-dca59ae83a7e	Жопа	Zopa@mail.com	\N	$2y$12$Spr9p6kOBI2.bnAguVnU1ukcxnhmO9x5qIKYWHnfUDqB73u0RecRC	\N	2026-02-20 17:03:29	2026-02-20 17:03:29	Жопная	ищущий	\N	друзья	все	\N
019c6b35-531b-7003-9e4f-ff830b9a39c9	Test User	test@test.com	\N	$2y$12$MscPZNluEJeCU58ZIUuW7OtyF1BlP.xEV/7/Z63lCV9Wx8yI923ba	\N	2026-02-17 10:46:22	2026-02-24 16:50:14	testuser	\N	Silence...	друзья	только я	avatars/n8lDlYxTOWu2Fk5Oz1k841AbyzFwUj3MgNG7rzuX.jpg
\.


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: put_user
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: put_user
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: put_user
--

SELECT pg_catalog.setval('public.migrations_id_seq', 61, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: put_user
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 86, true);


--
-- Name: articles articles_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.articles
    ADD CONSTRAINT articles_pkey PRIMARY KEY (id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: club_members club_members_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_members
    ADD CONSTRAINT club_members_pkey PRIMARY KEY (club_id, user_id);


--
-- Name: club_messages club_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_messages
    ADD CONSTRAINT club_messages_pkey PRIMARY KEY (id);


--
-- Name: club_post_comments club_post_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_post_comments
    ADD CONSTRAINT club_post_comments_pkey PRIMARY KEY (id);


--
-- Name: club_post_likes club_post_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_post_likes
    ADD CONSTRAINT club_post_likes_pkey PRIMARY KEY (id);


--
-- Name: club_post_likes club_post_likes_user_id_club_post_id_unique; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_post_likes
    ADD CONSTRAINT club_post_likes_user_id_club_post_id_unique UNIQUE (user_id, club_post_id);


--
-- Name: club_posts club_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_posts
    ADD CONSTRAINT club_posts_pkey PRIMARY KEY (id);


--
-- Name: clubs clubs_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_pkey PRIMARY KEY (id);


--
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (follower_id, following_id);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: post_likes post_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.post_likes
    ADD CONSTRAINT post_likes_pkey PRIMARY KEY (user_id, post_id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: practice_logs practice_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.practice_logs
    ADD CONSTRAINT practice_logs_pkey PRIMARY KEY (id);


--
-- Name: practices practices_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.practices
    ADD CONSTRAINT practices_pkey PRIMARY KEY (id);


--
-- Name: reminders reminders_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT reminders_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: users users_username_unique; Type: CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_unique UNIQUE (username);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: put_user
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: put_user
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: put_user
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: personal_access_tokens_expires_at_index; Type: INDEX; Schema: public; Owner: put_user
--

CREATE INDEX personal_access_tokens_expires_at_index ON public.personal_access_tokens USING btree (expires_at);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: put_user
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: club_members club_members_club_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_members
    ADD CONSTRAINT club_members_club_id_foreign FOREIGN KEY (club_id) REFERENCES public.clubs(id) ON DELETE CASCADE;


--
-- Name: club_members club_members_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_members
    ADD CONSTRAINT club_members_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: club_messages club_messages_club_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_messages
    ADD CONSTRAINT club_messages_club_id_foreign FOREIGN KEY (club_id) REFERENCES public.clubs(id) ON DELETE CASCADE;


--
-- Name: club_messages club_messages_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_messages
    ADD CONSTRAINT club_messages_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: club_post_comments club_post_comments_club_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_post_comments
    ADD CONSTRAINT club_post_comments_club_post_id_foreign FOREIGN KEY (club_post_id) REFERENCES public.club_posts(id) ON DELETE CASCADE;


--
-- Name: club_post_comments club_post_comments_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_post_comments
    ADD CONSTRAINT club_post_comments_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: club_post_likes club_post_likes_club_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_post_likes
    ADD CONSTRAINT club_post_likes_club_post_id_foreign FOREIGN KEY (club_post_id) REFERENCES public.club_posts(id) ON DELETE CASCADE;


--
-- Name: club_post_likes club_post_likes_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_post_likes
    ADD CONSTRAINT club_post_likes_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: club_posts club_posts_club_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_posts
    ADD CONSTRAINT club_posts_club_id_foreign FOREIGN KEY (club_id) REFERENCES public.clubs(id) ON DELETE CASCADE;


--
-- Name: club_posts club_posts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.club_posts
    ADD CONSTRAINT club_posts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: clubs clubs_creator_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.clubs
    ADD CONSTRAINT clubs_creator_id_foreign FOREIGN KEY (creator_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: comments comments_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_post_id_foreign FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: comments comments_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: follows follows_follower_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_follower_id_foreign FOREIGN KEY (follower_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: follows follows_following_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_following_id_foreign FOREIGN KEY (following_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: post_likes post_likes_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.post_likes
    ADD CONSTRAINT post_likes_post_id_foreign FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: post_likes post_likes_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.post_likes
    ADD CONSTRAINT post_likes_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: posts posts_club_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_club_id_foreign FOREIGN KEY (club_id) REFERENCES public.clubs(id) ON DELETE CASCADE;


--
-- Name: posts posts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: practice_logs practice_logs_practice_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.practice_logs
    ADD CONSTRAINT practice_logs_practice_id_foreign FOREIGN KEY (practice_id) REFERENCES public.practices(id) ON DELETE CASCADE;


--
-- Name: practice_logs practice_logs_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.practice_logs
    ADD CONSTRAINT practice_logs_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: practices practices_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.practices
    ADD CONSTRAINT practices_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: reminders reminders_practice_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT reminders_practice_id_foreign FOREIGN KEY (practice_id) REFERENCES public.practices(id) ON DELETE CASCADE;


--
-- Name: reminders reminders_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: put_user
--

ALTER TABLE ONLY public.reminders
    ADD CONSTRAINT reminders_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: TABLE sessions; Type: ACL; Schema: public; Owner: postgres
--

GRANT ALL ON TABLE public.sessions TO put_user;


--
-- PostgreSQL database dump complete
--

\unrestrict mQJKylTohitpnEgqhsAygwrGa2OQQJT7WWJZr0SgQkhMgzIcdhjWdyQV7OeGm9e

