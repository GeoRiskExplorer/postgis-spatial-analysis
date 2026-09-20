# SQL Basics for Spatial Risk Analysis

> **Project status:** Active development. This project is being updated
> regularly as the SQL, PostGIS and spatial risk analysis workflow is
> progressively developed and documented.

This section introduces the core PostgreSQL patterns used throughout the
project.

The objective is not to cover SQL exhaustively. Instead, it establishes
the essential relational querying skills needed to move from individual
records to useful risk and spatial analysis.

## 1. From records to information

``` sql
SELECT
    event_id,
    event_date,
    event_type
FROM risk.events;
```

`SELECT` defines the information returned and `FROM` identifies its
source.

## 2. Filter and order

``` sql
SELECT
    event_id,
    event_type,
    consequence_level
FROM risk.events
WHERE consequence_level >= 4
ORDER BY consequence_level DESC;
```

Useful patterns include `WHERE`, `IN`, `IS NULL` and `ORDER BY`.
Ordering controls presentation; it does not itself constitute risk
prioritisation.

## 3. Summarise events

``` sql
SELECT
    event_type,
    COUNT(*) AS event_count,
    AVG(consequence_level) AS average_consequence,
    SUM(downtime_hours) AS total_downtime,
    SUM(estimated_cost) AS total_estimated_cost
FROM risk.events
GROUP BY event_type
ORDER BY total_estimated_cost DESC;
```

Core functions are `COUNT()`, `SUM()`, `AVG()`, `MIN()`, `MAX()`,
`GROUP BY` and `HAVING`.

These measures describe different dimensions of evidence. Frequency,
consequence or cost alone should not automatically be interpreted as
overall risk.

## 4. Missing information matters

``` sql
SELECT
    COUNT(*) AS total_events,
    COUNT(asset_id) AS events_with_asset,
    COUNT(*) - COUNT(asset_id) AS events_without_asset
FROM risk.events;
```

`COUNT(*)` counts rows, while `COUNT(asset_id)` counts only non-NULL
values. Missing information should not automatically be interpreted as
zero or absence of risk.

`COALESCE()` can provide an alternative value in query output without
modifying stored source data.

## 5. Combine related information

``` text
risk.events
    │ asset_id
    ▼
risk.assets
    │ area_id
    ▼
spatial.operational_areas
```

``` sql
SELECT
    e.event_id,
    e.event_type,
    a.asset_name,
    oa.area_name,
    oa.exposure_index
FROM risk.events AS e
INNER JOIN risk.assets AS a
    ON e.asset_id = a.asset_id
INNER JOIN spatial.operational_areas AS oa
    ON a.area_id = oa.area_id;
```

Keeping related entities in separate tables avoids unnecessary
duplication while allowing them to be combined dynamically.

## 6. Join choice changes the analytical population

`INNER JOIN` retains successful matches. `LEFT JOIN` preserves every
record from the left-hand table, whether or not a match exists.

``` sql
SELECT
    oa.area_name,
    COUNT(e.event_id) AS event_count
FROM spatial.operational_areas AS oa
LEFT JOIN risk.assets AS a
    ON oa.area_id = a.area_id
LEFT JOIN risk.events AS e
    ON a.asset_id = e.asset_id
GROUP BY oa.area_name
ORDER BY event_count DESC;
```

Starting with operational areas ensures areas with zero recorded events
remain visible.

> The key analytical question is not simply *Which join works?* but
> *Which population should the analysis preserve?*

## 7. SQL patterns covered

`SELECT`, `FROM`, `WHERE`, `IN`, `IS NULL`, `IS NOT NULL`, `DISTINCT`,
`ORDER BY`, `COUNT`, `SUM`, `AVG`, `MIN`, `MAX`, `GROUP BY`, `HAVING`,
`COALESCE`, `INNER JOIN`, `LEFT JOIN`, and table aliases.

The executable exercises are in
[`../../sql/02_basics/`](../../sql/02_basics/).

## PostgreSQL reference

Official PostgreSQL documentation is the primary reference:

-   [PostgreSQL 17 documentation](https://www.postgresql.org/docs/17/)
-   [SQL tutorial](https://www.postgresql.org/docs/17/tutorial-sql.html)
-   [Queries](https://www.postgresql.org/docs/17/queries.html)
-   [SELECT](https://www.postgresql.org/docs/17/sql-select.html)
-   [Aggregate
    functions](https://www.postgresql.org/docs/17/functions-aggregate.html)
-   [Conditional expressions including
    COALESCE](https://www.postgresql.org/docs/17/functions-conditional.html)

## Next

The next section moves into intermediate analytical SQL before
introducing geometry and PostGIS spatial relationships.
