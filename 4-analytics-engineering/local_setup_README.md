# Analytics Engineering Workshop

This repository is based on the **Data Engineering Zoomcamp 2026 - Analytics Engineering Workshop**.  
You can find the YouTube playlist [here](https://www.youtube.com/watch?v=J0XCDyKiU64&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=32).  
Learn more about dbt [here](https://www.getdbt.com/lp/persona-paths?utm_medium=paid-search&utm_source=google&utm_campaign=q1-2025_apac-nonbrand-datatransformation_co&utm_content=_kw-datatransformationtools-ph___&utm_term=all_apac_anz&cq_cmp=21195055622&utm_term=data%20transformation&utm_campaign=&utm_source=adwords&utm_medium=ppc&hsa_acc=8253637521&hsa_cam=21195055622&hsa_grp=164743458161&hsa_ad=783662596456&hsa_src=g&hsa_tgt=kwd-18219416&hsa_kw=data%20transformation&hsa_mt=b&hsa_net=adwords&hsa_ver=3&gad_source=1&gad_campaignid=21195055622&gbraid=0AAAAABONxYjvxm0rcX3RlX-eBKuTvHBeR&gclid=CjwKCAiAkvDMBhBMEiwAnUA9BfYl5ZmRg3dm1BSn8wkftm3XOrpFFxBwXtvclKbit93jxEYBlddWPRoC-FUQAvD_BwE).

Dbt local setup here : https://www.youtube.com/watch?v=GoFAbJYfvlw
Reference URL : https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/04-analytics-engineering/setup/local_setup.md

## Pre-requisites: Python

### 1. Create the Project Folder
Create a folder `/04-analytics-engineering` under the Codespace `/docker-workshop`.

### Steps 2,3,4 are already done prior to creation of analytics-engineering folder. This is done at a overall data-engineering zoomcamp-2026 parent level.


### 2. Initialize the Project
Run the following command to initialize the project using `uv`:
```bash
uv init --python 3.13
```

### 3. Create the Virtual Environment
Check the Python version to confirm the virtual environment is created:
```bash
uv run python -V
```

### 4. Activate the Virtual Environment
Activate the virtual environment:
```bash
source .venv/bin/activate
```

### 5. Add Required Packages
Install the required packages using `uv`:
```bash
uv add duckdb
uv add dbt-duckdb # This installs The core dbt framework, The DuckDB adapter for dbt
uv add dbt-bigquery #This installs the big query adapter for dbt
```

### 6. View Installed Packages
List the installed packages:
```bash
uv pip list
```
Example output:
| Package           | Version   |
|-------------------|-----------|
dbt-adapters              1.22.6
dbt-common                1.37.2
dbt-core                  1.11.6
dbt-duckdb                1.10.1
dbt-extractor             0.6.0
dbt-protos                1.0.431
dbt-semantic-interfaces   0.9.0
deepdiff                  8.6.1
duckdb                    1.4.4


### 7. Verify the dbt version
Verify the version 

(04-analytics-engineering) @deepaknrn ➜ /workspaces/docker-workshop/04-analytics-engineering (main) $ dbt --version
Core:
  - installed: 1.11.6
  - latest:    1.11.6 - Up to date!

Plugins:
  - duckdb: 1.10.1 - Up to date!


Ensure dbt-bigquery plugin is installed.


### 8. Create the dbt project 
Create or Update ~/.dbt/profiles.yml
Create the dbt project

(.venv) @deepaknrn ➜ /workspaces/docker-workshop/04-analytics-engineering (main) $ dbt init taxi_rides_ny

Which database would you like to use ?
[1] Snowflake
[2] duckdb -> Choose this 
[3] bigquery

To configure dbt to use DuckDB, you need to set up your dbt profile in the file ~/.dbt/profiles.yml. Here’s a minimal example for a DuckDB profile:
### This has been created via copilot agent
Created in the Path : C:\Users\chand\.dbt

Profiles file is used to provide information regarding connection/environment that dbt should use.

taxi_rides_ny:                                                   
  target: dev
  outputs:
    # DuckDB Development profile
    dev:
      type: duckdb
      path: taxi_rides_ny.duckdb
      schema: dev
      threads: 1
      extensions:
        - parquet
      settings:
        memory_limit: '2GB'
        preserve_insertion_order: false

    # DuckDB Production profile
    prod:
      type: duckdb
      path: taxi_rides_ny.duckdb
      schema: prod
      threads: 1
      extensions:
        - parquet
      settings:
        memory_limit: '2GB'
        preserve_insertion_order: false

# Troubleshooting:
# - If you have less than 4GB RAM, try setting memory_limit to '1GB'
# - If you have 16GB+ RAM, you can increase to '4GB' for faster builds
# - Expected build time: 5-10 minutes on most systems

### 9. Create the Ingestion Framework
Step 4: Download and Ingest Data https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/04-analytics-engineering/setup/local_setup.md 
# - Create the file ingest.py

Run the ingest.py
Move the duckdb database created taxi_rides_ny.duckdb to the folder /taxi_rides_ny


### 11. Install dbt Power User Extension (VS Code Users)
The following extensions are installed in Vs Code
dbt Power User (Altimate Inc)
dbt (Official VS Code Extension)

Install DuckDB CLI from https://duckdb.org/docs/installation/cli/
Add the installation directory to your PATH environment variable

### 12. Open an instance of duck db
duckdb -ui

┌──────────────────────────────────────┐
│                result                │
│               varchar                │
├──────────────────────────────────────┤
│ UI started at http://localhost:4213/ │
└──────────────────────────────────────┘
DuckDB v1.5.0 (Variegata)
Enter ".help" for usage hints.

http://localhost:4213/ 

Query using : select * from taxi_rides_ny.prod.green_tripdata;
Query using : select * from taxi_rides_ny.prod.yellow_tripdata;


### 13. Navigate to the folder 

Verify dbt can connect to your DuckDB database:
cd 
C:\Learning\Deepak\DataTalks_Club\1.Data Engineering ZoomCamp 2026\data-engineering-zoomcamp-2026\data-engineering-zoomcamp-2026\
4-analytics-engineering\taxi_rides_ny

### 14. Test the dbt Connection
dbt debug
What ^ it does is that it tries to connect to the duckdb database using the profiles.yml file , check if the database is correct and does all the checks and once all the checks are passed it will display a message

[Note Error : 
File is already open in
C:\Users\chand.duckdb\duckdb.exe (PID 20384) This error means taxi_rides_ny.duckdb is already open in DuckDB CLI (duckdb.exe), so dbt cannot access it at the same time.

To fix:

Close DuckDB CLI (duckdb.exe) if it’s running and using taxi_rides_ny.duckdb.
Then rerun dbt debug.]

13:14:14  Running with dbt=1.11.7
13:14:14  dbt version: 1.11.7
13:14:14  python version: 3.13.9
13:14:14  python path: C:\Learning\Deepak\DataTalks_Club\1.Data Engineering ZoomCamp 2026\data-engineering-zoomcamp-2026\data-engineering-zoomcamp-2026\.venv\Scripts\python.exe
13:14:14  os info: Windows-11-10.0.26100-SP0
13:14:14  Using profiles dir at C:\Users\chand\.dbt
13:14:14  Using profiles.yml file at C:\Users\chand\.dbt\profiles.yml
13:14:14  Using dbt_project.yml file at C:\Learning\Deepak\DataTalks_Club\1.Data Engineering ZoomCamp 2026\data-engineering-zoomcamp-2026\data-engineering-zoomcamp-2026\4-analytics-engineering\taxi_rides_ny\dbt_project.yml
13:14:14  adapter type: duckdb
13:14:14  adapter version: 1.10.1
13:14:15  Configuration:
13:14:15    profiles.yml file [OK found and valid]
13:14:15    dbt_project.yml file [OK found and valid]
13:14:15  Required dependencies:
13:14:15   - git [OK found]

13:14:15  Connection:
13:14:15    database: taxi_rides_ny
13:14:15    schema: dev
13:14:15    path: taxi_rides_ny.duckdb
13:14:15    config_options: None
13:14:15    extensions: ['parquet']
13:14:15    settings: {'memory_limit': '2GB', 'preserve_insertion_order': False}    
13:14:15    external_root: .
13:14:15    use_credential_provider: None
13:14:15    attach: None
13:14:15    filesystems: None
13:14:15    remote: None
13:14:15    plugins: None
13:14:15    disable_transactions: False
13:14:15  Registered adapter: duckdb=1.10.1
13:14:15    Connection test: [OK connection ok]

13:14:15  All checks passed!

### 15. Install the dbt Power User Extension (VS Code Users)
1.dbt
2.Power User for dbt(Altimate Inc)