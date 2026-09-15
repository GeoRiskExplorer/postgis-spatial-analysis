-- ============================================================
-- POSTGIS SPATIAL ANALYSIS
-- 01 — ENVIRONMENT CHECK
-- ============================================================
--
-- Purpose:
-- Verify the PostgreSQL / PostGIS environment used by this
-- project.
--
-- Database: georisk_lab
--
-- ============================================================


-- ============================================================
-- 01. CURRENT CONNECTION
-- ============================================================

SELECT
    current_database() AS database_name,
    current_user AS user_name,
    current_schema() AS current_schema,
    current_setting('server_version') AS postgres_version;


-- ============================================================
-- 02. DATABASE COLLATION
-- ============================================================

SELECT
    datname AS database_name,
    datcollversion AS recorded_collation,
    pg_database_collation_actual_version(oid) AS actual_collation
FROM pg_database
WHERE datname = current_database();


-- ============================================================
-- 03. POSTGIS VERSION
-- ============================================================

SELECT PostGIS_Version();


-- ============================================================
-- 04. INSTALLED EXTENSIONS
-- ============================================================

SELECT
    extname AS extension_name,
    extversion AS extension_version
FROM pg_extension
ORDER BY extname;