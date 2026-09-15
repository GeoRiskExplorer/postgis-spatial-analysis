-- ============================================================
-- POSTGIS SPATIAL ANALYSIS
-- 02 BASICS
-- 01 — SELECT
-- ============================================================
--
-- Purpose:
-- Introduce SELECT queries and learn how to retrieve specific
-- columns from PostgreSQL tables.
--
-- Decision-support context:
-- Before analysing risk, we need to understand what information
-- exists, its structure, and the records available for analysis.
--
-- Database: georisk_lab
--
-- ============================================================


-- ============================================================
-- 01. SELECT ALL COLUMNS
-- ============================================================

SELECT *
FROM risk.events;


-- ============================================================
-- 02. SELECT SPECIFIC COLUMNS
-- ============================================================

SELECT
    event_id,
    event_date,
    event_type,
    consequence_level
FROM risk.events;

-- ============================================================
-- 03. Asset inventory
-- ============================================================

SELECT
    asset_name,
    asset_type,
    criticality,
    replacement_value
FROM risk.assets;

-- ============================================================
-- 04. Operational areas
-- ============================================================

SELECT
    area_name,
    region,
    exposure_index
FROM spatial.operational_areas;

-- ============================================================
-- 05. Event analysis fields
-- ============================================================

SELECT
    event_id,
    event_date,
    event_type,
    consequence_level,
    downtime_hours,
    estimated_cost
FROM risk.events;