-- ============================================================
-- POSTGIS SPATIAL ANALYSIS
-- 02 BASICS
-- 02 — FILTER AND SORT
-- ============================================================
--
-- Purpose:
-- Filter records using WHERE and control result ordering
-- using ORDER BY.
--
-- Decision-support context:
-- Move from inspecting available information to identifying
-- subsets of events or assets that may warrant further
-- analysis.
--
-- Database: georisk_lab
--
-- ============================================================


-- ============================================================
-- 01. HIGHER-CONSEQUENCE EVENTS
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   consequence_level
--
-- Condition:
--   consequence_level is 4 or greater.
--
-- New SQL:
--   WHERE
--   >=
--
-- Write query below:

SELECT 
    event_id,
    event_date,
    event_type,
    consequence_level
FROM risk.events
WHERE consequence_level >= 4;


-- ============================================================
-- 02. HIGH-VALUE ASSETS
-- ============================================================
--
-- Return:
--   asset_name
--   asset_type
--   criticality
--   replacement_value
--
-- Condition:
--   replacement_value is greater than $10,000,000.
--
-- New SQL:
--   >
--
-- Write query below:

SELECT 
    asset_name,
    asset_type,
    criticality,
   replacement_value
FROM risk.assets
WHERE replacement_value >= 10000000;


-- ============================================================
-- 03. FILTER BY EVENT TYPE
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   consequence_level
--   estimated_cost
--
-- Condition:
--   event_type is exactly 'Equipment Failure'.
--
-- New SQL:
--   =
--
-- Remember:
--   SQL text values use single quotes.
--
-- Write query below:

SELECT 
    event_id,
    event_date,
    event_type,
    consequence_level,
    estimated_cost
FROM risk.events
WHERE event_type = 'Equipment Failure';


-- ============================================================
-- 04. FILTER MULTIPLE EVENT TYPES
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   consequence_level
--
-- Condition:
--   event_type is either:
--     Vehicle Incident
--     Near Miss
--
-- New SQL:
--   IN (...)
--
-- General pattern:
--
--   WHERE column_name IN ('value_1', 'value_2')
--
-- Write query below:

SELECT 
    event_id,
    event_date,
    event_type,
    consequence_level
FROM risk.events
WHERE event_type IN ('Vehicle Incident', 'Near Miss');

-- ============================================================
-- 05. FIND MISSING ASSET ATTRIBUTION
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   asset_id
--   description
--
-- Condition:
--   asset_id is missing.
--
-- New SQL:
--   IS NULL
--
-- Important:
--
--   NULL represents the absence of a known value.
--
--   Do NOT use:
--
--       asset_id = NULL
--
-- Write query below:

SELECT 
    event_id,
    event_date,
    event_type,
    asset_id,
    description
FROM risk.events
WHERE asset_id IS NULL;


-- ============================================================
-- 06. PRIORITISE HIGHER-CONSEQUENCE EVENTS
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   consequence_level
--   estimated_cost
--
-- Conditions:
--   consequence_level is 4 or greater.
--
-- Sort:
--   1. highest consequence first
--   2. within equal consequence levels, most recent event first
--
-- New SQL:
--   ORDER BY
--   DESC
--
-- General pattern:
--
--   ORDER BY
--       column_1 DESC,
--       column_2 DESC;
--
-- Write query below:

SELECT 
    event_id,
    event_date,
    event_type,
    consequence_level,
    estimated_cost
FROM risk.events
WHERE consequence_level >= 4
ORDER BY 
    consequence_level DESC,
    event_date DESC;


