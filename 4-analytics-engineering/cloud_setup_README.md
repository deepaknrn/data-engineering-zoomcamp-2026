---
# Analytics Engineering Workshop

This repository is based on the **Data Engineering Zoomcamp 2026 - Analytics Engineering Workshop**.

- YouTube playlist: [Watch here](https://www.youtube.com/watch?v=J0XCDyKiU64&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=32)
- Learn more about dbt: [dbt website](https://www.getdbt.com/lp/persona-paths?utm_medium=paid-search&utm_source=google&utm_campaign=q1-2025_apac-nonbrand-datatransformation_co&utm_content=_kw-datatransformationtools-ph___&utm_term=all_apac_anz&cq_cmp=21195055622&utm_term=data%20transformation&utm_campaign=&utm_source=adwords&utm_medium=ppc&hsa_acc=8253637521&hsa_cam=21195055622&hsa_grp=164743458161&hsa_ad=783662596456&hsa_src=g&hsa_tgt=kwd-18219416&hsa_kw=data%20transformation&hsa_mt=b&hsa_net=adwords&hsa_ver=3&gad_source=1&gad_campaignid=21195055622&gbraid=0AAAAABONxYjvxm0rcX3RlX-eBKuTvHBeR&gclid=CjwKCAiAkvDMBhBMEiwAnUA9BfYl5ZmRg3dm1BSn8wkftm3XOrpFFxBwXtvclKbit93jxEYBlddWPRoC-FUQAvD_BwE)

Reference: [cloud_setup.md](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/04-analytics-engineering/setup/cloud_setup.md)
YouTube: [Watch setup video](https://www.youtube.com/watch?v=GFbwlrt6f54)

---

## 1. Enable BigQuery API

- Search for "BigQuery API" in the Google Cloud console and ensure it is enabled.

## 2. Create a Service Account, JSON Key, and Assign Permissions

Example service account:
`bigquerydemodezoomcamp@bigquerydemo-dezoomcamp.iam.gserviceaccount.com`

Assign the following permissions:
- BigQuery Data Editor
- BigQuery Job User
- BigQuery User
- Storage Object Admin
- Storage Object Viewer
- Storage Object Creator

## 3. Sign Up with dbt

- [Create a free dbt Cloud account](https://getdbt.com/signup)

## 4. Create a New Project

- Example project name: `dezoomcamp2026_analyticsengineering`

## 5. Configure the Connection for the Project

- Add a new connection (BigQuery)
- Supported connections: Snowflake, PostgreSQL, BigQuery, Redshift, Databricks, Apache Spark, Synapse, Fabric, Athena, Teradata
- Select Adapter: BigQuery
- Upload the service account file (from Step 2)

## 6. Configure Account Integrations (Git Integrations)

- Link your GitHub repo to the dbt project (alternatively, use GitLab or Azure DevOps)
- If you don’t want to link, use a dbt-managed repo

## 7. Set Up the Environment

- Configure environments (dev/prod)
- Minimum: 1 dev environment required

Example:
    - Environment Name: Development
    - Environment Type: Deployment
    - Set Deployment Type: General
    - dbt Version: Latest
    - Connection Profile: bigquerydemodezoomcamp2026

Development Credentials:
    - Dataset: dbt_dnarayanekkanathkesavan
    - Target Name: default (can be dev/prod based on environment)
    - Threads: --

## 8. Test the Connection

- Ensure the connection to BigQuery works

## 9. Initialize the dbt Project

- Click "Initialize the dbt project" in dbt Cloud
- This creates the dbt project structure:

```
|- dbt-cloud-x-<projectname>
        |- analyses
        |- macros
        |- models
                |- examples
        |- seeds
        |- snapshots
        |- tests
.gitignore
dbt_project.yml
README.md
```

## 10. Commit to a New Branch

## 11. Create a New Branch



