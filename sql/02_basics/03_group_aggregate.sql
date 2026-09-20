-- ============================================================
-- POSTGIS SPATIAL ANALYSIS
-- 02 BASICS
-- 03 — GROUP AND AGGREGATE
-- ============================================================
--
-- Purpose:
-- Introduce SQL aggregation and learn how individual records
-- can be summarised into analytical information.
--
-- Decision-support context:
-- Individual event records tell us what happened.
--
-- Aggregation allows us to ask broader questions such as:
--
--   How many events occurred?
--   What types of events are most common?
--   What financial impact has been recorded?
--   How much operational disruption occurred?
--   Do some categories show greater consequence than others?
--
-- These summaries form an important foundation for later
-- comparison, spatial analysis and risk evaluation.
--
-- Database: georisk_lab
--
-- ============================================================


-- ============================================================
-- 01. COUNT ALL EVENTS
-- ============================================================
--
-- Return:
--   total number of records in risk.events.
--
-- New SQL:
--   COUNT()
--
-- General pattern:
--
--   SELECT COUNT(*)
--   FROM schema.table;
--
-- COUNT(*) counts rows.
--
-- Alias the resulting column as:
--
--   total_events
--
-- New SQL:
--   AS
--
-- AS gives an output column a useful analytical name.
--
-- Write query below:

SELECT COUNT(*) AS total_events
FROM risk.events;


-- ============================================================
-- 02. COUNT EVENTS BY EVENT TYPE
-- ============================================================
--
-- Return:
--   event_type
--   number of events
--
-- Group the records by:
--   event_type
--
-- New SQL:
--   GROUP BY
--
-- General concept:
--
--   Without GROUP BY:
--
--       all records
--           ↓
--       one summary
--
--   With GROUP BY:
--
--       records
--           ↓
--       categories
--           ↓
--       one summary per category
--
-- Alias the count as:
--
--   event_count
--
-- Sort:
--   highest event count first.
--
-- Write query below:

SELECT 
    event_type, 
    COUNT(*) AS event_count
FROM risk.events
GROUP BY event_type 
ORDER BY event_count DESC;


-- ============================================================
-- 03. TOTAL ESTIMATED EVENT COST
-- ============================================================
--
-- Return:
--   total estimated cost across all events.
--
-- New SQL:
--   SUM()
--
-- Source field:
--   estimated_cost
--
-- Alias the result as:
--
--   total_estimated_cost
--
-- Decision-support question:
--   What is the combined recorded financial impact of the
--   events in the dataset?
--
-- Write query below:

SELECT 
    SUM(estimated_cost) AS total_estimated_cost
FROM risk.events;



-- ============================================================
-- 04. EVENT COST BY EVENT TYPE
-- ============================================================
--
-- Return:
--   event_type
--   event_count
--   total_estimated_cost
--   average_estimated_cost
--
-- New SQL:
--   AVG()
--
-- Required functions:
--   COUNT()
--   SUM()
--   AVG()
--
-- Group by:
--   event_type
--
-- Sort:
--   highest total estimated cost first.
--
-- Decision-support question:
--   Which event categories account for the greatest recorded
--   financial impact?
--
-- Important:
--   Event frequency and financial impact are different
--   dimensions. A common event is not necessarily the most
--   costly event type.
--
-- Write query below:

SELECT 
    event_type,
    COUNT(*) AS event_count,
    SUM(estimated_cost) AS total_estimated_cost,
    AVG(estimated_cost) AS average_estimated_cost
FROM risk.events
GROUP BY event_type 
ORDER BY total_estimated_cost DESC;


-- ============================================================
-- 05. CONSEQUENCE RANGE BY EVENT TYPE
-- ============================================================
--
-- Return:
--   event_type
--   minimum consequence level
--   average consequence level
--   maximum consequence level
--
-- New SQL:
--   MIN()
--   MAX()
--
-- Required functions:
--   MIN()
--   AVG()
--   MAX()
--
-- Suggested aliases:
--
--   min_consequence
--   avg_consequence
--   max_consequence
--
-- Group by:
--   event_type
--
-- Decision-support question:
--   How does recorded consequence vary between event types?
--
-- Write query below:

SELECT 
    event_type,
    COUNT(*) AS event_count,
    MIN(consequence_level) AS min_consequence,
    MAX(consequence_level) AS max_consequence,
    AVG(consequence_level) AS avg_consequence
