# PostGIS Spatial Analysis

A reproducible PostgreSQL and PostGIS project demonstrating SQL-based spatial analysis for risk-informed decision support.

The project combines relational database design, spatial SQL and structured risk analysis using a fictional operational infrastructure dataset. It is designed both as a practical PostGIS reference and as a progressively developed demonstration of spatial SQL workflows.

## Project Objectives

The project explores how PostgreSQL and PostGIS can support spatial risk analysis and decision-making through:

- reproducible SQL workflows
- relational database design and data integrity
- event and asset-based risk data
- point-in-polygon spatial attribution
- spatial aggregation and geographic comparison
- exposure and consequence analysis
- identification of spatial patterns and concentrations
- uncertainty and data-quality assessment
- risk evaluation and prioritisation
- treatment and decision-support analysis
- monitoring and review
- query optimisation and spatial indexing

The analytical workflow is informed by ISO 31000 risk-management principles while focusing on practical spatial decision support.

## Technology

- PostgreSQL 17
- PostGIS 3.5
- SQL
- Positron
- `psql`
- pgAdmin
- Git / GitHub

Later stages will demonstrate integration with R and Python while retaining PostgreSQL/PostGIS as the primary database and spatial analysis engine.

## Demonstration Context

The project uses a fictional metropolitan logistics and infrastructure network.

Example data include:

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

## Repository Structure

```text
postgis-spatial-analysis/
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
├── outputs/
├── .gitignore
└── README.md
```

## Current Progress

The project currently includes:

- PostgreSQL/PostGIS environment validation
- project schema creation
- relational table design
- database constraints and referential integrity
- fictional demonstration data
- introductory SQL querying
- Positron/PostgreSQL development workflow
- `psql` command-line workflow

Spatial geometry and PostGIS analysis are introduced progressively after the relational SQL foundations.

## Development Workflow

SQL is maintained as version-controlled source code rather than being stored only in database-client query history.

The primary workflow is:

```text
Positron
   │
   ├── SQL authoring
   ├── selected-query execution
   └── interactive results
          │
          ▼
   PostgreSQL / PostGIS
          ▲
          │
        psql
   script execution / QA
```

pgAdmin is used primarily for PostgreSQL administration and visual database inspection.

## Documentation

Setup and development notes are maintained under [`docs/`](docs/).

The current Positron/PostgreSQL setup guide covers:

- PostgreSQL connections in Positron
- executing selected SQL
- using `psql`
- Windows PATH configuration
- database inspection
- credential and Git safety
- reproducible development workflows

## Status

**Active development**

The repository is being developed progressively from SQL fundamentals through spatial SQL, analytical risk workflows, performance optimisation and multi-language database integration.