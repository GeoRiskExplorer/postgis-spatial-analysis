-- ============================================================
-- POSTGIS SPATIAL ANALYSIS
-- 02 — SCHEMA SETUP
-- ============================================================
--
-- Purpose:
-- Create logical schemas for the GeoRisk demonstration
-- database and inspect PostgreSQL's schema search path.
--
-- Database: georisk_lab
--
-- ============================================================


-- ============================================================
-- 01. CHECK CURRENT SCHEMA
-- ============================================================

SELECT
    current_database() AS database_name,
    current_schema() AS current_schema;


-- ============================================================
-- 02. CHECK CURRENT SEARCH PATH
-- ============================================================

SHOW search_path;


-- ============================================================
-- 03. CREATE PROJECT SCHEMAS
-- ============================================================

CREATE SCHEMA IF NOT EXISTS risk;

CREATE SCHEMA IF NOT EXISTS spatial;


-- ============================================================
-- 04. VERIFY SCHEMAS
-- ============================================================

SELECT
    schema_name
FROM information_schema.schemata
WHERE schema_name IN ('public', 'risk', 'spatial')
ORDER BY schema_name;


-- ============================================================
-- 05. INSPECT SCHEMA OWNERSHIP
-- ============================================================

SELECT
    nspname AS schema_name,
    pg_get_userbyid(nspowner) AS owner_name
FROM pg_namespace
WHERE nspname IN ('public', 'risk', 'spatial')
ORDER BY nspname;