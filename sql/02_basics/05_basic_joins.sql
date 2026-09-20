-- ============================================================
-- POSTGIS SPATIAL ANALYSIS
-- 02 BASICS
-- 05 — BASIC JOINS
-- ============================================================
--
-- Purpose:
-- Learn how to combine information stored across related
-- PostgreSQL tables using relational keys.
--
-- Decision-support context:
-- Risk information is rarely stored in a single table.
--
-- In this demonstration database:
--
--   events describe what happened
--   assets describe what was affected
--   operational areas provide geographic and exposure context
--
-- The relationships are:
--
--   risk.events
--       │
--       │ asset_id
--       ▼
--   risk.assets
--       │
--       │ area_id
--       ▼
--   spatial.operational_areas
--
-- Joins allow these separate pieces of information to be
-- combined without duplicating them in the source database.
--
-- Database: georisk_lab
--
-- ============================================================


-- ============================================================
-- 01. JOIN EVENTS TO ASSETS
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   asset_name
--   asset_type
--
-- Tables:
--   risk.events
--   risk.assets
--
-- Relationship:
--
--   events.asset_id = assets.asset_id
--
-- New SQL:
--   INNER JOIN
--   ON
--
-- General pattern:
--
--   SELECT
--       ...
--   FROM table_a
--   INNER JOIN table_b
--       ON table_a.key = table_b.key;
--
-- Table aliases:
--
--   Use:
--
--       e  = risk.events
--       a  = risk.assets
--
-- Example alias syntax:
--
--   FROM risk.events AS e
--
-- Once a table has an alias, columns can be referenced as:
--
--   e.event_id
--   a.asset_name
--
-- Decision-support question:
--   Which assets are associated with recorded events?
--
-- Write query below:

SELECT
    event_id,
    event_date,
    event_type,
    asset_name,
    asset_type
FROM risk.events AS e
INNER JOIN risk.assets AS a
    ON e.asset_id = a.asset_id;


-- ============================================================
-- 02. CHECK THE INNER JOIN POPULATION
-- ============================================================
--
-- Count the number of rows returned when risk.events is
-- INNER JOINED to risk.assets.
--
-- Return:
--   joined_events
--
-- Think before running:
--
--   risk.events contains 22 records.
--
--   Two events have NULL asset_id values.
--
-- Question:
--   How many rows do you expect an INNER JOIN to return?
--
-- Why?
--
-- Write query below:

SELECT
    COUNT(*) AS joined_events
FROM risk.events AS e
INNER JOIN risk.assets AS a
    ON e.asset_id = a.asset_id;


-- ============================================================
-- 03. PRESERVE ALL EVENTS WITH LEFT JOIN
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   asset_id
--   asset_name
--
-- New SQL:
--   LEFT JOIN
--
-- Join:
--
--   risk.events AS e
--       to
--   risk.assets AS a
--
-- using:
--
--   e.asset_id = a.asset_id
--
-- Important:
--
--   LEFT JOIN preserves every record from the table on the
--   LEFT side of the join.
--
-- In this exercise:
--
--   risk.events is the left table.
--
-- Therefore events without a matching asset should remain
-- visible in the result.
--
-- Decision-support question:
--   How can we retain events with uncertain asset attribution
--   while still adding asset information where available?
--
-- Write query below:

SELECT
    e.event_id,
    e.event_date,
    e.event_type,
    e.asset_id,
    a.asset_name
FROM risk.events AS e
LEFT JOIN risk.assets AS a
    ON e.asset_id = a.asset_id;


-- ============================================================
-- 04. FIND UNATTRIBUTED EVENTS USING A LEFT JOIN
-- ============================================================
--
-- Return:
--   event_id
--   event_date
--   event_type
--   asset_name
--
-- Use:
--   LEFT JOIN
--
-- Then return only records where no matching asset exists.
--
-- Hint:
--
--   After the join, consider which column from risk.assets
--   will be NULL when no asset record was matched.
--
-- Decision-support question:
--   Which events cannot currently be linked to an asset record?
--
-- Write query below:

