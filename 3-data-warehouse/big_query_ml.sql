--big_query_ml.sql

-- SELECT THE COLUMNS INTERESTED FOR YOU
SELECT passenger_count, trip_distance, PULocationID, DOLocationID, payment_type, fare_amount, tolls_amount, tip_amount
FROM `bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_partitioned` WHERE fare_amount != 0;

-- CREATE A ML TABLE WITH APPROPRIATE TYPE
--AUTOMATIC PREPROCESSING 
--ONE HOT ENCODING (columns : PULocationID,DOLocationID,payment_type)
CREATE OR REPLACE TABLE `bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_ml` (
`passenger_count` INT64,
`trip_distance` FLOAT64,
`PULocationID` STRING,
`DOLocationID` STRING,
`payment_type` STRING,
`fare_amount` FLOAT64,
`tolls_amount` FLOAT64,
`tip_amount` FLOAT64
) AS (
SELECT CAST(passenger_count AS INT64), trip_distance, cast(PULocationID AS STRING), CAST(DOLocationID AS STRING),
CAST(payment_type AS STRING), fare_amount, tolls_amount, tip_amount
FROM `bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_partitioned` WHERE fare_amount != 0
);


-- CREATE MODEL WITH DEFAULT SETTING
CREATE OR REPLACE MODEL `bigquerydemo-dezoomcamp.nytaxi.tip_model`
OPTIONS
(model_type='linear_reg',
input_label_cols=['tip_amount'],
DATA_SPLIT_METHOD='AUTO_SPLIT') AS
SELECT
*
FROM
`bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_ml`
WHERE
tip_amount IS NOT NULL;

-- CHECK FEATURES
SELECT * FROM ML.FEATURE_INFO(MODEL `bigquerydemo-dezoomcamp.nytaxi.tip_model`);

--EVALUATE THE MODEL
SELECT
*
FROM
ML.EVALUATE(MODEL `bigquerydemo-dezoomcamp.nytaxi.tip_model`,
(
SELECT
*
FROM
`bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_ml`
WHERE
tip_amount IS NOT NULL
));


-- PREDICT THE MODEL
SELECT
*
FROM
ML.PREDICT(MODEL `bigquerydemo-dezoomcamp.nytaxi.tip_model`,
(
SELECT
*
FROM
`bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_ml`
WHERE
tip_amount IS NOT NULL
));


-- PREDICT AND EXPLAIN
SELECT
*
FROM
ML.EXPLAIN_PREDICT(MODEL `bigquerydemo-dezoomcamp.nytaxi.tip_model`,
(
SELECT
*
FROM
`bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_ml`
WHERE
tip_amount IS NOT NULL
), STRUCT(3 as top_k_features));



-- HYPER PARAM TUNNING
CREATE OR REPLACE MODEL `bigquerydemo-dezoomcamp.nytaxi.tip_hyperparam_model`
OPTIONS
(model_type='linear_reg',
input_label_cols=['tip_amount'],
DATA_SPLIT_METHOD='AUTO_SPLIT',
num_trials=5,
max_parallel_trials=2,
l1_reg=hparam_range(0, 20),
l2_reg=hparam_candidates([0, 0.1, 1, 10])) AS
SELECT
*
FROM
`bigquerydemo-dezoomcamp.nytaxi.yellow_tripdata_ml`
WHERE
tip_amount IS NOT NULL;
