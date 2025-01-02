SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.8

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
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."audit_log_entries" ("instance_id", "id", "payload", "created_at", "ip_address") VALUES
	('00000000-0000-0000-0000-000000000000', '35e64282-b07e-414c-bd78-5547afc10d8e', '{"action":"user_confirmation_requested","actor_id":"e475c835-2fa0-42aa-9b24-fd5ab6ed3795","actor_name":"Adam Peterson","actor_username":"adambpeterson@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-01-01 23:55:57.791569+00', ''),
	('00000000-0000-0000-0000-000000000000', 'c52db055-1b33-436b-88a8-39ba280e0905', '{"action":"user_deleted","actor_id":"00000000-0000-0000-0000-000000000000","actor_username":"service_role","actor_via_sso":false,"log_type":"team","traits":{"user_email":"adambpeterson@gmail.com","user_id":"e475c835-2fa0-42aa-9b24-fd5ab6ed3795","user_phone":""}}', '2025-01-02 00:15:41.027443+00', ''),
	('00000000-0000-0000-0000-000000000000', 'fc9af09a-d666-4825-920c-d99d264435f7', '{"action":"user_confirmation_requested","actor_id":"299440b8-d2fd-4853-8a66-64c65112212a","actor_name":"Adam Peterson","actor_username":"adambpeterson@gmail.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-01-02 00:20:53.052024+00', ''),
	('00000000-0000-0000-0000-000000000000', '6889efd1-c16b-498a-91bd-119b481bce86', '{"action":"user_signedup","actor_id":"188d3d8e-b491-47d8-8622-0ee29130ca75","actor_name":"TEst TEst","actor_username":"falablea@test.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-01-02 00:27:38.015194+00', ''),
	('00000000-0000-0000-0000-000000000000', 'f1befbcd-c5b9-4006-b27f-4b76d516a7db', '{"action":"login","actor_id":"188d3d8e-b491-47d8-8622-0ee29130ca75","actor_name":"TEst TEst","actor_username":"falablea@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-01-02 00:27:38.021149+00', ''),
	('00000000-0000-0000-0000-000000000000', 'a7b85ba2-0ce4-4948-abe9-4a2ec10e005d', '{"action":"user_signedup","actor_id":"128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44","actor_name":"jeremy test","actor_username":"test@test.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-01-02 00:27:52.830924+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e89d8eaa-f701-4d71-ba38-c997633f08fe', '{"action":"login","actor_id":"128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44","actor_name":"jeremy test","actor_username":"test@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-01-02 00:27:52.835244+00', ''),
	('00000000-0000-0000-0000-000000000000', '5444399a-056e-46b9-9e92-e93910937be2', '{"action":"user_repeated_signup","actor_id":"128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44","actor_name":"jeremy test","actor_username":"test@test.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-01-02 00:28:09.51339+00', ''),
	('00000000-0000-0000-0000-000000000000', '20eae7b3-b6fe-4c75-a3be-c0a35558a761', '{"action":"user_signedup","actor_id":"7730b135-0a4c-43a9-8974-3aef47e1dd5a","actor_name":"jeremy testtube","actor_username":"testtube@test.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-01-02 00:28:18.963962+00', ''),
	('00000000-0000-0000-0000-000000000000', '7e97f6f3-879f-4a8a-9e2f-bfd2df4cc80b', '{"action":"login","actor_id":"7730b135-0a4c-43a9-8974-3aef47e1dd5a","actor_name":"jeremy testtube","actor_username":"testtube@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-01-02 00:28:18.967069+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e4716459-bb9a-48e3-98d9-af4a39a6b455', '{"action":"user_repeated_signup","actor_id":"7730b135-0a4c-43a9-8974-3aef47e1dd5a","actor_name":"jeremy testtube","actor_username":"testtube@test.com","actor_via_sso":false,"log_type":"user","traits":{"provider":"email"}}', '2025-01-02 00:35:40.13786+00', ''),
	('00000000-0000-0000-0000-000000000000', '46d9643e-ff03-4670-9704-c04082de9a1a', '{"action":"user_signedup","actor_id":"731be116-8283-493e-b8b6-d90b2de95d31","actor_name":"jeremy testtubew","actor_username":"testtubew@test.com","actor_via_sso":false,"log_type":"team","traits":{"provider":"email"}}', '2025-01-02 00:35:45.171194+00', ''),
	('00000000-0000-0000-0000-000000000000', 'e8084583-3fe6-4055-99e3-49d08aa007b4', '{"action":"login","actor_id":"731be116-8283-493e-b8b6-d90b2de95d31","actor_name":"jeremy testtubew","actor_username":"testtubew@test.com","actor_via_sso":false,"log_type":"account","traits":{"provider":"email"}}', '2025-01-02 00:35:45.174914+00', '');


