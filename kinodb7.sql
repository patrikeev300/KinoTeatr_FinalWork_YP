CREATE DATABASE kinodb7
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'Russian_Russia.1251'
    LC_CTYPE = 'Russian_Russia.1251'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1
    IS_TEMPLATE = False;
CREATE TABLE IF NOT EXISTS public.author
(
    id_author bigint NOT NULL,
    name_author character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT author_pkey PRIMARY KEY (id_author)
)
CREATE TABLE IF NOT EXISTS public.country
(
    id_country bigint NOT NULL,
    name_country character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT country_pkey PRIMARY KEY (id_country)
)
CREATE TABLE IF NOT EXISTS public.film
(
    id_film bigint NOT NULL,
    name character varying(50) COLLATE pg_catalog."default",
    numbers_actors_film integer NOT NULL,
    price_film double precision NOT NULL,
    rating_film integer NOT NULL,
    time_film integer NOT NULL,
    year_film integer NOT NULL,
    id_author bigint,
    id_genre bigint,
    id_manufacturer bigint,
    CONSTRAINT film_pkey PRIMARY KEY (id_film),
    CONSTRAINT fk32i59h9wca27rdt61ld4vbhd FOREIGN KEY (id_manufacturer)
        REFERENCES public.manufacturer (id_manufacturer) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkepq0d9lvjpmd64hrl1u1ossuk FOREIGN KEY (id_author)
        REFERENCES public.author (id_author) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkknwqkkdqxrymsqj9lm7h64r2b FOREIGN KEY (id_genre)
        REFERENCES public.genre (id_genre) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT film_numbers_actors_film_check CHECK (numbers_actors_film >= 1 AND numbers_actors_film <= 200),
    CONSTRAINT film_rating_film_check CHECK (rating_film >= 1 AND rating_film <= 10),
    CONSTRAINT film_time_film_check CHECK (time_film <= 1000 AND time_film >= 5),
    CONSTRAINT film_year_film_check CHECK (year_film <= 2023 AND year_film >= 2000)
)
CREATE TABLE IF NOT EXISTS public.genre
(
    id_genre bigint NOT NULL,
    name_genre character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT genre_pkey PRIMARY KEY (id_genre)
)
CREATE TABLE IF NOT EXISTS public.indent
(
    id_indent bigint NOT NULL,
    price_indent double precision NOT NULL,
    id_status bigint,
    id_user bigint,
    CONSTRAINT indent_pkey PRIMARY KEY (id_indent),
    CONSTRAINT fk2ci4cvwlomxtmw60klpcxgn3u FOREIGN KEY (id_user)
        REFERENCES public.model_user (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk8rske5d66t62qluvmbtbavbou FOREIGN KEY (id_status)
        REFERENCES public.status (id_status) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
CREATE TABLE IF NOT EXISTS public.indent_film
(
    indent_id bigint NOT NULL,
    film_id bigint NOT NULL,
    CONSTRAINT fkep7anflmg08i4t4xpdw1s2foh FOREIGN KEY (indent_id)
        REFERENCES public.indent (id_indent) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fkfkm93bqwu9aw0epsa26enfq5l FOREIGN KEY (film_id)
        REFERENCES public.film (id_film) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
CREATE TABLE IF NOT EXISTS public.manufacturer
(
    id_manufacturer bigint NOT NULL,
    name_genre character varying(50) COLLATE pg_catalog."default",
    year_manufacturer integer NOT NULL,
    id_country bigint,
    CONSTRAINT manufacturer_pkey PRIMARY KEY (id_manufacturer),
    CONSTRAINT fks4p4eftcxvj7s1ljl7t86lu6d FOREIGN KEY (id_country)
        REFERENCES public.country (id_country) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT manufacturer_year_manufacturer_check CHECK (year_manufacturer >= 1900 AND year_manufacturer <= 2023)
)
CREATE TABLE IF NOT EXISTS public.model_user
(
    id_user bigint NOT NULL GENERATED BY DEFAULT AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    active boolean NOT NULL,
    password character varying(255) COLLATE pg_catalog."default",
    username character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT model_user_pkey PRIMARY KEY (id_user)
)
CREATE TABLE IF NOT EXISTS public.status
(
    id_status bigint NOT NULL,
    name_status character varying(50) COLLATE pg_catalog."default",
    CONSTRAINT status_pkey PRIMARY KEY (id_status)
)
CREATE TABLE IF NOT EXISTS public.user_role
(
    user_id bigint NOT NULL,
    roles character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT fkhnk3nw6rsvkly3ww7umdq7ys1 FOREIGN KEY (user_id)
        REFERENCES public.model_user (id_user) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
