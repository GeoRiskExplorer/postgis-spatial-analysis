# PostgreSQL / PostGIS with Positron

## Purpose

This project uses **Positron** as the primary SQL development
environment, with **PostgreSQL** and **PostGIS** providing the
relational database and spatial analysis engine.

The workflow supports:

-   SQL source files under version control
-   direct PostgreSQL connections from Positron
-   schema and table browsing
-   execution of selected SQL statements
-   interactive query results
-   command-line access through `psql`
-   reproducible project setup for other users

The SQL files stored in the repository are treated as the authoritative
analytical source rather than relying on temporary query history held by
an individual database client.

------------------------------------------------------------------------

## 1. Environment Used

The development environment used when this guide was prepared was:

  Component               Version / Setting
  ----------------------- -------------------
  PostgreSQL              17.4
  PostGIS                 3.5.2
  Database                `georisk_lab`
  Host                    `localhost`
  Port                    `5432`
  Development client      Positron
  Administration client   pgAdmin 4
  Command-line client     `psql`

The database name and local connection settings are demonstration
settings. Users reproducing the project can use equivalent local
settings.

### Check PostgreSQL and PostGIS versions

``` sql
SELECT version();

SELECT PostGIS_Version();
```

A more detailed PostGIS environment report can be obtained with:

``` sql
SELECT PostGIS_Full_Version();
```

------------------------------------------------------------------------

## 2. Project Database

The demonstration database is:

``` text
georisk_lab
```

PostGIS must be enabled within the database:

``` sql
CREATE EXTENSION IF NOT EXISTS postgis;
```

Verify the installed extension:

``` sql
SELECT
    extname AS extension_name,
    extversion AS extension_version
FROM pg_extension
ORDER BY extname;
```

The project uses logical PostgreSQL schemas to organise database
objects:

``` text
georisk_lab
├── public
├── risk
└── spatial
```

The `risk` schema contains operational and analytical risk data, while
the `spatial` schema contains geographic and spatial reference objects.

------------------------------------------------------------------------

## 3. Create a PostgreSQL Connection in Positron

Open **Data Connections** in Positron and add a PostgreSQL connection.

For the local demonstration database, use:

  Setting           Value
  ----------------- ---------------------------
  Connection name   `GeoRisk Lab`
  Host              `localhost`
  Port              `5432`
  Database          `georisk_lab`
  User              `postgres`
  Password          Local PostgreSQL password

Do **not** store passwords or other credentials in repository files.

Once connected, Positron can be used to browse PostgreSQL objects such
as:

-   schemas
-   tables
-   views
-   columns
-   indexes

A successful connection should expose the project schemas:

``` text
GeoRisk Lab
└── georisk_lab
    └── Schemas
        ├── public
        ├── risk
        └── spatial
```

------------------------------------------------------------------------

## 4. Attach a SQL File to the Database Connection

Open a `.sql` file in Positron.

Right-click within the SQL editor and select:

``` text
Attach Connection To This File
```

Select:

``` text
GeoRisk Lab
```

The SQL file is now associated with the PostgreSQL database connection
and queries can be executed directly from the editor.

------------------------------------------------------------------------

## 5. Run Selected SQL in Positron

One of the main development workflows used in this project is executing
individual SQL statements directly from a source file.

For example:

``` sql
SELECT
    event_id,
    event_date,
    event_type,
    consequence_level
FROM risk.events;
```

Highlight the complete statement.

Right-click and select:

``` text
Run Selected Query
```

The keyboard shortcut is:

``` text
Ctrl+E, Ctrl+E
```

This is a sequential shortcut: press `Ctrl+E`, release the keys, and
then press `Ctrl+E` again.

The result is returned in Positron's interactive data viewer.

This provides the preferred workflow for developing and testing
individual analytical queries:

``` text
SQL source file
      ↓
Select query
      ↓
Run Selected Query
      ↓
PostgreSQL / PostGIS
      ↓
Interactive result viewer
```

The SQL remains stored in a reproducible, version-controlled source file
while results can be inspected interactively.

------------------------------------------------------------------------

## 6. Using `psql`

`psql` is PostgreSQL's command-line client.

It complements the Positron workflow and is useful for:

-   direct database interaction
-   database inspection
-   executing complete SQL scripts
-   setup and administration
-   QA
-   troubleshooting
-   reproducible script execution

### Connect to the database

From PowerShell:

``` powershell
psql -U postgres -d georisk_lab
```

Enter the PostgreSQL password when prompted.

A successful connection produces a prompt similar to:

``` text
georisk_lab=#
```

### Verify the connection

Inside `psql`:

``` text
\conninfo
```

Example:

``` text
You are connected to database "georisk_lab"
as user "postgres"
on host "localhost"
at port "5432".
```

------------------------------------------------------------------------

## 7. Core `psql` Reference

These commands are `psql` meta-commands rather than SQL statements.

  Command             Purpose
  ------------------- --------------------------------------------------
  `\conninfo`         Show the current database connection
  `\l`                List databases
  `\dn`               List schemas
  `\dt`               List tables
  `\dv`               List views
  `\dm`               List materialized views
  `\dx`               List installed extensions
  `\d table_name`     Describe a table
  `\d+ table_name`    Show extended table information
  `\i file.sql`       Execute a SQL file
  `\pset pager off`   Disable the result pager for the current session
  `\q`                Quit `psql`

Schema-qualified objects can also be inspected directly:

``` text
\d risk.events
\d risk.assets
\d spatial.operational_areas
```

------------------------------------------------------------------------