--
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."flow_state" ("id", "user_id", "auth_code", "code_challenge_method", "code_challenge", "provider_type", "provider_access_token", "provider_refresh_token", "created_at", "updated_at", "authentication_method", "auth_code_issued_at") VALUES
	('ace2785d-2831-42af-a082-46fea7f787a4', 'e475c835-2fa0-42aa-9b24-fd5ab6ed3795', 'c2bc208c-f7e8-4ff9-afe3-5081ce674a3d', 's256', 'mHRmHp_dkSSSzxu_9AZ0HpZs8uh6YG4JVVrTGO3iwMg', 'email', '', '', '2025-01-01 23:55:57.794274+00', '2025-01-01 23:55:57.794274+00', 'email/signup', NULL),
	('66c68ac8-40f3-4a6b-a99c-9e0cc47cc747', '299440b8-d2fd-4853-8a66-64c65112212a', '4a84d331-84d3-4c2d-a8cc-13623265ecea', 's256', 's1h5NCSkiBjswPO50jBkKZF_gyVD_7VAricp_sKVcuk', 'email', '', '', '2025-01-02 00:20:53.052703+00', '2025-01-02 00:20:53.052703+00', 'email/signup', NULL);


--
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."users" ("instance_id", "id", "aud", "role", "email", "encrypted_password", "email_confirmed_at", "invited_at", "confirmation_token", "confirmation_sent_at", "recovery_token", "recovery_sent_at", "email_change_token_new", "email_change", "email_change_sent_at", "last_sign_in_at", "raw_app_meta_data", "raw_user_meta_data", "is_super_admin", "created_at", "updated_at", "phone", "phone_confirmed_at", "phone_change", "phone_change_token", "phone_change_sent_at", "email_change_token_current", "email_change_confirm_status", "banned_until", "reauthentication_token", "reauthentication_sent_at", "is_sso_user", "deleted_at", "is_anonymous") VALUES
	('00000000-0000-0000-0000-000000000000', '128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44', 'authenticated', 'authenticated', 'test@test.com', '$2a$10$anL/C2q.RyS8Yxf.npV63u5oHefkCf83AVbnqcp9dX4RGqsyg.z1G', '2025-01-02 00:27:52.832087+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-01-02 00:27:52.836417+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44", "email": "test@test.com", "full_name": "jeremy test", "email_verified": true, "phone_verified": false}', NULL, '2025-01-02 00:27:52.824097+00', '2025-01-02 00:27:52.838587+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '299440b8-d2fd-4853-8a66-64c65112212a', 'authenticated', 'authenticated', 'adambpeterson@gmail.com', '$2a$10$nB0WnSbpMtVJ948NZpZ9devlhbjXCDWZleOd2h2Fpf2PM20hRTSnW', NULL, NULL, 'pkce_b58bcc2f8c1e332c6ab047a3eec38aa1fc90ad27cdaf5a2421f34594', '2025-01-02 00:20:53.057356+00', '', NULL, '', '', NULL, NULL, '{"provider": "email", "providers": ["email"]}', '{"sub": "299440b8-d2fd-4853-8a66-64c65112212a", "email": "adambpeterson@gmail.com", "full_name": "Adam Peterson", "email_verified": false, "phone_verified": false}', NULL, '2025-01-02 00:20:53.037609+00', '2025-01-02 00:20:54.230571+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '731be116-8283-493e-b8b6-d90b2de95d31', 'authenticated', 'authenticated', 'testtubew@test.com', '$2a$10$RUZ7PENY/lnNEoEN2A9t7.3sOrVz8uM6Q0HYxamaD5VGv0HXBuvqe', '2025-01-02 00:35:45.171648+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-01-02 00:35:45.175372+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "731be116-8283-493e-b8b6-d90b2de95d31", "email": "testtubew@test.com", "full_name": "jeremy testtubew", "email_verified": true, "phone_verified": false}', NULL, '2025-01-02 00:35:45.157217+00', '2025-01-02 00:35:45.177573+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '7730b135-0a4c-43a9-8974-3aef47e1dd5a', 'authenticated', 'authenticated', 'testtube@test.com', '$2a$10$QO64d/hJIRuCxTuZYTqcNelZ/LYeF.Qy0y/IOWWtyBL5hsCSdkiBy', '2025-01-02 00:28:18.964468+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-01-02 00:28:18.967545+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "7730b135-0a4c-43a9-8974-3aef47e1dd5a", "email": "testtube@test.com", "full_name": "jeremy testtube", "email_verified": true, "phone_verified": false}', NULL, '2025-01-02 00:28:18.959236+00', '2025-01-02 00:28:18.969089+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false),
	('00000000-0000-0000-0000-000000000000', '188d3d8e-b491-47d8-8622-0ee29130ca75', 'authenticated', 'authenticated', 'falablea@test.com', '$2a$10$2.x6jjG0uJZIK1cHSkhT0e6LJpxyDGwUKjLiFd92ZeVKPR5Vr1wfa', '2025-01-02 00:27:38.015994+00', NULL, '', NULL, '', NULL, '', '', NULL, '2025-01-02 00:27:38.021718+00', '{"provider": "email", "providers": ["email"]}', '{"sub": "188d3d8e-b491-47d8-8622-0ee29130ca75", "email": "falablea@test.com", "full_name": "TEst TEst", "email_verified": true, "phone_verified": false}', NULL, '2025-01-02 00:27:37.905881+00', '2025-01-02 00:27:38.032306+00', NULL, NULL, '', '', NULL, '', 0, NULL, '', NULL, false, NULL, false);


