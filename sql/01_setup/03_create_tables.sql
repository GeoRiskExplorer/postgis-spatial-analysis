-- ============================================================
-- POSTGIS SPATIAL ANALYSIS
-- 03 — CREATE CORE TABLES
-- ============================================================
--
-- Purpose:
-- Create the core relational tables for a fictional metropolitan
-- logistics and infrastructure risk analysis.
--
-- The initial model separates:
--   1. operational areas
--   2. assets
--   3. risk events
--
-- Geometry is deliberately introduced later so the relational
-- database structure can be understood first.
--
-- Database: georisk_lab
--
-- ============================================================


-- ============================================================
-- 01. OPERATIONAL AREAS
-- ============================================================

CREATE TABLE IF NOT EXISTS spatial.operational_areas (

    area_id         INTEGER GENERATED ALWAYS AS IDENTITY,
    area_name       TEXT NOT NULL,
    region          TEXT NOT NULL,
    exposure_index  NUMERIC(5,2) NOT NULL,

    CONSTRAINT pk_operational_areas
        PRIMARY KEY (area_id),

    CONSTRAINT uq_operational_areas_name
        UNIQUE (area_name),

    CONSTRAINT chk_exposure_index
        CHECK (exposure_index BETWEEN 0 AND 100)
);


-- ============================================================
-- 02. ASSETS
-- ============================================================

CREATE TABLE IF NOT EXISTS risk.assets (

    asset_id            INTEGER GENERATED ALWAYS AS IDENTITY,
    asset_name          TEXT NOT NULL,
    asset_type          TEXT NOT NULL,
    area_id             INTEGER NOT NULL,
    criticality         INTEGER NOT NULL,
    replacement_value   NUMERIC(14,2),

    CONSTRAINT pk_assets
        PRIMARY KEY (asset_id),

    CONSTRAINT chk_asset_criticality
        CHECK (criticality BETWEEN 1 AND 5),

    CONSTRAINT chk_replacement_value
        CHECK (
            replacement_value IS NULL
            OR replacement_value >= 0
        ),

    CONSTRAINT fk_assets_area
        FOREIGN KEY (area_id)
        REFERENCES spatial.operational_areas (area_id)
);


-- ============================================================
-- 03. RISK EVENTS
-- ============================================================

CREATE TABLE IF NOT EXISTS risk.events (

    event_id            INTEGER GENERATED ALWAYS AS IDENTITY,
    event_date          DATE NOT NULL,
    event_type          TEXT NOT NULL,
    asset_id            INTEGER,
    consequence_level   INTEGER NOT NULL,
    downtime_hours      NUMERIC(8,2),
    estimated_cost      NUMERIC(14,2),
    description         TEXT,

    CONSTRAINT pk_events
        PRIMARY KEY (event_id),

    CONSTRAINT chk_consequence_level
        CHECK (consequence_level BETWEEN 1 AND 5),

    CONSTRAINT chk_downtime_hours
        CHECK (
            downtime_hours IS NULL
            OR downtime_hours >= 0
        ),

    CONSTRAINT chk_estimated_cost
        CHECK (
            estimated_cost IS NULL
            OR estimated_cost >= 0
        ),

    CONSTRAINT fk_events_asset
        FOREIGN KEY (asset_id)
        REFERENCES risk.assets (asset_id)
);


-- ============================================================
-- 04. VERIFY TABLE CREATION
-- ============================================================

SELECT
    table_schema,
    table_name
FROM information_schema.tables
WHERE table_schema IN ('risk', 'spatial')
ORDER BY
    table_schema,
    table_name;