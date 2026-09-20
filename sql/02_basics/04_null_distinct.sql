-- ============================================================
-- POSTGIS SPATIAL ANALYSIS
-- 02 BASICS
-- 04 — NULL AND DISTINCT VALUES
-- ============================================================
--
-- Purpose:
-- Understand missing values, identify unique values, and learn
-- simple approaches for handling NULL values in query outputs.
--
-- Decision-support context:
-- Risk and spatial datasets are rarely complete.
--
-- Missing attribution, incomplete measurements and unknown
-- values need to remain visible rather than being accidentally
-- excluded or interpreted as zero.
--
-- We also frequently need to understand the categories and
-- values present in a dataset before analysing them.
--
-- Database: georisk_lab
--
-- ============================================================


-- ============================================================
-- 01. IDENTIFY MISSING ASSET ATTRIBUTION
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   asset_id
--
-- Condition:
--   asset_id is missing.
--
-- SQL:
--   IS NULL
--
-- Important:
--
--   NULL means that a value is absent or unknown.
--
--   NULL is not:
--     zero
--     an empty string
--     FALSE
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
    asset_id
FROM RISK.events
WHERE asset_id IS NULL;


-- ============================================================
-- 02. IDENTIFY EVENTS WITH ASSET ATTRIBUTION
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   asset_id
--
-- Condition:
--   asset_id has a value.
--
-- New SQL:
--   IS NOT NULL
--
-- Decision-support question:
--   Which events currently have sufficient relational
--   information to connect them directly to an asset?
--
-- Write query below:

SELECT
    event_id,
    event_date,
    event_type,
    asset_id
FROM RISK.events
WHERE asset_id IS NOT NULL;


-- ============================================================
-- 03. COMPARE TOTAL AND ATTRIBUTED EVENTS
-- ============================================================
--
-- Return:
--   total_events
--   events_with_asset
--
-- Use:
--   COUNT(*)
--   COUNT(asset_id)
--
-- Important:
--
--   COUNT(*) counts rows.
--
--   COUNT(column_name) counts only rows where that column
--   is NOT NULL.
--
-- This provides a simple data-completeness check.
--
-- Write query below:


SELECT
    COUNT(*) AS total_events,
    COUNT(asset_id) AS events_with_asset
FROM RISK.events;



-- ============================================================
-- 04. FIND UNIQUE EVENT TYPES
-- ============================================================
--
-- Return:
--   each unique event_type once.
--
-- New SQL:
--   DISTINCT
--
-- General pattern:
--
--   SELECT DISTINCT column_name
--   FROM schema.table;
--
-- Sort:
--   event_type alphabetically.
--
-- Decision-support question:
--   What event categories currently exist in the dataset?
--
-- Write query below:

SELECT
    DISTINCT event_type
FROM RISK.events;


-- ============================================================
-- 05. FIND UNIQUE ASSET TYPES
-- ============================================================
--
-- Return:
--   each unique asset_type once.
--
-- Source:
--   risk.assets
--
-- Sort:
--   asset_type alphabetically.
--
-- Use:
--   DISTINCT
--
-- Write query below:

SELECT
    DISTINCT asset_type
FROM RISK.assets
ORDER BY asset_type ASC;



-- ============================================================
-- 06. REPLACE NULL FOR DISPLAY
-- ============================================================
--
-- Return:
--   event_id
--   event_type
--   asset_id
--   description
--
-- For description:
--   display 'No description recorded' when description is NULL.
--
-- New SQL:
--   COALESCE()
--
-- General pattern:
--
--   COALESCE(column_name, replacement_value)
--
-- COALESCE returns the first non-NULL value.
--
-- Alias the resulting description column as:
--
--   event_description
--
-- Important:
--
--   COALESCE does NOT change the stored source data.
--
--   It changes how the value is represented in the query
--   result.
--
-- Write query below:

SELECT 
    event_id,
    event_type,
    asset_id,
    COALESCE(description, 'No description recorded') AS description
FROM risk.events;


-- ============================================================
-- 07. MINI QA CHALLENGE
-- ============================================================
--
-- Produce one row containing:
--
--   total_events
--   events_with_asset
--   events_without_asset
--
-- You already know how to calculate:
--
--   total_events
--   events_with_asset
--
-- Challenge:
--
--   Can you derive events_without_asset from those two
--   calculations?
--
-- Hint:
--
--   aggregate expressions can participate in arithmetic.
--
-- Decision-support question:
--   How complete is asset attribution within the event data?
--
-- Write query below:

SELECT
    COUNT(*) AS total_events,
    COUNT(asset_id) AS events_with_asset,
    COUNT(*) - COUNT(asset_id) AS events_without_asset   
FROM risk.events;


-- ============================================================
-- KEY CONCEPTS
-- ============================================================
--
-- NULL
--   Represents an absent or unknown value.
--
-- IS NULL
--   Finds records where a value is missing.
--
-- IS NOT NULL
--   Finds records where a value is present.
--
-- COUNT(*)
--   Counts all rows.
--
-- COUNT(column)
--   Counts non-NULL values in that column.
--
-- DISTINCT
--   Returns unique values or combinations of values.
--
-- COALESCE()
--   Returns the first non-NULL value from a supplied sequence.
--
--
-- IMPORTANT ANALYTICAL PRINCIPLE
--
-- Missing information should not automatically be treated as
-- zero or absence of risk.
--
-- For example:
--
--   asset_id IS NULL
--
-- means:
--
--   asset attribution is currently unknown
--
-- not:
--
--   the event had no relationship to an asset.
--
-- Preserving this distinction becomes increasingly important
-- when analysing uncertainty and data quality.
--
--
-- DECISION-SUPPORT PROGRESSION
--
--   Inspect records
--         ↓
--   Identify missing information
--         ↓
--   Measure completeness
--         ↓
--   Inspect available categories
--         ↓
--   Preserve uncertainty
--         ↓
--   Prepare reliable data for analysis
--
--
-- NEXT:
--
--   05_basic_joins.sql
--
-- Connect events, assets and operational areas using
-- relational keys.
--
-- ============================================================