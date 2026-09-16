-- ============================================================
-- POSTGIS SPATIAL ANALYSIS
-- 02 BASICS
-- 01 — SELECT
-- ============================================================
--
-- Purpose:
-- Introduce SELECT queries and learn how to retrieve complete
-- records or specific columns from PostgreSQL tables.
--
-- Decision-support context:
-- Before analysing risk, we need to understand what information
-- exists, how it is structured, and which fields are relevant
-- to the analytical question.
--
-- Database: georisk_lab
--
-- ============================================================


-- ============================================================
-- 01. SELECT ALL COLUMNS
-- ============================================================
--
-- Return:
--   all columns from risk.events.
--
-- New SQL:
--   SELECT
--   FROM
--   *
--
-- Important:
--
--   * means return every column from the table.
--
--   This is useful when initially inspecting a dataset, but
--   analytical queries should generally request only the
--   columns actually required.
--
-- Query:

SELECT *
FROM risk.events;


-- ============================================================
-- 02. SELECT SPECIFIC COLUMNS
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   consequence_level
--
-- New SQL:
--   selecting named columns
--
-- Important:
--
--   Columns are separated by commas.
--
--   Selecting only required fields makes the analytical intent
--   clearer and avoids returning unnecessary information.
--
-- Query:

SELECT
    event_id,
    event_date,
    event_type,
    consequence_level
FROM risk.events;


-- ============================================================
-- 03. ASSET INVENTORY
-- ============================================================
--
-- Return:
--   asset_name
--   asset_type
--   criticality
--   replacement_value
--
-- Source:
--   risk.assets
--
-- Decision-support question:
--   What asset information is available to describe potential
--   exposure and consequence?
--
-- Query:

SELECT
    asset_name,
    asset_type,
    criticality,
    replacement_value
FROM risk.assets;


-- ============================================================
-- 04. OPERATIONAL AREAS
-- ============================================================
--
-- Return:
--   area_name
--   region
--   exposure_index
--
-- Source:
--   spatial.operational_areas
--
-- Decision-support question:
--   What geographic areas and exposure information are
--   available for later spatial comparison?
--
-- Query:

SELECT
    area_name,
    region,
    exposure_index
FROM spatial.operational_areas;


-- ============================================================
-- 05. EVENT ANALYSIS FIELDS
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   consequence_level
--   downtime_hours
--   estimated_cost
--
-- Source:
--   risk.events
--
-- Decision-support question:
--   Which event fields could contribute to understanding event
--   occurrence, consequence and operational impact?
--
-- Query:

SELECT
    event_id,
    event_date,
    event_type,
    consequence_level,
    downtime_hours,
    estimated_cost
FROM risk.events;


-- ============================================================
-- KEY CONCEPTS
-- ============================================================
--
-- SELECT
--   Defines which columns should be returned.
--
-- FROM
--   Defines the table containing those columns.
--
-- *
--   Returns every column from the selected table.
--
-- General pattern:
--
--   SELECT
--       column_1,
--       column_2,
--       column_3
--   FROM schema.table;
--
-- At this stage SELECT retrieves information but does not
-- restrict which rows are returned.
--
-- Row filtering is introduced in:
--
--   02_filter_sort.sql
--
-- ============================================================