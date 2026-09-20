# PostGIS Spatial Analysis

A reproducible PostgreSQL and PostGIS project demonstrating SQL-based data analysis, spatial analysis and risk-informed decision support.

The project uses a fictional metropolitan logistics and infrastructure network to demonstrate how relational data, spatial data and analytical SQL can be developed into a structured decision-support workflow.

> **Project status:** Active development. This repository is updated regularly as additional SQL, PostGIS, spatial analysis and database-integration components are developed and documented.

## What This Project Demonstrates

The project progressively applies PostgreSQL and PostGIS to:

- relational database design and data integrity
- reproducible SQL analysis
- event, asset and operational data
- data quality and uncertainty
- aggregation and comparative analysis
- spatial attribution and spatial joins
- exposure and consequence analysis
- identification of spatial patterns and concentrations
- risk evaluation and decision support
- spatial indexing and query optimisation
- integration with R and Python

The analytical workflow is informed by ISO 31000 risk-management principles while maintaining a practical focus on spatial and non-spatial decision support.

## Analytical Approach

The project develops from individual records toward progressively richer decision-support questions:

```text
Understand the data
        ↓
Identify events and characteristics
        ↓
Examine frequency and consequence
        ↓
Add asset and exposure context
        ↓
Examine spatial distribution
        ↓
Compare locations and patterns
        ↓
Consider uncertainty and data quality
        ↓
Identify locations warranting attention
        ↓
Support treatment and monitoring decisions
```

SQL and PostGIS provide the primary database and analytical engine.

Later stages demonstrate how R and Python can work alongside PostgreSQL/PostGIS for specialised analysis, visualisation and reporting.

## Demonstration Context

The project uses a fictional metropolitan logistics and infrastructure network.

The demonstration data include:

- operational risk events
- infrastructure assets
- operational areas
- asset criticality
- event consequence
- operational disruption
- financial impact
- exposure measures
- spatial geometry

The demonstration data are independent of any real organisation or client.

## Technology

- PostgreSQL 17
- PostGIS 3.5
- SQL
- Positron
- `psql`
- pgAdmin
- Git / GitHub

R and Python integration will be introduced in later stages while retaining PostgreSQL/PostGIS as the primary database and spatial analysis engine.

## Repository Structure

```text
postgis-spatial-analysis/
│
├── sql/
│   ├── 01_setup/
│   ├── 02_basics/
│   ├── 03_intermediate/
│   ├── 04_postgis/
│   ├── 05_analysis/
│   └── 06_advanced/
│
├── data/
├── docs/
│   └── tutorials/
├── outputs/
├── .gitignore
└── README.md
```

The SQL structure progresses from database setup and relational foundations through analytical SQL, PostGIS and more advanced spatial analysis.

## Current Progress

### Complete

- PostgreSQL/PostGIS environment validation
- project schema creation
- relational table design
- database constraints and referential integrity
- fictional demonstration dataset
- SQL selection and filtering
- sorting and categorical filtering
- aggregation and grouped analysis
- NULL and data-completeness handling
- relational joins
- preservation of zero-event analytical populations
- Positron/PostgreSQL development workflow
- `psql` command-line workflow

### Next

- intermediate analytical SQL
- reusable views and analytical datasets
- geometry and coordinate reference systems
- PostGIS spatial relationships
- spatial joins and attribution
- spatial aggregation and geographic comparison
- exposure and risk analysis
- uncertainty and unusual-pattern analysis
- decision-support workflows
- spatial indexing and query optimisation
- R and Python integration

## SQL and Data Design

The project maintains events, assets and operational areas as related database entities rather than repeatedly duplicating contextual information.

```text
risk.events
    │
    │ asset_id
    ▼
risk.assets
    │
    │ area_id
    ▼
spatial.operational_areas
```

SQL joins combine these entities dynamically when analysis requires additional context.

As the project develops, views, materialized views and derived analytical datasets will demonstrate different approaches to creating reusable analysis-ready data while retaining clear source-data relationships.

## Tutorials

Documentation is deliberately concise and is developed alongside the executable SQL.

### SQL Basics for Spatial Risk Analysis

[SQL Basics for Spatial Risk Analysis](docs/tutorials/02_sql_basics.md)

Introduces the essential SQL patterns used throughout the project, including:

- `SELECT` and `WHERE`
- filtering and ordering
- aggregation
- `GROUP BY` and `HAVING`
- NULL handling
- `COALESCE`
- `INNER JOIN`
- `LEFT JOIN`
- preservation of analytical populations

The tutorial complements the executable exercises in [`sql/02_basics/`](sql/02_basics/).

### Environment and Development Setup

Additional setup and development notes are maintained under [`docs/`](docs/).

These cover:

- PostgreSQL connections in Positron
- executing selected SQL
- using `psql`
- Windows PATH configuration
- database inspection
- credential and Git safety
- reproducible development workflows

## Development Workflow

SQL is maintained as version-controlled source code rather than existing only in database-client query history.

The primary development workflow is:

```text
          Positron
             │
     SQL development
             │
             ▼
    PostgreSQL / PostGIS
             ▲
             │
            psql
       execution / QA
```

Positron provides the primary SQL authoring and interactive-query environment.

`psql` supports script execution, database inspection and command-line QA.

pgAdmin is used primarily for PostgreSQL administration and visual database inspection.

## Reproducibility

The repository separates analytical logic from local credentials and machine-specific configuration.

SQL scripts are retained as version-controlled source files so database setup and analytical steps can be inspected, rerun and progressively extended.

The demonstration dataset is fictional, allowing the analytical workflow and database structure to be shared independently of client or organisational data.

## PostgreSQL Reference

The project uses the official PostgreSQL documentation as the primary reference for SQL syntax and behaviour:

- [PostgreSQL 17 Documentation](https://www.postgresql.org/docs/17/)
- [PostgreSQL SQL Tutorial](https://www.postgresql.org/docs/17/tutorial-sql.html)
- [Queries](https://www.postgresql.org/docs/17/queries.html)
- [SELECT](https://www.postgresql.org/docs/17/sql-select.html)
- [Aggregate Functions](https://www.postgresql.org/docs/17/functions-aggregate.html)
- [Conditional Expressions, including COALESCE](https://www.postgresql.org/docs/17/functions-conditional.html)

Official PostGIS documentation will be linked alongside the spatial SQL components as they are introduced.

## Project Direction

The repository is intentionally developed in stages so the progression remains visible:

```text
Relational database foundations
        ↓
Analytical SQL
        ↓
Spatial data management
        ↓
PostGIS spatial analysis
        ↓
Risk and decision-support analysis
        ↓
Performance and optimisation
        ↓
R / Python integration
```

This provides both executable examples and a concise reference for applying PostgreSQL/PostGIS to practical spatial and non-spatial analytical problems.