FROM risk.events
GROUP BY event_type;



-- ============================================================
-- 06. OPERATIONAL DOWNTIME BY EVENT TYPE
-- ============================================================
--
-- Return:
--   event_type
--   event_count
--   total downtime hours
--   average downtime hours
--
-- Required functions:
--   COUNT()
--   SUM()
--   AVG()
--
-- Group by:
--   event_type
--
-- Sort:
--   greatest total downtime first.
--
-- Decision-support question:
--   Which event types account for the greatest recorded
--   operational disruption?
--
-- Write query below:

SELECT 
    event_type,
    COUNT(*) AS event_count,
    SUM(downtime_hours) AS total_downtime_hours,
    AVG(downtime_hours) AS average_downtime_hours
FROM risk.events
GROUP BY event_type
ORDER BY total_downtime_hours DESC;

-- ============================================================
-- 07. FILTER GROUPED RESULTS
-- ============================================================
--
-- Return:
--   event_type
--   event_count
--
-- Group by:
--   event_type
--
-- Condition:
--   return only event types with 3 or more events.
--
-- New SQL:
--   HAVING
--
-- Important:
--
--   WHERE filters individual rows BEFORE aggregation.
--
--   HAVING filters grouped results AFTER aggregation.
--
-- Conceptually:
--
--       rows
--         ↓
--       WHERE
--         ↓
--       GROUP BY
--         ↓
--       aggregate functions
--         ↓
--       HAVING
--         ↓
--       ORDER BY
--
-- Write query below:

SELECT 
    event_type,
    COUNT(*) AS event_count
FROM risk.events
GROUP BY event_type
HAVING COUNT(*) >= 3
ORDER BY event_count DESC;



-- ============================================================
-- 08. MINI ANALYTICAL CHALLENGE
-- ============================================================
--
-- Produce an event-type summary containing:
--
--   event_type
--   event_count
--   average consequence
--   total downtime
--   total estimated cost
--
-- Only include:
--   event types with at least 2 recorded events.
--
-- Sort:
--   highest total estimated cost first.
--
-- Try to construct this from the concepts above without
-- referring to an answer.
--
-- Decision-support question:
--
--   What does the combination of frequency, consequence,
--   disruption and financial impact tell us about the
--   different event categories?
--
-- Do NOT attempt to declare a category "highest risk" from
-- this query alone.
--
-- These measures describe different dimensions of the
-- available evidence and will later be combined with exposure,
-- spatial context, uncertainty and other risk information.
--
-- Write query below:

SELECT 
    event_type,
    COUNT(*) AS event_count,
    AVG(consequence_level) AS average_consequence,
    SUM(downtime_hours) AS total_downtime,
    SUM(estimated_cost) AS total_estimated_cost
FROM risk.events
GROUP BY event_type
HAVING COUNT(*) >= 2
ORDER BY total_estimated_cost DESC;


-- ============================================================
-- KEY CONCEPTS
-- ============================================================
--
-- COUNT()
--   Counts records.
--
-- SUM()
--   Adds numeric values.
--
-- AVG()
--   Calculates the arithmetic mean of numeric values.
--
-- MIN()
--   Returns the minimum value.
--
-- MAX()
--   Returns the maximum value.
--
-- GROUP BY
--   Divides records into groups before aggregate functions
--   are calculated.
--
-- AS
--   Gives an output column an analytical alias.
--
-- HAVING
--   Filters grouped or aggregated results.
--
-- ORDER BY
--   Controls presentation order after the analytical result
--   has been produced.
--
--
-- General analytical pattern:
--
--   SELECT
--       grouping_column,
--       COUNT(*) AS record_count,
--       SUM(value_column) AS total_value,
--       AVG(value_column) AS average_value
--   FROM schema.table
--   WHERE row_condition
--   GROUP BY grouping_column
--   HAVING aggregate_condition
--   ORDER BY total_value DESC;
--
--
-- DECISION-SUPPORT PROGRESSION
--
--   Individual events
--         ↓
--   Select relevant information
--         ↓
--   Filter relevant records
--         ↓
--   Group comparable records
--         ↓
--   Calculate summary measures
--         ↓
--   Compare patterns
--         ↓
--   Investigate what may explain those patterns
--
--
-- NEXT:
--
--   04_null_distinct.sql
--
-- Missing information, unique values and handling NULLs.
--
-- ============================================================