SELECT
    e.event_id,
    e.event_date,
    e.event_type,
    a.asset_name
FROM risk.events AS e
LEFT JOIN risk.assets AS a
    ON e.asset_id = a.asset_id
WHERE a.asset_id IS NULL;


-- ============================================================
-- 05. JOIN EVENTS TO ASSETS AND OPERATIONAL AREAS
-- ============================================================
--
-- Now connect all three tables.
--
-- Return:
--   event_id
--   event_date
--   event_type
--   asset_name
--   asset_type
--   area_name
--   region
--   exposure_index
--
-- Relationships:
--
--   events.asset_id = assets.asset_id
--
--   assets.area_id = operational_areas.area_id
--
-- Suggested aliases:
--
--   e  = risk.events
--   a  = risk.assets
--   oa = spatial.operational_areas
--
-- Conceptually:
--
--   event
--      ↓
--   asset
--      ↓
--   operational area
--
-- Use INNER JOIN for this exercise.
--
-- Decision-support question:
--   What operational and geographic context can be attached
--   to events through the relational model?
--
-- Write query below:

SELECT
    e.event_id,
    e.event_date,
    e.event_type,
    a.asset_name,
    a.asset_type,
    oa.area_name,
    oa.region,
    oa.exposure_index
FROM 
    risk.events AS e
INNER JOIN 
    risk.assets AS a ON e.asset_id = a.asset_id
INNER JOIN 
    spatial.operational_areas AS oa ON a.area_id = oa.area_id;


-- ============================================================
-- 06. COUNT EVENTS BY OPERATIONAL AREA
-- ============================================================
--
-- Using the three-table relationship:
--
--   events
--      ↓
--   assets
--      ↓
--   operational areas
--
-- Return:
--   area_name
--   event_count
--
-- Group by:
--   area_name
--
-- Sort:
--   highest event count first.
--
-- Required concepts:
--   JOIN
--   COUNT()
--   GROUP BY
--   ORDER BY
--
-- Decision-support question:
--   How are attributed events distributed across operational
--   areas?
--
-- Write query below:

SELECT
    oa.area_name,
    COUNT(e.event_id) AS event_count
FROM 
    risk.events AS e
INNER JOIN 
    risk.assets AS a ON e.asset_id = a.asset_id
INNER JOIN 
    spatial.operational_areas AS oa ON a.area_id = oa.area_id
GROUP BY 
    oa.area_name
ORDER BY 
    event_count DESC;



-- ============================================================
-- 07. THE ZERO-EVENT AREA PROBLEM
-- ============================================================
--
-- Look carefully at the result from Exercise 06.
--
-- Question:
--
--   Does every operational area appear?
--
-- We deliberately created an operational area containing
-- assets but no recorded events.
--
-- An event-led INNER JOIN cannot return that area because
-- there is no event row from which to begin.
--
-- Challenge:
--
-- Rewrite the analysis so that ALL operational areas remain
-- visible, including areas with zero events.
--
-- Think carefully about:
--
--   Which table should be on the LEFT?
--
-- Join direction:
--
--   operational areas
--          ↓
--       assets
--          ↓
--       events
--
-- Use:
--   LEFT JOIN
--
-- Return:
--   area_name
--   event_count
--
-- Sort:
--   highest event count first.
--
-- Important:
--
--   Think carefully about what should be passed to COUNT().
--
--   COUNT(*) and COUNT(event_id) may behave differently after
--   a LEFT JOIN.
--
-- Do not assume zero-event locations are unimportant simply
-- because an event-led query does not return them.
--
-- Write query below:

SELECT
    oa.area_name,
    COUNT(e.event_id) AS event_count
FROM spatial.operational_areas AS oa
LEFT JOIN risk.assets AS a
    ON oa.area_id = a.area_id
LEFT JOIN risk.events AS e
    ON a.asset_id = e.asset_id
GROUP BY
    oa.area_name