--
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."identities" ("provider_id", "user_id", "identity_data", "provider", "last_sign_in_at", "created_at", "updated_at", "id") VALUES
	('299440b8-d2fd-4853-8a66-64c65112212a', '299440b8-d2fd-4853-8a66-64c65112212a', '{"sub": "299440b8-d2fd-4853-8a66-64c65112212a", "email": "adambpeterson@gmail.com", "full_name": "Adam Peterson", "email_verified": false, "phone_verified": false}', 'email', '2025-01-02 00:20:53.047483+00', '2025-01-02 00:20:53.048177+00', '2025-01-02 00:20:53.048177+00', '1750ee99-d484-4bd7-8422-db24c2cfc443'),
	('188d3d8e-b491-47d8-8622-0ee29130ca75', '188d3d8e-b491-47d8-8622-0ee29130ca75', '{"sub": "188d3d8e-b491-47d8-8622-0ee29130ca75", "email": "falablea@test.com", "full_name": "TEst TEst", "email_verified": false, "phone_verified": false}', 'email', '2025-01-02 00:27:38.001776+00', '2025-01-02 00:27:38.00184+00', '2025-01-02 00:27:38.00184+00', '14798104-c310-4058-bc12-f6d7de414531'),
	('128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44', '128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44', '{"sub": "128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44", "email": "test@test.com", "full_name": "jeremy test", "email_verified": false, "phone_verified": false}', 'email', '2025-01-02 00:27:52.827232+00', '2025-01-02 00:27:52.827273+00', '2025-01-02 00:27:52.827273+00', '3b36cd17-cff3-40ff-81d1-66a5725cc77c'),
	('7730b135-0a4c-43a9-8974-3aef47e1dd5a', '7730b135-0a4c-43a9-8974-3aef47e1dd5a', '{"sub": "7730b135-0a4c-43a9-8974-3aef47e1dd5a", "email": "testtube@test.com", "full_name": "jeremy testtube", "email_verified": false, "phone_verified": false}', 'email', '2025-01-02 00:28:18.962003+00', '2025-01-02 00:28:18.962047+00', '2025-01-02 00:28:18.962047+00', '94116599-8a7c-4a3a-ab25-35cb5fa689df'),
	('731be116-8283-493e-b8b6-d90b2de95d31', '731be116-8283-493e-b8b6-d90b2de95d31', '{"sub": "731be116-8283-493e-b8b6-d90b2de95d31", "email": "testtubew@test.com", "full_name": "jeremy testtubew", "email_verified": false, "phone_verified": false}', 'email', '2025-01-02 00:35:45.168682+00', '2025-01-02 00:35:45.168729+00', '2025-01-02 00:35:45.168729+00', '71fd1c50-1e39-400c-9c7a-ffd793529e95');


