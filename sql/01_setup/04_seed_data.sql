-- ============================================================
-- POSTGIS SPATIAL ANALYSIS
-- 04 — SEED DEMONSTRATION DATA
-- ============================================================
--
-- Purpose:
-- Populate the GeoRisk demonstration database with a small
-- fictional logistics and infrastructure risk dataset.
--
-- The dataset is intentionally varied so later SQL exercises
-- can explore:
--   - filtering and sorting
--   - aggregation and grouping
--   - joins
--   - missing values
--   - event frequency and consequence
--   - exposure and asset criticality
--   - spatial risk analysis
--
-- Database: georisk_lab
--
-- ============================================================


-- ============================================================
-- 01. OPERATIONAL AREAS
-- ============================================================

INSERT INTO spatial.operational_areas (
    area_name,
    region,
    exposure_index
)
VALUES
    ('North Logistics Zone',   'North',   72.50),
    ('East Industrial Zone',   'East',    61.20),
    ('South Freight Zone',     'South',   84.10),
    ('West Distribution Zone', 'West',    55.80),
    ('Central Operations Zone','Central', 91.40),
    ('Outer Service Zone',     'Outer',   38.60);


-- ============================================================
-- 02. ASSETS
-- ============================================================

INSERT INTO risk.assets (
    asset_name,
    asset_type,
    area_id,
    criticality,
    replacement_value
)
VALUES
    ('North Distribution Centre',   'Distribution Centre', 1, 5, 12500000.00),
    ('North Fleet Depot',            'Fleet Depot',         1, 4,  4200000.00),

    ('East Warehouse A',             'Warehouse',           2, 3,  3100000.00),
    ('East Transfer Station',        'Transfer Station',    2, 4,  5800000.00),

    ('South Freight Terminal',       'Freight Terminal',    3, 5, 18750000.00),
    ('South Fleet Depot',            'Fleet Depot',         3, 4,  4600000.00),

    ('West Warehouse',               'Warehouse',           4, 3,  2750000.00),
    ('West Distribution Centre',     'Distribution Centre', 4, 4,  8900000.00),

    ('Central Control Facility',     'Control Facility',    5, 5, 14200000.00),
    ('Central Distribution Centre',  'Distribution Centre', 5, 5, 16500000.00),

    ('Outer Maintenance Depot',      'Maintenance Depot',   6, 2,  1900000.00),
    ('Outer Storage Facility',       'Warehouse',           6, 2,  1450000.00);


-- ============================================================
-- 03. RISK EVENTS
-- ============================================================

INSERT INTO risk.events (
    event_date,
    event_type,
    asset_id,
    consequence_level,
    downtime_hours,
    estimated_cost,
    description
)
VALUES

    -- North
    ('2024-02-14', 'Equipment Failure',  1, 3,  6.5,  42000.00,
        'Conveyor system failure affecting outbound operations.'),

    ('2024-06-03', 'Vehicle Incident',   2, 2,  1.5,  12000.00,
        'Low-speed fleet vehicle collision within depot.'),

    ('2025-01-18', 'Service Disruption', 1, 4, 14.0, 118000.00,
        'Distribution operations interrupted following systems failure.'),

    ('2025-08-09', 'Equipment Failure',  1, 3,  5.0,  36000.00,
        'Automated sorting equipment unavailable.'),


    -- East
    ('2024-03-22', 'Equipment Failure',  3, 2,  3.0,  18000.00,
        'Loading equipment failure.'),

    ('2024-11-11', 'Near Miss',          4, 1,  0.0,   1500.00,
        'Vehicle and worker interaction near loading area.'),

    ('2025-04-07', 'Vehicle Incident',   4, 3,  4.5,  31000.00,
        'Vehicle impact caused temporary transfer lane closure.'),


    -- South
    ('2024-01-29', 'Service Disruption', 5, 4, 18.0, 165000.00,
        'Freight processing interruption during peak operations.'),

    ('2024-07-16', 'Equipment Failure',  5, 3,  8.0,  67000.00,
        'Material handling system failure.'),

    ('2024-10-02', 'Vehicle Incident',   6, 3,  5.5,  48000.00,
        'Fleet vehicle incident affecting depot access.'),

    ('2025-02-20', 'Hazardous Material', 5, 5, 30.0, 410000.00,
        'Material release requiring temporary operational shutdown.'),

    ('2025-06-13', 'Near Miss',          5, 2,  0.0,   3000.00,
        'Potential vehicle conflict identified during freight movement.'),

    ('2025-09-04', 'Equipment Failure',  6, 2,  2.5,  15000.00,
        'Workshop lifting equipment failure.'),


    -- West
    ('2024-05-08', 'Equipment Failure',  7, 2,  2.0,  11000.00,
        'Warehouse loading equipment fault.'),

    ('2025-03-15', 'Service Disruption', 8, 3,  7.0,  54000.00,
        'Local distribution operations temporarily interrupted.'),


    -- Central
    ('2024-04-19', 'Systems Failure',    9, 4, 10.0,  95000.00,
        'Control systems outage affecting network coordination.'),

    ('2024-08-27', 'Service Disruption',10, 4, 12.5, 132000.00,
        'Distribution capacity substantially reduced.'),

    ('2024-12-06', 'Systems Failure',    9, 3,  4.0,  39000.00,
        'Partial control system outage.'),

    ('2025-05-23', 'Equipment Failure', 10, 3,  6.0,  51000.00,
        'Automated distribution equipment failure.'),

    ('2025-07-30', 'Systems Failure',    9, 5, 22.0, 285000.00,
        'Major control system outage affecting multiple operations.'),


    -- Events not yet linked to a specific asset
    ('2025-08-18', 'Vehicle Incident', NULL, 2, 1.0,  8500.00,
        'Vehicle incident recorded within the operating network.'),

    ('2025-09-01', 'Near Miss',        NULL, 1, 0.0,   500.00,
        'Reported operational near miss pending asset attribution.');


-- ============================================================
-- 04. VERIFY ROW COUNTS
-- ============================================================

SELECT
    'operational_areas' AS table_name,
    COUNT(*) AS row_count
FROM spatial.operational_areas

UNION ALL

SELECT
    'assets',
    COUNT(*)
FROM risk.assets

UNION ALL

SELECT
    'events',
    COUNT(*)
FROM risk.events;


-- ============================================================
-- 05. BASIC EVENT QA
-- ============================================================

SELECT
    MIN(event_date) AS earliest_event,
    MAX(event_date) AS latest_event,
    COUNT(*) AS total_events,
    COUNT(asset_id) AS events_with_asset,
    COUNT(*) - COUNT(asset_id) AS events_without_asset
FROM risk.events;