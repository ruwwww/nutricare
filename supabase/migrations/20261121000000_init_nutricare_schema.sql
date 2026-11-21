

CREATE TABLE IF NOT EXISTS public.email_verifications
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    user_id bigint NOT NULL,
    kode_otp character varying(6) COLLATE pg_catalog."default" NOT NULL,
    expired_at timestamp without time zone NOT NULL,
    CONSTRAINT email_verifications_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.food_diary
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    user_id bigint NOT NULL,
    menu_id bigint,
    nama_makanan character varying(150) COLLATE pg_catalog."default" NOT NULL,
    waktu_makan character varying(20) COLLATE pg_catalog."default" NOT NULL,
    tanggal date NOT NULL,
    porsi numeric(4, 2) NOT NULL DEFAULT 1.00,
    kalori numeric(7, 1) NOT NULL,
    karbo_g numeric(6, 1) NOT NULL DEFAULT 0,
    protein_g numeric(6, 1) NOT NULL DEFAULT 0,
    lemak_g numeric(6, 1) NOT NULL DEFAULT 0,
    CONSTRAINT food_diary_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.jadwal_ahli_gizi
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    ahli_gizi_id bigint NOT NULL,
    tanggal date NOT NULL,
    jam_mulai time without time zone NOT NULL,
    jam_selesai time without time zone NOT NULL,
    sesi smallint NOT NULL,
    is_booked boolean NOT NULL DEFAULT false,
    CONSTRAINT jadwal_ahli_gizi_pkey PRIMARY KEY (id),
    CONSTRAINT uq_jadwal_slot UNIQUE (ahli_gizi_id, tanggal, sesi)
);

CREATE TABLE IF NOT EXISTS public.menu_alergen
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    menu_id bigint NOT NULL,
    alergen character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT menu_alergen_pkey PRIMARY KEY (id),
    CONSTRAINT uq_menu_alergen UNIQUE (menu_id, alergen)
);

CREATE TABLE IF NOT EXISTS public.menu_ratings
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    menu_id bigint NOT NULL,
    user_id bigint NOT NULL,
    rating smallint NOT NULL,
    CONSTRAINT menu_ratings_pkey PRIMARY KEY (id),
    CONSTRAINT uq_rating_user_menu UNIQUE (menu_id, user_id)
);

CREATE TABLE IF NOT EXISTS public.menus
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    nama character varying(150) COLLATE pg_catalog."default" NOT NULL,
    foto_url character varying(255) COLLATE pg_catalog."default",
    kategori character varying(20) COLLATE pg_catalog."default" NOT NULL,
    kalori numeric(7, 1) NOT NULL,
    karbo_g numeric(6, 1) NOT NULL,
    protein_g numeric(6, 1) NOT NULL,
    lemak_g numeric(6, 1) NOT NULL,
    harga integer NOT NULL,
    created_by bigint NOT NULL,
    is_active boolean NOT NULL DEFAULT true,
    CONSTRAINT menus_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.notifikasi
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    user_id bigint NOT NULL,
    pesan character varying(255) COLLATE pg_catalog."default" NOT NULL,
    is_read boolean NOT NULL DEFAULT false,
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT notifikasi_pkey PRIMARY KEY (id)
);

CREATE TABLE IF NOT EXISTS public.profiles
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    user_id bigint NOT NULL,
    nama_lengkap character varying(150) COLLATE pg_catalog."default" NOT NULL,
    gelar character varying(50) COLLATE pg_catalog."default",
    tempat_lahir character varying(100) COLLATE pg_catalog."default",
    tanggal_lahir date,
    jenis_kelamin character(1) COLLATE pg_catalog."default",
    tingkat_aktivitas character varying(10) COLLATE pg_catalog."default" NOT NULL DEFAULT 'sedang'::character varying,
    keterangan character varying(255) COLLATE pg_catalog."default",
    tinggi_cm numeric(5, 1),
    berat_kg numeric(5, 1),
    target_kalori integer,
    foto_url character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT profiles_pkey PRIMARY KEY (id),
    CONSTRAINT uq_profiles_user UNIQUE (user_id)
);

CREATE TABLE IF NOT EXISTS public.reservasi
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    mahasiswa_id bigint NOT NULL,
    jadwal_id bigint NOT NULL,
    jadwal_id_lama bigint,
    status character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'reservasi'::character varying,
    catatan text COLLATE pg_catalog."default",
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT reservasi_pkey PRIMARY KEY (id),
    CONSTRAINT uq_reservasi_jadwal UNIQUE (jadwal_id)
);