## 8. Execute a Complete SQL File with `psql`

From inside `psql`, execute a saved SQL script with:

``` text
\i sql/01_setup/01_environment_check.sql
```

For example:

``` text
\i sql/01_setup/04_seed_data.sql
```

This executes the entire file against the currently connected database.

A SQL script can also be executed directly from PowerShell without first
entering an interactive `psql` session:

``` powershell
psql -U postgres -d georisk_lab -f "sql/01_setup/01_environment_check.sql"
```

This is particularly useful for reproducible setup and automated
workflows.

------------------------------------------------------------------------

## 9. Understanding the `psql` Prompt

A normal ready prompt appears as:

``` text
georisk_lab=#
```

When entering a multi-line SQL statement, the prompt may change:

``` text
georisk_lab=# SELECT
georisk_lab-#     event_id,
georisk_lab-#     event_type
georisk_lab-# FROM risk.events;
```

The `-#` prompt indicates that `psql` is waiting for the current SQL
statement to be completed.

The terminating semicolon:

``` sql
;
```

tells PostgreSQL that the statement is complete and can be executed.

------------------------------------------------------------------------

## 10. Disable the `psql` Result Pager

Long query results may be displayed through a terminal pager and show:

``` text
-- More --
```

Press:

``` text
q
```

to leave the pager.

For interactive development, the pager can be disabled for the current
`psql` session:

``` text
\pset pager off
```

Query results will then print directly to the terminal.

------------------------------------------------------------------------

## 11. Windows PATH Setup

PostgreSQL installed the `psql` executable on the development machine,
but the PostgreSQL binary directory was not initially available on the
Windows `PATH`.

The executable was located at:

``` text
C:\Program Files\PostgreSQL\17\bin\psql.exe
```

### Test the executable directly

From PowerShell:

``` powershell
& "C:\Program Files\PostgreSQL\17\bin\psql.exe" --version
```

Example output:

``` text
psql (PostgreSQL) 17.4
```

### Add PostgreSQL to PATH for the current PowerShell session

``` powershell
$env:Path += ";C:\Program Files\PostgreSQL\17\bin"
```

Then:

``` powershell
psql --version
```

should return the installed PostgreSQL client version.

This change applies only to the current PowerShell session unless the
Windows environment variable is changed permanently.

------------------------------------------------------------------------

## 12. Positron, `psql`, and pgAdmin Roles

The project deliberately uses the three tools for different purposes.

### Positron

Primary development environment for:

-   authoring `.sql` files
-   organising the repository
-   executing selected queries
-   inspecting query results
-   Git/version-control workflows
-   later R and Python integration

### `psql`

Command-line PostgreSQL interface for:

-   complete script execution
-   database inspection
-   QA
-   troubleshooting
-   reproducible command-line workflows

### pgAdmin

Graphical PostgreSQL administration environment for:

-   server administration
-   database creation
-   visual object inspection
-   extension management
-   troubleshooting and administration

Together:

``` text
                    Positron
                 SQL development
                selected execution
                       │
                       ▼
              PostgreSQL / PostGIS
                 georisk_lab
                    ▲       ▲
                    │       │
                  psql    pgAdmin
               CLI / QA   administration
```

------------------------------------------------------------------------

## 13. Credential and Git Safety

Local development details such as these are safe and useful to document:

``` text
Host: localhost
Port: 5432
Database: georisk_lab
PostgreSQL: 17.4
PostGIS: 3.5.2
```

`localhost` refers to the local computer on which the instructions are
being followed. It does not provide remote access to the original
development machine.

Never commit:

-   PostgreSQL passwords
-   API keys
-   access tokens
-   private certificates
-   production database credentials
-   externally accessible connection strings containing credentials
-   `.env` files containing secrets

When R and Python integrations are introduced later, local credentials
should be separated from version-controlled configuration.

A typical pattern is:

``` text
.env.example    Public configuration template
.env            Local secrets — excluded from Git
```

------------------------------------------------------------------------

## 14. Recommended Development Workflow

For interactive SQL development:

1.  Open the project in Positron.
2.  Confirm the `GeoRisk Lab` PostgreSQL connection.
3.  Open the relevant `.sql` file.
4.  Attach `GeoRisk Lab` to the file if required.
5.  Highlight a complete SQL statement.
6.  Run the selected query with `Ctrl+E, Ctrl+E`.
7.  Inspect the result in Positron.
8.  Refine the SQL in the source file.
9.  Save the final query under version control.

For complete workflow execution or QA:

1.  Open a PowerShell terminal.
2.  Connect using `psql`.
3.  Confirm the connection with `\conninfo`.
4.  Execute the relevant `.sql` file with `\i`.
5.  Review PostgreSQL output and QA checks.

------------------------------------------------------------------------

## 15. Reproducibility

The repository is intended to be reproducible rather than dependent on
the original local development environment.

A user following the project should ultimately be able to:

``` text
1. Install PostgreSQL and PostGIS
2. Create the demonstration database
3. Enable PostGIS
4. Create the project schemas and tables
5. Seed the demonstration dataset
6. Execute the SQL analysis workflow
7. Reproduce the analytical outputs
```

Local connection settings may differ between machines, but the SQL
analysis and database design remain portable.

------------------------------------------------------------------------

## 16. Project Principle

The `.sql` files in the repository are the authoritative analytical
source.

Interactive database clients are used to develop, inspect and execute
those files, but important analytical logic should not exist only in
temporary query tabs or command history.

This supports:

-   transparency
-   reproducibility
-   peer review
-   version control
-   QA
-   maintainability
-   reuse