--
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."sessions" ("id", "user_id", "created_at", "updated_at", "factor_id", "aal", "not_after", "refreshed_at", "user_agent", "ip", "tag") VALUES
	('ece93068-7bc9-41e0-a724-cae654ea3500', '188d3d8e-b491-47d8-8622-0ee29130ca75', '2025-01-02 00:27:38.022401+00', '2025-01-02 00:27:38.022401+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Safari/605.1.15', '98.35.199.33', NULL),
	('0c381b29-2486-485e-8a89-7c2c48f95f97', '128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44', '2025-01-02 00:27:52.836504+00', '2025-01-02 00:27:52.836504+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Safari/605.1.15', '98.35.199.33', NULL),
	('3bc30365-4fd8-44eb-a3f4-c7a0a2e109d6', '7730b135-0a4c-43a9-8974-3aef47e1dd5a', '2025-01-02 00:28:18.967614+00', '2025-01-02 00:28:18.967614+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Safari/605.1.15', '98.35.199.33', NULL),
	('b99b5157-805d-4cf0-ae83-4e2f583c2bee', '731be116-8283-493e-b8b6-d90b2de95d31', '2025-01-02 00:35:45.175447+00', '2025-01-02 00:35:45.175447+00', NULL, 'aal1', NULL, NULL, 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.2 Safari/605.1.15', '98.35.199.33', NULL);


--
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."mfa_amr_claims" ("session_id", "created_at", "updated_at", "authentication_method", "id") VALUES
	('ece93068-7bc9-41e0-a724-cae654ea3500', '2025-01-02 00:27:38.032801+00', '2025-01-02 00:27:38.032801+00', 'password', 'a86a4e90-a125-447d-9adc-25afc8d80588'),
	('0c381b29-2486-485e-8a89-7c2c48f95f97', '2025-01-02 00:27:52.838859+00', '2025-01-02 00:27:52.838859+00', 'password', 'b1114b96-a21e-4254-83be-4347a2d0a200'),
	('3bc30365-4fd8-44eb-a3f4-c7a0a2e109d6', '2025-01-02 00:28:18.969394+00', '2025-01-02 00:28:18.969394+00', 'password', '872597e6-eaba-4348-9ea9-576053cbb5fa'),
	('b99b5157-805d-4cf0-ae83-4e2f583c2bee', '2025-01-02 00:35:45.177979+00', '2025-01-02 00:35:45.177979+00', 'password', 'afb016d9-c655-45d3-b291-1cc56ae0ea84');


--
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."one_time_tokens" ("id", "user_id", "token_type", "token_hash", "relates_to", "created_at", "updated_at") VALUES
	('7a54c374-be0f-45d5-b420-3d34d63d58d5', '299440b8-d2fd-4853-8a66-64c65112212a', 'confirmation_token', 'pkce_b58bcc2f8c1e332c6ab047a3eec38aa1fc90ad27cdaf5a2421f34594', 'adambpeterson@gmail.com', '2025-01-02 00:20:54.236858', '2025-01-02 00:20:54.236858');


--
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

INSERT INTO "auth"."refresh_tokens" ("instance_id", "id", "token", "user_id", "revoked", "created_at", "updated_at", "parent", "session_id") VALUES
	('00000000-0000-0000-0000-000000000000', 1, 'Iif4ZlP9L2sBB7SduxwACg', '188d3d8e-b491-47d8-8622-0ee29130ca75', false, '2025-01-02 00:27:38.026314+00', '2025-01-02 00:27:38.026314+00', NULL, 'ece93068-7bc9-41e0-a724-cae654ea3500'),
	('00000000-0000-0000-0000-000000000000', 2, 'KJeUoiTdtO_bhGtKEJznNA', '128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44', false, '2025-01-02 00:27:52.837111+00', '2025-01-02 00:27:52.837111+00', NULL, '0c381b29-2486-485e-8a89-7c2c48f95f97'),
	('00000000-0000-0000-0000-000000000000', 3, 'ZVN9IZ5qE8BynV3EwmPuFQ', '7730b135-0a4c-43a9-8974-3aef47e1dd5a', false, '2025-01-02 00:28:18.968238+00', '2025-01-02 00:28:18.968238+00', NULL, '3bc30365-4fd8-44eb-a3f4-c7a0a2e109d6'),
	('00000000-0000-0000-0000-000000000000', 4, 'cGibWWd8eM9jJh9yY34LbQ', '731be116-8283-493e-b8b6-d90b2de95d31', false, '2025-01-02 00:35:45.176303+00', '2025-01-02 00:35:45.176303+00', NULL, 'b99b5157-805d-4cf0-ae83-4e2f583c2bee');


--
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--



--
-- Data for Name: key; Type: TABLE DATA; Schema: pgsodium; Owner: supabase_admin
--



--
-- Data for Name: organizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."organizations" ("id", "name", "address", "created_at") VALUES
	('030b4f02-881a-4df6-9e27-e0f867403762', 'Default Organization', 'Default Address', '2025-01-02 00:20:53.037259+00');


--
-- Data for Name: shifts; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: coverage_requirements; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."roles" ("id", "name", "description", "created_at") VALUES
	('4d41957c-ec7a-4c9e-883e-bd9085069c75', 'user', 'Default user role', '2025-01-02 00:20:53.037259+00');


--
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."profiles" ("id", "full_name", "email", "avatar_url", "role_id", "organization_id", "weekly_hours_limit", "created_at", "updated_at") VALUES
	('299440b8-d2fd-4853-8a66-64c65112212a', 'Adam Peterson', 'adambpeterson@gmail.com', NULL, '4d41957c-ec7a-4c9e-883e-bd9085069c75', '030b4f02-881a-4df6-9e27-e0f867403762', 40, '2025-01-02 00:20:53.037259+00', '2025-01-02 00:20:53.037259+00'),
	('188d3d8e-b491-47d8-8622-0ee29130ca75', 'TEst TEst', 'falablea@test.com', NULL, '4d41957c-ec7a-4c9e-883e-bd9085069c75', '030b4f02-881a-4df6-9e27-e0f867403762', 40, '2025-01-02 00:27:37.903189+00', '2025-01-02 00:27:37.903189+00'),
	('128ec66d-94c1-4a2f-8e1d-4dfa7b4e9e44', 'jeremy test', 'test@test.com', NULL, '4d41957c-ec7a-4c9e-883e-bd9085069c75', '030b4f02-881a-4df6-9e27-e0f867403762', 40, '2025-01-02 00:27:52.823777+00', '2025-01-02 00:27:52.823777+00'),
	('7730b135-0a4c-43a9-8974-3aef47e1dd5a', 'jeremy testtube', 'testtube@test.com', NULL, '4d41957c-ec7a-4c9e-883e-bd9085069c75', '030b4f02-881a-4df6-9e27-e0f867403762', 40, '2025-01-02 00:28:18.958896+00', '2025-01-02 00:28:18.958896+00'),
	('731be116-8283-493e-b8b6-d90b2de95d31', 'jeremy testtubew', 'testtubew@test.com', NULL, '4d41957c-ec7a-4c9e-883e-bd9085069c75', '030b4f02-881a-4df6-9e27-e0f867403762', 40, '2025-01-02 00:35:45.156873+00', '2025-01-02 00:35:45.156873+00');


--
-- Data for Name: employee_availability; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: schedules; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: schedule_assignments; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: shift_swap_requests; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--



--
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: supabase_admin
--



--
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('"auth"."refresh_tokens_id_seq"', 4, true);


--
-- Name: key_key_id_seq; Type: SEQUENCE SET; Schema: pgsodium; Owner: supabase_admin
--

SELECT pg_catalog.setval('"pgsodium"."key_key_id_seq"', 1, false);


--
-- PostgreSQL database dump complete
--

RESET ALL;