ORDER BY
    event_count DESC;


-- ============================================================
-- 08. MINI ANALYTICAL CHALLENGE
-- ============================================================
--
-- Produce an operational-area summary containing:
--
--   area_name
--   region
--   exposure_index
--   asset_count
--   event_count
--   total_estimated_cost
--   total_downtime_hours
--
-- Requirements:
--
--   Every operational area must remain in the result,
--   including areas with zero events.
--
-- Sort:
--   highest event_count first.
--
-- Think about:
--
--   Which table should drive the query?
--
--   Which joins should preserve records?
--
--   Which fields should be counted?
--
--   How will NULL aggregate results behave for areas with
--   no events?
--
-- Do not worry if this one takes some experimentation.
--
-- It combines most of the SQL concepts from 02_basics.
--
-- Write query below:

SELECT
    oa.area_name,
    oa.region,
    oa.exposure_index,
    COUNT(DISTINCT a.asset_id) AS asset_count,
    COUNT(e.event_id) AS event_count,
    COALESCE(SUM(e.estimated_cost), 0) AS total_estimated_cost,
    COALESCE(SUM(e.downtime_hours), 0) AS total_downtime_hours
FROM spatial.operational_areas AS oa
LEFT JOIN risk.assets AS a
    ON oa.area_id = a.area_id
LEFT JOIN risk.events AS e
    ON a.asset_id = e.asset_id
GROUP BY
    oa.area_name,
    oa.region,
    oa.exposure_index
ORDER BY
    event_count DESC;


-- ============================================================
-- KEY CONCEPTS
-- ============================================================
--
-- JOIN
--   Combines related records from multiple tables.
--
-- ON
--   Defines the relationship used to match records.
--
-- INNER JOIN
--   Returns records where a matching row exists in both
--   participating tables.
--
-- LEFT JOIN
--   Preserves every record from the left-hand table and adds
--   matching information from the right-hand table where
--   available.
--
-- TABLE ALIASES
--
--   risk.events AS e
--
-- allows:
--
--   e.event_id
--
-- instead of repeatedly writing:
--
--   risk.events.event_id
--
--
-- ============================================================
-- JOIN CHOICE IS AN ANALYTICAL DECISION
-- ============================================================
--
-- INNER JOIN:
--
--   events ── matching assets
--
--   Events without asset attribution disappear.
--
--
-- LEFT JOIN:
--
--   all events ── matching assets where available
--
--   Events without asset attribution remain visible.
--
--
-- The technically valid query is not necessarily the
-- analytically appropriate query.
--
-- Always ask:
--
--   What population should this analysis preserve?
--
--
-- ============================================================
-- IMPORTANT COUNTING BEHAVIOUR
-- ============================================================
--
-- After a LEFT JOIN:
--
--   COUNT(*)
--
-- counts result rows.
--
-- But:
--
--   COUNT(e.event_id)
--
-- counts only rows containing a matched event_id.
--
-- This distinction is essential when representing locations
-- with zero recorded events.
--
--
-- ============================================================
-- DECISION-SUPPORT PROGRESSION
-- ============================================================
--
--   Events
--      ↓
--   Assets
--      ↓
--   Operational context
--      ↓
--   Geographic comparison
--      ↓
--   Preserve zero-event locations
--      ↓
--   Understand analytical population
--
--
-- ============================================================
-- RELATIONAL SQL → SPATIAL SQL
-- ============================================================
--
-- At this stage geographic attribution is relational:
--
--   event.asset_id
--       ↓
--   asset.area_id
--       ↓
--   operational_area
--
-- Later, after geometry is introduced, PostGIS will allow us
-- to determine geographic relationships directly:
--
--   event point
--       ↓
--   spatial relationship
--       ↓
--   operational area polygon
--
-- This will allow relational attribution and spatial
-- attribution to be compared as a QA process.
--
--
-- END OF 02 BASICS
--
-- Next:
--
--   Build the SQL Basics tutorial / vignette.
--
-- ============================================================