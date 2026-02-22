# Data Engineering Zoomcamp 2026

This repository has been created as part of the **Data Engineering Zoomcamp 2026**.

## Resources

- **YouTube Playlist**: [Data Engineering Zoomcamp](https://www.youtube.com/watch?v=lP8xXebHmuE&list=PL3MmuxUbc_hJed7dXYoJw8DoCuVHhGEQb&index=3)
- **GitHub Repository (Fork)**: [DataTalksClub/data-engineering-zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp)
- **Scoreboard and Homework Ratings**: [DE Zoomcamp 2026 Course](https://courses.datatalks.club/de-zoomcamp-2026/)

## Folder Structure

### 1. docker-terraform

This folder contains practical examples of using Docker and Terraform. The following use cases are covered:

- **Docker Basics**: Learn how to create and manage Docker containers.
- **Docker Compose**: Set up multi-container applications.
- **Terraform Basics**: Manage infrastructure as code using Terraform.

### 2. kestra 


This folder contains practical examples and use cases of workflow orchestration using [Kestra](https://kestra.io/).

#### Example Use Cases

Below are some of the flows implemented in `/workflow-orchestration/flows/`:

- **Hello World Flow** (`01_hello_world.yaml`):
	- Simple workflow that takes a name as input and logs a personalized welcome message.

- **Python Script in Docker** (`02_python.yaml`):
	- Runs a Python script in a Docker container to fetch and display the number of downloads for the Kestra Docker image using the Docker Hub API.

- **Getting Started Data Pipeline** (`03_getting_started_with_data_pipeline.yaml`):
	- Downloads product data from a public API, transforms it using Python, and demonstrates basic ETL (Extract, Transform, Load) concepts.

- **NYC Taxi Data to Postgres** (`04_postgres_taxi.yaml`):
	- Parameterized workflow to ingest NYC taxi trip data (yellow/green, year, month) into a Postgres database. Demonstrates data ingestion and transformation.

- **Scheduled NYC Taxi Data Pipeline** (`05_postgres_taxi_scheduled.yaml`):
	- Similar to the above, but scheduled for automated, periodic ingestion. Supports backfill and uses variables for dynamic file/table naming.

- **GCP Key-Value Management** (`06_gcp_kv.yaml`):
	- Sets Google Cloud Platform project, location, and bucket name as key-value pairs for use in other workflows.

- **GCP Key-Value Management** (`06_gcp_kv.yaml`):
	- Sets Google Cloud Platform project, location, and bucket name as key-value pairs for use in other workflows.

---

- **GCP Setup** (`07_gcp_setup.yaml`):
	- Creates a Google Cloud Storage bucket and a BigQuery dataset using values from key-value and secret stores. Demonstrates cloud resource provisioning with Kestra plugins.

- **GCP NYC Taxi Data Pipeline** (`08_gcp_taxi.yaml`):
	- Parameterized workflow to extract NYC taxi data, upload it to GCS, and load it into BigQuery. Supports selection of taxi type, year, and month.

- **Scheduled GCP NYC Taxi Pipeline** (`09_gcp_taxi_scheduled.yaml`):
	- Automates the ingestion of NYC taxi data into GCS and BigQuery on a schedule, supporting backfill and dynamic file/table naming.

- **Chat Without RAG** (`10_chat_without_rag.yaml`):
	- Demonstrates querying a Large Language Model (LLM) about Kestra 1.1 features without Retrieval Augmented Generation (RAG), highlighting the limitations of LLMs without external context.

- **Chat With RAG** (`11_chat_with_rag.yaml`):
	- Demonstrates RAG by ingesting Kestra release documentation and using it to answer questions accurately. Compares results with and without RAG for context-aware responses.