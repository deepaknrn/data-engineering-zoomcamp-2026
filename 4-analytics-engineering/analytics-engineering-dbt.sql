DROP TABLE IF EXISTS `bigquerydemo-dezoomcamp.nytaxi.external_yellow_tripdata_2019_2020`;

CREATE OR REPLACE EXTERNAL TABLE `bigquerydemo-dezoomcamp.nytaxi.external_yellow_tripdata_2019_2020`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://taxinyride/yellow_tripdata_*.parquet']
);

SELECT count(*) from `bigquerydemo-dezoomcamp.nytaxi.external_yellow_tripdata_2019_2020`;

DROP TABLE IF EXISTS `bigquerydemo-dezoomcamp.nytaxi.external_green_tripdata_2019_2020`;

CREATE OR REPLACE EXTERNAL TABLE `bigquerydemo-dezoomcamp.nytaxi.external_green_tripdata_2019_2020`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://taxinyride_green/green_tripdata_*.parquet']
);

SELECT count(*) from `bigquerydemo-dezoomcamp.nytaxi.external_green_tripdata_2019_2020`;
