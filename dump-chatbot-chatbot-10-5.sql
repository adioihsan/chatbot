PGDMP  *    "            
    |            chatbot    16.3    16.3 ;               0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    16770    chatbot    DATABASE     s   CREATE DATABASE chatbot WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'en_US.UTF-8';
    DROP DATABASE chatbot;
                postgres    false                       0    0    DATABASE chatbot    ACL     '   GRANT ALL ON DATABASE chatbot TO adio;
                   postgres    false    4378                        2615    2200    public    SCHEMA        CREATE SCHEMA public;
    DROP SCHEMA public;
                pg_database_owner    false                       0    0    SCHEMA public    COMMENT     6   COMMENT ON SCHEMA public IS 'standard public schema';
                   pg_database_owner    false    5                       0    0    SCHEMA public    ACL     $   GRANT ALL ON SCHEMA public TO adio;
                   pg_database_owner    false    5            �            1259    16976    cache    TABLE     �   CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);
    DROP TABLE public.cache;
       public         heap    adio    false    5            �            1259    16983    cache_locks    TABLE     �   CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);
    DROP TABLE public.cache_locks;
       public         heap    adio    false    5            �            1259    17029    chat_histories    TABLE     �   CREATE TABLE public.chat_histories (
    id uuid NOT NULL,
    chat_id uuid NOT NULL,
    prompt text NOT NULL,
    response text NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
 "   DROP TABLE public.chat_histories;
       public         heap    adio    false    5            �            1259    17019    chats    TABLE     �   CREATE TABLE public.chats (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    title character varying
);
    DROP TABLE public.chats;
       public         heap    adio    false    5            �            1259    17008    failed_jobs    TABLE     &  CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);
    DROP TABLE public.failed_jobs;
       public         heap    adio    false    5            �            1259    17007    failed_jobs_id_seq    SEQUENCE     {   CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 )   DROP SEQUENCE public.failed_jobs_id_seq;
       public          adio    false    226    5                       0    0    failed_jobs_id_seq    SEQUENCE OWNED BY     I   ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;
          public          adio    false    225            �            1259    17000    job_batches    TABLE     d  CREATE TABLE public.job_batches (
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
    DROP TABLE public.job_batches;
       public         heap    adio    false    5            �            1259    16991    jobs    TABLE     �   CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);
    DROP TABLE public.jobs;
       public         heap    adio    false    5            �            1259    16990    jobs_id_seq    SEQUENCE     t   CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.jobs_id_seq;
       public          adio    false    223    5                       0    0    jobs_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;
          public          adio    false    222            �            1259    16945 
   migrations    TABLE     �   CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);
    DROP TABLE public.migrations;
       public         heap    adio    false    5            �            1259    16944    migrations_id_seq    SEQUENCE     �   CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.migrations_id_seq;
       public          adio    false    216    5                        0    0    migrations_id_seq    SEQUENCE OWNED BY     G   ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;
          public          adio    false    215            �            1259    16960    password_reset_tokens    TABLE     �   CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);
 )   DROP TABLE public.password_reset_tokens;
       public         heap    adio    false    5            �            1259    16967    sessions    TABLE     �   CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL,
    user_id uuid
);
    DROP TABLE public.sessions;
       public         heap    adio    false    5            �            1259    16951    users    TABLE     v  CREATE TABLE public.users (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);
    DROP TABLE public.users;
       public         heap    adio    false    5            X           2604    17011    failed_jobs id    DEFAULT     p   ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);
 =   ALTER TABLE public.failed_jobs ALTER COLUMN id DROP DEFAULT;
       public          adio    false    225    226    226            W           2604    16994    jobs id    DEFAULT     b   ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);
 6   ALTER TABLE public.jobs ALTER COLUMN id DROP DEFAULT;
       public          adio    false    222    223    223            V           2604    16948    migrations id    DEFAULT     n   ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);
 <   ALTER TABLE public.migrations ALTER COLUMN id DROP DEFAULT;
       public          adio    false    215    216    216                      0    16976    cache 
   TABLE DATA           7   COPY public.cache (key, value, expiration) FROM stdin;
    public          adio    false    220   B                 0    16983    cache_locks 
   TABLE DATA           =   COPY public.cache_locks (key, owner, expiration) FROM stdin;
    public          adio    false    221   -B                 0    17029    chat_histories 
   TABLE DATA           _   COPY public.chat_histories (id, chat_id, prompt, response, created_at, updated_at) FROM stdin;
    public          adio    false    228   JB                 0    17019    chats 
   TABLE DATA           K   COPY public.chats (id, user_id, created_at, updated_at, title) FROM stdin;
    public          adio    false    227   dU                 0    17008    failed_jobs 
   TABLE DATA           a   COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
    public          adio    false    226   �Z                 0    17000    job_batches 
   TABLE DATA           �   COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
    public          adio    false    224   �Z                 0    16991    jobs 
   TABLE DATA           c   COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
    public          adio    false    223   �Z                 0    16945 
   migrations 
   TABLE DATA           :   COPY public.migrations (id, migration, batch) FROM stdin;
    public          adio    false    216   
