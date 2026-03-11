
## 3-data-warehouse


### Pre-requisites

Before running the scripts or exporting models, ensure you have the following installed and configured on your system:

- **Google Cloud SDK (gcloud):** Required for authentication, interacting with Google Cloud Storage, and using BigQuery command-line tools.
	- [Install Google Cloud SDK](https://cloud.google.com/sdk/docs/install)
	- After installation, run `gcloud auth login` and set your project with `gcloud config set project <your-project-id>`.

- **Postman:** Recommended for testing the model API endpoints after serving the model with TensorFlow Serving.
	- [Download Postman](https://www.postman.com/downloads/)

This folder contains resources, scripts, and SQL files for working with data warehouses, BigQuery, and machine learning model serving as part of the Data Engineering Zoomcamp.

### Contents

- **Bigquerydemo-dezoomcamp.sql**  
	SQL scripts for querying public datasets, creating GCS buckets, uploading data, and creating external tables in BigQuery.

- **big_query_ml.sql**  
	SQL scripts for feature selection, table creation, and building a linear regression ML model (`tip_model`) in BigQuery ML.

- **taxinyride_2024.sql**  
	SQL for working with 2024 Yellow Taxi data, including external table creation, record counting, and data scan estimation.

- **ShellScript-Copy**  
	Bash script to automate downloading monthly yellow taxi parquet files and uploading them to a Google Cloud Storage bucket.

- **ml_model_export_docker**  
	Step-by-step instructions for exporting a BigQuery ML model, copying it to the correct directory structure, and serving it with TensorFlow Serving in Docker. Includes example API requests for model inference.

- **serving_dir/**  
	Directory containing the exported TensorFlow SavedModel for the `tip_model`.  
	- `tip_model/1/` contains:
		- `saved_model.pb` (model file)
		- `assets/` (lookup files)
		- `variables/` (model variables)
		- `explanation_metadata.json`, `fingerprint.pb`

- **curl_command_test**  
	(File for testing curl commands; details not shown here.)

---

### Model Serving Example
After exporting and copying the model, you can serve it with:
```sh
docker run -p 8501:8501 --mount type=bind,source=$(pwd)/3-data-warehouse/serving_dir/tip_model,target=/models/tip_model -e MODEL_NAME=tip_model -t tensorflow/serving
```

#### Test the Model API
- **GET**:  
	`http://localhost:8501/v1/models/tip_model`
- **POST**:  
	`http://localhost:8501/v1/models/tip_model:predict`
	```json
	{
		"instances": [
			{
				"passenger_count": 1,
				"trip_distance": 12.2,
				"PULocationID": "193",
				"DOLocationID": "264",
				"payment_type": "2",
				"fare_amount": 20.4,
				"tolls_amount": 0.0
			}
		]
	}
	```

---

For more details, see the referenced scripts and SQL files in this directory.