CREATE TABLE IF NOT EXISTS public.user_alergi
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    user_id bigint NOT NULL,
    nama_alergi character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT user_alergi_pkey PRIMARY KEY (id),
    CONSTRAINT uq_user_alergi UNIQUE (user_id, nama_alergi)
);

CREATE TABLE IF NOT EXISTS public.user_penyakit
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    user_id bigint NOT NULL,
    nama_penyakit character varying(100) COLLATE pg_catalog."default" NOT NULL,
    CONSTRAINT user_penyakit_pkey PRIMARY KEY (id),
    CONSTRAINT uq_user_penyakit UNIQUE (user_id, nama_penyakit)
);

CREATE TABLE IF NOT EXISTS public.users
(
    id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ( INCREMENT 1 START 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1 ),
    username character varying(50) COLLATE pg_catalog."default" NOT NULL,
    email character varying(150) COLLATE pg_catalog."default" NOT NULL,
    password_hash character varying(255) COLLATE pg_catalog."default" NOT NULL,
    role character varying(20) COLLATE pg_catalog."default" NOT NULL DEFAULT 'mahasiswa'::character varying,
    is_verified boolean NOT NULL DEFAULT false,
    created_at timestamp without time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT users_pkey PRIMARY KEY (id),
    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT uq_users_username UNIQUE (username)
);

ALTER TABLE IF EXISTS public.email_verifications
    ADD CONSTRAINT fk_ev_user FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS idx_ev_user
    ON public.email_verifications(user_id);


ALTER TABLE IF EXISTS public.food_diary
    ADD CONSTRAINT fk_diary_menu FOREIGN KEY (menu_id)
    REFERENCES public.menus (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE SET NULL;


ALTER TABLE IF EXISTS public.food_diary
    ADD CONSTRAINT fk_diary_user FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.jadwal_ahli_gizi
    ADD CONSTRAINT fk_jadwal_ahli FOREIGN KEY (ahli_gizi_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.menu_alergen
    ADD CONSTRAINT fk_alergen_menu FOREIGN KEY (menu_id)
    REFERENCES public.menus (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.menu_ratings
    ADD CONSTRAINT fk_rating_menu FOREIGN KEY (menu_id)
    REFERENCES public.menus (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.menu_ratings
    ADD CONSTRAINT fk_rating_user FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.menus
    ADD CONSTRAINT fk_menus_creator FOREIGN KEY (created_by)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE RESTRICT;


ALTER TABLE IF EXISTS public.notifikasi
    ADD CONSTRAINT fk_notif_user FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.profiles
    ADD CONSTRAINT fk_profiles_user FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;
CREATE INDEX IF NOT EXISTS uq_profiles_user
    ON public.profiles(user_id);


ALTER TABLE IF EXISTS public.reservasi
    ADD CONSTRAINT fk_reservasi_jadwal FOREIGN KEY (jadwal_id)
    REFERENCES public.jadwal_ahli_gizi (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE RESTRICT;
CREATE INDEX IF NOT EXISTS uq_reservasi_jadwal
    ON public.reservasi(jadwal_id);


ALTER TABLE IF EXISTS public.reservasi
    ADD CONSTRAINT fk_reservasi_jadwal_lama FOREIGN KEY (jadwal_id_lama)
    REFERENCES public.jadwal_ahli_gizi (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE SET NULL;


ALTER TABLE IF EXISTS public.reservasi
    ADD CONSTRAINT fk_reservasi_mhs FOREIGN KEY (mahasiswa_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.user_alergi
    ADD CONSTRAINT fk_alergi_user FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE IF EXISTS public.user_penyakit
    ADD CONSTRAINT fk_penyakit_user FOREIGN KEY (user_id)
    REFERENCES public.users (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


-- CHECK constraints (dari catatan ERD)
ALTER TABLE public.menu_ratings ADD CONSTRAINT chk_rating_range CHECK (rating BETWEEN 1 AND 5);
ALTER TABLE public.profiles ADD CONSTRAINT chk_tinggi CHECK (tinggi_cm IS NULL OR tinggi_cm BETWEEN 50 AND 250);
ALTER TABLE public.profiles ADD CONSTRAINT chk_berat CHECK (berat_kg IS NULL OR berat_kg BETWEEN 10 AND 300);

-- RLS aktif (tanpa policy = akses API ditolak sampai policy dibuat)
ALTER TABLE public.email_verifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.food_diary ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.jadwal_ahli_gizi ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.menu_alergen ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.menu_ratings ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.menus ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.notifikasi ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.reservasi ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_alergi ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.user_penyakit ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.users ENABLE ROW LEVEL SECURITY;