[       
          0    16960    password_reset_tokens 
   TABLE DATA           I   COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
    public          adio    false    218   �[                 0    16967    sessions 
   TABLE DATA           _   COPY public.sessions (id, ip_address, user_agent, payload, last_activity, user_id) FROM stdin;
    public          adio    false    219   �[       	          0    16951    users 
   TABLE DATA           u   COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
    public          adio    false    217   v^       !           0    0    failed_jobs_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);
          public          adio    false    225            "           0    0    jobs_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);
          public          adio    false    222            #           0    0    migrations_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.migrations_id_seq', 5, true);
          public          adio    false    215            h           2606    16989    cache_locks cache_locks_pkey 
   CONSTRAINT     [   ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);
 F   ALTER TABLE ONLY public.cache_locks DROP CONSTRAINT cache_locks_pkey;
       public            adio    false    221            f           2606    16982    cache cache_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);
 :   ALTER TABLE ONLY public.cache DROP CONSTRAINT cache_pkey;
       public            adio    false    220            u           2606    17040 "   chat_histories chat_histories_pkey 
   CONSTRAINT     `   ALTER TABLE ONLY public.chat_histories
    ADD CONSTRAINT chat_histories_pkey PRIMARY KEY (id);
 L   ALTER TABLE ONLY public.chat_histories DROP CONSTRAINT chat_histories_pkey;
       public            adio    false    228            s           2606    17028    chats chats_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.chats DROP CONSTRAINT chats_pkey;
       public            adio    false    227            o           2606    17016    failed_jobs failed_jobs_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.failed_jobs DROP CONSTRAINT failed_jobs_pkey;
       public            adio    false    226            q           2606    17018 #   failed_jobs failed_jobs_uuid_unique 
   CONSTRAINT     ^   ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);
 M   ALTER TABLE ONLY public.failed_jobs DROP CONSTRAINT failed_jobs_uuid_unique;
       public            adio    false    226            m           2606    17006    job_batches job_batches_pkey 
   CONSTRAINT     Z   ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);
 F   ALTER TABLE ONLY public.job_batches DROP CONSTRAINT job_batches_pkey;
       public            adio    false    224            j           2606    16998    jobs jobs_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.jobs DROP CONSTRAINT jobs_pkey;
       public            adio    false    223            [           2606    16950    migrations migrations_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);
 D   ALTER TABLE ONLY public.migrations DROP CONSTRAINT migrations_pkey;
       public            adio    false    216            a           2606    16966 0   password_reset_tokens password_reset_tokens_pkey 
   CONSTRAINT     q   ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);
 Z   ALTER TABLE ONLY public.password_reset_tokens DROP CONSTRAINT password_reset_tokens_pkey;
       public            adio    false    218            d           2606    16973    sessions sessions_pkey 
   CONSTRAINT     T   ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);
 @   ALTER TABLE ONLY public.sessions DROP CONSTRAINT sessions_pkey;
       public            adio    false    219            ]           2606    16959    users users_email_unique 
   CONSTRAINT     T   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);
 B   ALTER TABLE ONLY public.users DROP CONSTRAINT users_email_unique;
       public            adio    false    217            _           2606    16957    users users_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public.users DROP CONSTRAINT users_pkey;
       public            adio    false    217            k           1259    16999    jobs_queue_index    INDEX     B   CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);
 $   DROP INDEX public.jobs_queue_index;
       public            adio    false    223            b           1259    16975    sessions_last_activity_index    INDEX     Z   CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);
 0   DROP INDEX public.sessions_last_activity_index;
       public            adio    false    219            w           2606    17034 -   chat_histories chat_histories_chat_id_foreign    FK CONSTRAINT     �   ALTER TABLE ONLY public.chat_histories
    ADD CONSTRAINT chat_histories_chat_id_foreign FOREIGN KEY (chat_id) REFERENCES public.chats(id);
 W   ALTER TABLE ONLY public.chat_histories DROP CONSTRAINT chat_histories_chat_id_foreign;
       public          adio    false    227    228    4211            v           2606    17022    chats chats_user_id_foreign    FK CONSTRAINT     z   ALTER TABLE ONLY public.chats
    ADD CONSTRAINT chats_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id);
 E   ALTER TABLE ONLY public.chats DROP CONSTRAINT chats_user_id_foreign;
       public          adio    false    217    227    4191                  x������ � �            x������ � �            x��Zَǒ}��"�2�V���a\A-ɖ�܀46�%�"S����n�O�#��K�Dd���;��,feeEDF�8���aV2(tUi)MP*]��꼖eZ�bU�Ie��
�<��(T���S�2�Ɏ��m��{�Zv❐���I�YL����8�� 
�$aq��a���w��HƁѹ	R��L�8��ܦiVT���e��j��e��kU�	u,�x�%��2���(/�r���_g�'ō�Y6�����b졀�&��7V��6�یk��IL[��X�����.�?�'�a�Ԙ�<eZA�{�<��,W���02�eREXi��A��U��Kel�+���w�rT���/VY� 	[Q��5N��M[��8�B���a���4D�k9Y�Uħ~��VB���*dgh*��cS�i���a�B��4�r�\=7t��$ =88�[ة��ӂ�4V�{��0u?��>�76t��"��7K���eE�C�}��<�L�m��bx��{7a�����{����?��EaҾ�����sZв�v�g( Gq����<�϶�7�����a��rr}��]c�W�J6�<:�]G������v�x�IvGO�-nR䁶y��V�*��<�B�"8[ܤHq�"@dU����3��4�I�V����ޯ>������Ϧ�{�ε����#E��UE�4o3��VY����5��� `k
��`��k��:���|�x@�5���0�����F��q���њ�@�v�$��v�V��~�X����m���FU^y/��F����j�򝦿�4�P�j�U-��aŸw]�׵W��o�뾕�{�vn�a�hqF������TXWo%v3�w~�<���-�2�e� �"TqXZ��2EV�H��Iy`��hR�8%()��檌�pw�f�~���������[O�pp��&�]�䯃�Q����c?w�@V ��ȸ������m���QØ��}�=�ȴs}gE��t�u�g�s���'�a?a.ĉ!o�d��Ϳ�ֶ��ÌY��NX��6�&�@?��qu��n�>��2�x{�!�w �I����m��9�ş�~�mi�8���6��Y�҈@)�7�a�ֱJ�2��j�T%���0�5�E]&U�)d��Ȑ�@��Y�Vv�;Z��Z��6���#i5�Jg'�:}����):�ѿ���if��''[��Z|��T�ﻵ�`�q+>ma�t��k����z����ٲ�2.��f3U�eΡ��A�UF�$NM���I!Y��<�ӓDF:ARL�t�w�h�R/ɯFh�l#n�=�B-�H�!�f�%� vдiK �[�3��)� �)��t�6����;�������A��s� �衇2 �z,	n�f?�զ�(
dStj��(q��O�,�_��Sc޲�"��, B��̓4�����(]-��\�`�lT
����"̵Y��(�vj���������]��|�~>}Zi�)��ψ���㊟}���"3n��?�a��i������4�\�-�P��2z�D4ƪ&��AT�`RV�A"���0V:�t�Z&���4p�J�A�JU�&5H�w�z�\�Ϗw�n.<�p�ѧ2NT /��_�n׋_.��_2��vL��R��A<Sr�`�����SX�h�Ir�mF��ޑ�L��z�[^,�!����x��{�	rwS�aY�c�����c����9���{��|z����=r����9�>�5(_C
�3��@#6�l�4����:B��1/Bp��25,�w�N~u�۰h-;o#�	�4�R����3W���[;P��T�>�%�� �z��>�a�e��$|j��,�Q�e�:��UV�Af��6�V���2)�B��:
JOKC�4��dj�����f\YE�jnfq�W��*�� D�	�@�t1��%��3&��;�1 7c�K�\ �'�9#ܔnM�l�t)�؝;.M�������p2��/]v!��1<	��>ﭟ#U`O0����"A��F�`�󎘏�l�ݑ����A~�
<=�H��E.��u���n������J\z	�����W�������Յ�Ɔ/*+ZȰpۓ@���,XM@ ���:<��d�3l��(�=
}w��P{��x�������a^^�|z$���OE�e�^��Sc�SEUE5_��.�ɼPA^�B�amK]��I*��4�ů4Y��[fa��՟��F��H�Z.���R�d 
JF'-����>@d�	F�;0R��h3;�K	g'b��6���
̃����g��،��q�]�����ȹAM:8��΃J�?�����`|Lw�nɱo䁊M.���Q�"�.��2�[��AQ*��(PZ&*�k'�,���!��S�@Zl���Q��DeE�H��o\m_�~�sKQdȣ�yQ������-�VQ&V�B����R��Q�f�53fz�%���T�1���� T���Q��0}j�E�6��4!+��6�ƌTu��0�V�$�EV�%����f�H�JkkW��3���eӿX]��̊HY�Ӯ� ��ׁ��j�N|��⯞������	����/�t�[�
�?28��z�۔%�S��
���r`�<��"k��[�Rp�4�
nV7����fₔL�sjF����et�
/��)l�/s����kv�!~ ���o�D'5*_9k˘�,�f�)s�R�[�N����y� |�)v掗�H�(��K2�����
'�UhCh����s��|g����mXh��R.7�� ��^?t�8�̒��w���L����M�˰J��te�8O���T���T[|�E�g�j����b��_sKOt���c�� ¼��)sp	��&��}��.���;�_��Sc��`�:���MPe9`ŨȀ���F��
pO�Ӱ�����iUy�%�	�o�=4��?�w�݈�Ros��!������_�#��_᏶eZ7Ίt�&ղ:nc������
r�4�:��c�� kPq:��	��V9��ɢV|gy��Xڬ�N��K��,������ m���k}#��.�IwjP��T�`�3�rԩo���$\Tx;���,���������{�G��k�6���5E�M�O��N�'�FI����}�%��pT��L�-q| _��A6�'��c�2&F�g@cU&�De�(O⼈�j�D�UGQ��:�uPT���BT�����F�Jؘs��BI�l'~G2��Q�z�9H�3�%NI��|jl�e((L���Q��&N��TaV$�Qbc(h���e�@UQ����Ю2�w�����{���(�	��7I�YvU�N	���3�7��۾��=t|�����F��5�)�}LkP�Q��'o:߄:1�5�OJ�f�D�}�d�g^Ӽ.�9�=���{�҉%9~��pn�n�Q�'X�qϲ�y�o5�K;��n�ø�	�g��r��r��� �%$�g�>�t|uW�ǌ�G9�`X�Y�in�q=_Z2�y�E��=���$o���<����)���o�`,�r�ŕ�D�2�6��;�!�ڽ���9ϲ�dA���QB�p�-JO�3#9�6���,��˸���q�;��&�0�l�|$�ܑyʖ���%.��f��Y@����%�4�,�m8,�*X��,��D�� ���}(�ʖ����CH-�y�RUL�	�l���w���z�G��4��� $;���<�Xd�ڢ^J	�T�Y�QR�fI��IE�W�	Ҫ@�2iS�5&&��3�N�a��pKK��Xr��J��8r���@��_d���������9R�k��#k��r��s5?GɄ�kJ֣���뿥��U׽�|H��b�;a:S2摴Ak�5����ofuz��i(��V����ص?m�qB�-��6@�v�R3���D>�{ہ�a)��a�j�%��Mk}����DG�*ƹ+��FnK��L��帍�^��C����h�o)Z��"agW���~@H><�<K굡��/% k�`ԓ�c�����_}�f�����&��D�ܹY��@���(Sor�r��팩�8-�C������x�C�zv�-��,�o�K�*   ���G�����({��q@�3\�P����þ���_b�h�	���� O�ͪ#8	Y�[�,�'9���"3:����^��bDL�&O`=��?�Fu��i��1��t�!�ۄ���3���z�6i�}g߀)l�N��F�y<�:ފ��x<���oKvk{��X(7m�<7�;��y3I���?��o�g>f(�\/��V�g�(v	yOx48�8f��zl�$+.=څ����*�KFJxܷ��.�S����Y�`��� &cw�)[��4�%���F��c�g�!�]ͅ�-�qYL���֗2�A�[/�1�SAy��7圸�7(������3K~��e�J�"�Op�$�̓ �T�ud�D�MR����5	]��&�������z5���[:�Cq�gJ����&�"��)\��\��(�n���3��iv�O�y�e��PB�4���3M�
��,-������d����*:�4uT'���$KO����ՇyK�ވw��(;� ��@����R��۞:�TCr:�F� ��������$�?#h�I�ۡ��A���9 F�=�H�GP/^R���6�{���꯳�>5�x!�p�{�A*�MN���q��(>�$#D9�X�����c+�z��5������\׉H\�;�Cn�����W�o>�nz}��r�sx)2�R�@+X�����ETU����Kq5�v��K�����8�8����!��9Qۢ�K���<Ҵ�X�u���C\2�/x�C��PQ�O�}�����_����         ?  x��X�nG<[_���=={�!��\r��I��$����,s� K�VM?�{�R&�M 㴤�S�Т��]�|
ŖE��}%c�������W��N}RB�����w��0S�ԶFF)��\���wEd��D�G!�خӰ�^�x�÷���*�	G���kE�r �KS�J��A���]�L3��|����L�z�Ǜo��h� )�T��Y[�N���Q�Ɗ]�e�V���T,2!5k"���T�X
��ۄ���s<�k]�S�,N�Cǆ?;��&��b+G��3B>Lm�񺲗 P䌸��(�H�(�F-e6��_�a����z^�kp���dR�j�I����7����;���C<=���0�����"1�*���"�85�U6�������t��8�j��"퓄�4I\�o��J"�>N-<j�������痼?}�%�PsV�zO,V����Vh�� I�A�Q�Qs�}���2����g&c}�X!�TQR+�q����s��ͮw�N_�}�o"�H$���s�J�hA��!�Z����[��^߂�^Z���&!RN�TE����z��&	jT�����~�����P
)C��y�#]�\�(�mLG�[)���o
JQs+2��G <�1I����l�v�%ǩ�� 7���jJ��:#%�Q�"R
�K�M��*�܉�j��x���J]�'L!<R��&�)�4���D�G默��\�}N�Z����;�l
8w��L{���	7�b��c<���+u����ُx~i�������/4�c�؍z��*�^$$�
	ֳ6C,u#���c+�N�>��;,�K�>�#����u7���]�ix�]�s�=�4�
�l��M���zT�����T	Q¢�*S�4c�Y&/��G}j%7���� /+����P���I+�c� Ƽ�b]�L��Q\v�<���L1�4s�J��C��Jn�y��.�3���a��b����-{���Rf�qn>
�ݢ�
jLl��m^��I�1s�--�����~t>yz9�e ^^AUDE�.܂b��D1�C���.`7r��.�_�^ϫ )��yva,$^�Z��E���&Av�}��Ea.$�a��2+\4+��XN���	�n@�n�?b��BN�:�Ƃ��\q��aAvC?���;��@m���0�\�'��AI��Z�������Ԭ��	̝���K�0��U"m� 7��1]�}G�"��*�����v�l��DdQ��4��{��3��~���i��t=�|}���R��2�TB��bAL[���V�������?�~�            x������ � �            x������ � �            x������ � �         h   x�e��
� �g�1�-�>&&� P��"*�}<��"�<�OBV_U���H�˦��;H/>D���A~�/m�F�B(#^�:�>��k����JL��9ik� ���?�      
      x������ � �         �  x���Mo�6��ί�=$!�iuуɲ�Z;���%ّh��eK�_z��h	���p��l�$r������%�qi�%�嬶߾	/m���j�PNP+k!������A�e����a:̬?-�����7�kO�ש�+�� PN��ݾ�f'��0:v2��
�r�y؅lr�z���-Mb=m�1'^�]{t@�Ǉ�W�B�$F	�ȣ#{�YoFu�/��(q-3TG�g!r�������HG�y7(�sk5�ċz5���ȝ����[�9�V��f�
�����Ҽ���sO�>Sڲ��&�Um�ӡ�7�Ow1��>�+��%�KA�FiX!�*�o8j��񃚋#��Q'��l0�%��܌\qP^j�H���M��z:�R��02�(�
 ���.�x:恚�}mضnCg�f�߂�ѱ�ݣa��c���G�����3�mi+3s^셷N���r����yZ����#�����/���� Y����c��M���i��7���2��t+���M���U�85i���'|�s��*��k��?�9���q��Qx���&�r�����Hi9gv��*��˅e�'\nq��ʯ<���Y�15%H���@eX���؝������G:��ROa�����7���m�k�|V!u)t� ��~�c�;L
��Zc$����K�q��t�;\�xzxx���h.      	   �   x�m˻�0@�>k���L/	���jLX*%�FI}zew�r�j�+E

QbJK�/h̄_Q^2Op������T��~�'ͯ����[+O-��S$o���[�o�fCvrG�u6*�u��?�c��C�J#�Lt��~ @�G�Ol�#`��.B��;1�     