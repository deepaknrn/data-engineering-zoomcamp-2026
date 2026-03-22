Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test
- dbt seed   
#once the seed is uploaded (sample .csv files) . This results in csv file being accessable as a dbt model inside the project


### Resources:
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices


### Important Commands:
dbt init 
- This is for initializing the project and it needs to be run only once in the beginning of the project. This will create the project directory and structure. 
Folders like /models, /seeds, /analyses, /tests, /macros , /snapshots  are created

dbt debug
- It checks the profiles.yml and sees if its a valid yaml and contains valid information regarding the connection profiles (Database)
The example here used is duckdb , hence everything related to local duck db configuration is validated

dbt seed
- Ingest all the .csv's present in the /seeds folder and then it can be used as a ref('') reference in the SQL for the models

dbt snapshot

dbt source freshness
-This will help dbt find out if the data is stale or not

dbt docs generate
-This will generate the docs / artifact called catalog.json which can be served as a dbt documentation using 

dbt docs serve
Browse the website as a localhost (in the local environment)
dbt serve is automatically generated in dbt cloud and you need not worry about it

dbt clean
packages and target configured in the dbt_project.yml wil be cleared

dbt deps
to install the packages specified in the packages.yml file

dbt compile
it will scan all the code under /target folder compiled  and then creates a compile folder and places the code that wil be sent to the database without the jinja templates in the SQL

dbt run
It takes every single model in the dbt project and it materializes it (by default it will be a view)
It can be configured as a table,view,incremental,ephimeral

dbt test
It takes all of the tests in the dbt project \tests folder 
singularity test,freshness test,generic test,custom generic test,unit test,model contract and then it runs them

dbt build = [dbt run + dbt test + dbt seed + dbt snapshot + UDF's]
To build a specific model use dbt build --select <stg_greentrip_data> [don't put .sql here]

dbt retry 
Instead of dbt build from the beginning , it retries from the point of failure.This will save the resources in the computer

dbt --help or dbt -h
overview of all of the possiblities

dbt --version or dbt -v 
version of dbt installed 

dbt run --full-refresh
Instead of adding the data incrementally it will drop all the model and recreate and upload the data from scratch

dbt run --fail-fast

dbt test or dbt test -t prod
by default the target will be (Dev/prod) based on what is set in profiles.yml
dbt test -t dev will run the test of the model in the dev, This is mandatory before doing any code migration as this will identify if any issues are there in the model.

dbt run --select 
<select a specify model without the .sql extension>

dbt run --select int_trips_unioned (will only run this model)
dbt run --select +int_trips_unioned ( will run the models prior to it as per the lineage (Dependent ones))
dbt run --select int_trips_unioned+ (will run the modes after it as per the lineage (Dependent ones))
dbt run --select +int_trips_unioned+ (will run both upstream and downstream dependencies)