--Query Publicly available data
SELECT station_id,name FROM bigquery-public-data.new_york_citibike.citibike_stations LIMIT 100;

--Create a bucket in the us-central1 region using cloud shell
gcloud storage buckets create gs://taxinyride --location=us-central1

--Method#1
--Use wget to pull the data to the home shell directory in cloud shell
wget https://d37ci6vzurychx.cloudfront.net/trip-data/yellow_tripdata_2019-01.parquet
Repeat it for 2019-02.. 2019-12
Repeat it for 2020-01.. 2020-12

--Move the files to a separate folder in the home shell directory in cloud shell
mv yellow_tripdata*.parquet yellow_tripdata/

--Upload the files to the bucket that is created
gcloud storage cp -r yellow_tripdata/ gs://taxinyride/

--Method#2
--Test the availablity of the files from Cloud shell using Curl Command , Refer Curl Command Test query
--Write a bash script in cloud shell, Refer ShellScript-Copy


-- Creating external table referring to gcs path

--Workaround for resolving the error :
/*Error while reading table: bigquerydemo-dezoomcamp.nytaxi.external_yellow_tripdata, error message: Parquet column 'airport_fee' has type INT32 which does not match the target cpp_type DOUBLE. File: gs://taxinyride/yellow_tripdata_2019-04.parquet*/
--Creating 2 different external tables and then doing a union
/*Error while reading table: bigquerydemo-dezoomcamp.nytaxi.external_yellow_tripdata, error message: Parquet column 'airport_fee' has type INT32 which does not match the target cpp_type DOUBLE. File: gs://taxinyride/yellow_tripdata_2020-04.parquet*/

-- Creating external table referring to gcs path
CREATE OR REPLACE EXTERNAL TABLE `bigquerydemo-dezoomcamp.nytaxi.external_yellow_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://taxinyride/yellow_tripdata_2019-*.parquet']
);

--Bucket name : taxinyride
--folder : taxi-data
--file_name : yellow_tripdata_2019-*.parquet [Includes all the files in the year 2019 monthly files]
--file_name : yellow_tripdata_2020-*.parquet [Includes all the files in the year 2020 monthly files]
--project : bigquerydemo-dezoomcamp [will be created under GCP Project : bigquerydemo-dezoomcamp]
--dataset : nytaxi will be created under project : bigquerydemo-dezoomcamp
--table_name : external_yellow_tripdata wil be created under dataset : nytaxi
--Create a local bucket in the project : bigquerydemo-dezoomcamp 


--query the table : bigquerydemo-dezoomcamp.external_yellow_tripdata
select * from bigquerydemo-dezoomcamp.nytaxi.external_yellow_tripdata limit 10

-- Create a non partitioned table from external table
CREATE OR REPLACE TABLE bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_non_partitioned AS
SELECT * FROM bigquerydemo-dezoomcamp.nytaxi.external_yellow_tripdata;

--1.26 GB Scan
SELECT DISTINCT(VendorID)
FROM bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_non_partitioned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

-- Create a partitioned table from external table
CREATE OR REPLACE TABLE bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_partitioned
PARTITION BY
  DATE(tpep_pickup_datetime) AS
SELECT * FROM bigquerydemo-dezoomcamp.nytaxi.external_yellow_tripdata;

-- Impact of partition
-- Scanning 106.37 MB of data
SELECT DISTINCT(VendorID)
FROM bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_partitioned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2019-06-30';

--There is a 10x reduction while Scanning the table when the table has been partitioned


-- Let's look into the partitions
SELECT table_name, partition_id, total_rows
FROM `nytaxi.INFORMATION_SCHEMA.PARTITIONS`
WHERE table_name = 'yellow_tripdata_partitioned'
ORDER BY total_rows DESC;

-- Creating a partition and cluster table
CREATE OR REPLACE TABLE bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_partitioned_clustered
PARTITION BY DATE(tpep_pickup_datetime)
CLUSTER BY VendorID AS
SELECT * FROM bigquerydemo-dezoomcamp.nytaxi.external_yellow_tripdata;

-- Query scans 715.8 MB
SELECT count(*) as trips
FROM bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_partitioned
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND VendorID=1;

-- Query scans 715.8 MB
SELECT count(*) as trips
FROM bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_partitioned_clustered
WHERE DATE(tpep_pickup_datetime) BETWEEN '2019-06-01' AND '2020-12-31'
  AND VendorID=1;
--Dont see much difference here as i have not used the 2020-01 to 2020-12 data in these tables.

